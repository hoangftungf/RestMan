package dao;

import model.enums.InvoiceStatus;
import model.enums.MembershipTier;
import model.enums.OrderStatus;
import model.vm.CustomerRevenueRow;
import model.vm.OrderDetailVM;
import util.DBUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for reporting and analytics queries aligned with the redesigned schema.
 */
public class ReportingDAO {

    /**
     * Build revenue report rows that include both account customers and walk-in guests.
     */
    public List<CustomerRevenueRow> customerRevenue(Timestamp fromDate, Timestamp toDate,
                                                    MembershipTier tier, BigDecimal minRevenue,
                                                    Integer topN, boolean includeUnpaid,
                                                    int page, int pageSize) throws SQLException {
        List<CustomerRevenueRow> results = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT ");
        sql.append("CASE WHEN o.tblAccountId IS NOT NULL THEN CONCAT('ACC-', o.tblAccountId) ");
        sql.append("     ELSE CONCAT('GUEST-', COALESCE(o.phone,''), '-', COALESCE(o.email,''), '-', COALESCE(o.name,'')) ");
        sql.append("END AS customerKey, ");
        sql.append("o.tblAccountId AS accountId, ");
        sql.append("o.tblAccountId IS NULL AS isGuest, ");
        sql.append("COALESCE(a.fullName, o.name) AS fullName, ");
        sql.append("COALESCE(a.phone, o.phone) AS phone, ");
        sql.append("COALESCE(a.email, o.email) AS email, ");
        sql.append("mc.tier, ");
        sql.append("COUNT(DISTINCT o.id) AS orderCount, ");
        sql.append("COUNT(DISTINCT i.id) AS invoiceCount, ");
        sql.append("COALESCE(SUM(i.total), 0) AS totalRevenue ");
        sql.append("FROM tblOrder o ");
        sql.append("INNER JOIN tblInvoice i ON o.id = i.tblOrderId ");
        sql.append("LEFT JOIN tblAccount a ON o.tblAccountId = a.id ");
        sql.append("LEFT JOIN tblMembershipCard mc ON o.tblAccountId = mc.customerId ");
        sql.append("WHERE o.createAt BETWEEN ? AND ? ");

        if (!includeUnpaid) {
            sql.append("AND i.status IN ('PAID', 'PARTIALLY_PAID') ");
        }

        if (tier != null) {
            sql.append("AND mc.tier = ? ");
        }

        sql.append("GROUP BY customerKey, o.tblAccountId, isGuest, fullName, phone, email, mc.tier ");

        if (minRevenue != null) {
            sql.append("HAVING totalRevenue >= ? ");
        }

        sql.append("ORDER BY totalRevenue DESC ");

        if (topN != null && topN > 0) {
            sql.append("LIMIT ? ");
        } else {
            sql.append("LIMIT ? OFFSET ? ");
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            ps.setTimestamp(paramIndex++, fromDate);
            ps.setTimestamp(paramIndex++, toDate);

            if (tier != null) {
                ps.setString(paramIndex++, tier.name());
            }

            if (minRevenue != null) {
                ps.setBigDecimal(paramIndex++, minRevenue);
            }

            if (topN != null && topN > 0) {
                ps.setInt(paramIndex++, topN);
            } else {
                ps.setInt(paramIndex++, pageSize);
                ps.setInt(paramIndex++, (page - 1) * pageSize);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CustomerRevenueRow row = new CustomerRevenueRow();
                    row.setCustomerKey(rs.getString("customerKey"));
                    row.setAccountId(rs.getObject("accountId", Integer.class));
                    row.setGuest(rs.getBoolean("isGuest"));
                    row.setFullName(rs.getString("fullName"));
                    row.setPhone(rs.getString("phone"));
                    row.setEmail(rs.getString("email"));

                    String tierStr = rs.getString("tier");
                    row.setTier(tierStr != null ? MembershipTier.valueOf(tierStr) : null);

                    row.setOrderCount(rs.getInt("orderCount"));
                    row.setInvoiceCount(rs.getInt("invoiceCount"));
                    row.setTotalRevenue(rs.getBigDecimal("totalRevenue"));
                    results.add(row);
                }
            }
        }
        return results;
    }

    /**
     * Count grouped customers for pagination.
     */
    public int countCustomerRevenue(Timestamp fromDate, Timestamp toDate,
                                    MembershipTier tier, BigDecimal minRevenue,
                                    boolean includeUnpaid) throws SQLException {
        StringBuilder base = new StringBuilder();
        base.append("SELECT ");
        base.append("CASE WHEN o.tblAccountId IS NOT NULL THEN CONCAT('ACC-', o.tblAccountId) ");
        base.append("     ELSE CONCAT('GUEST-', COALESCE(o.phone,''), '-', COALESCE(o.email,''), '-', COALESCE(o.name,'')) ");
        base.append("END AS customerKey, ");
        base.append("COALESCE(SUM(i.total), 0) AS totalRevenue ");
        base.append("FROM tblOrder o ");
        base.append("INNER JOIN tblInvoice i ON o.id = i.tblOrderId ");
        base.append("LEFT JOIN tblMembershipCard mc ON o.tblAccountId = mc.customerId ");
        base.append("WHERE o.createAt BETWEEN ? AND ? ");

        if (!includeUnpaid) {
            base.append("AND i.status IN ('PAID', 'PARTIALLY_PAID') ");
        }

        if (tier != null) {
            base.append("AND mc.tier = ? ");
        }

        base.append("GROUP BY customerKey ");

        if (minRevenue != null) {
            base.append("HAVING totalRevenue >= ? ");
        }

        String countSql = "SELECT COUNT(*) FROM (" + base + ") grouped";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(countSql)) {

            int paramIndex = 1;
            ps.setTimestamp(paramIndex++, fromDate);
            ps.setTimestamp(paramIndex++, toDate);

            if (tier != null) {
                ps.setString(paramIndex++, tier.name());
            }

            if (minRevenue != null) {
                ps.setBigDecimal(paramIndex++, minRevenue);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    /**
     * Fetch orders linked to either an account customer or a guest (identified by contact info).
     */
    public List<OrderDetailVM> customerOrders(boolean guest, Integer accountId,
                                              String guestName, String guestPhone, String guestEmail,
                                              Timestamp fromDate, Timestamp toDate) throws SQLException {
        List<OrderDetailVM> orders = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT DISTINCT o.id AS orderId, o.createAt AS createdAt, o.status AS orderStatus, ");
        sql.append("i.status AS invoiceStatus, COALESCE(a.fullName, o.name) AS fullName, ");
        sql.append("COALESCE(a.phone, o.phone) AS phone ");
        sql.append("FROM tblOrder o ");
        sql.append("INNER JOIN tblInvoice i ON o.id = i.tblOrderId ");
        sql.append("LEFT JOIN tblAccount a ON o.tblAccountId = a.id ");
        sql.append("WHERE o.createAt BETWEEN ? AND ? ");
        sql.append("AND i.status IN ('PAID', 'PARTIALLY_PAID') ");

        if (guest) {
            sql.append("AND o.tblAccountId IS NULL ");
            sql.append("AND COALESCE(o.name, '') = ? ");
            sql.append("AND COALESCE(o.phone, '') = ? ");
            sql.append("AND COALESCE(o.email, '') = ? ");
        } else {
            sql.append("AND o.tblAccountId = ? ");
        }

        sql.append("ORDER BY o.createAt DESC");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            ps.setTimestamp(paramIndex++, fromDate);
            ps.setTimestamp(paramIndex++, toDate);

            if (guest) {
                ps.setString(paramIndex++, guestName != null ? guestName : "");
                ps.setString(paramIndex++, guestPhone != null ? guestPhone : "");
                ps.setString(paramIndex++, guestEmail != null ? guestEmail : "");
            } else {
                ps.setInt(paramIndex++, accountId);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetailVM vm = new OrderDetailVM();
                    vm.setOrderId(rs.getInt("orderId"));
                    vm.setCreatedAt(rs.getTimestamp("createdAt"));

                    String invoiceStatus = rs.getString("invoiceStatus");
                    vm.setInvoiceStatus(invoiceStatus != null ? InvoiceStatus.valueOf(invoiceStatus) : null);

                    String orderStatus = rs.getString("orderStatus");
                    vm.setOrderStatus(orderStatus != null ? OrderStatus.valueOf(orderStatus) : null);

                    vm.setCustomerName(rs.getString("fullName"));
                    vm.setPhone(rs.getString("phone"));
                    orders.add(vm);
                }
            }
        }
        return orders;
    }
}
