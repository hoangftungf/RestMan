package dao;

import model.enums.InvoiceStatus;
import model.enums.MembershipTier;
import model.vm.CustomerRevenueRow;
import model.vm.OrderDetailVM;
import util.DBUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for reporting and analytics queries
 */
public class ReportingDAO {

    /**
     * Get customer revenue report with filtering and pagination
     */
    public List<CustomerRevenueRow> customerRevenue(Timestamp fromDate, Timestamp toDate,
                                                     MembershipTier tier, BigDecimal minRevenue,
                                                     Integer topN, boolean includeUnpaid,
                                                     int page, int pageSize) throws SQLException {
        List<CustomerRevenueRow> results = new ArrayList<>();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT c.id as customerId, c.fullName, c.phone, c.email, ");
        sql.append("mc.tier, ");
        sql.append("COUNT(DISTINCT o.id) as orderCount, ");
        sql.append("COUNT(DISTINCT i.id) as invoiceCount, ");
        sql.append("COALESCE(SUM(i.total), 0) as totalRevenue ");
        sql.append("FROM tblCustomer c ");
        sql.append("INNER JOIN tblOrder o ON c.id = o.customerId ");
        sql.append("INNER JOIN tblInvoice i ON o.id = i.orderId ");
        sql.append("LEFT JOIN tblMembershipCard mc ON c.id = mc.customerId ");
        sql.append("WHERE i.issueDate BETWEEN ? AND ? ");

        // Filter by invoice status
        if (!includeUnpaid) {
            sql.append("AND i.status IN ('PAID', 'PARTIALLY_PAID') ");
        }

        // Filter by membership tier
        if (tier != null) {
            sql.append("AND mc.tier = ? ");
        }

        sql.append("GROUP BY c.id, c.fullName, c.phone, c.email, mc.tier ");

        // Filter by minimum revenue
        if (minRevenue != null) {
            sql.append("HAVING totalRevenue >= ? ");
        }

        sql.append("ORDER BY totalRevenue DESC ");

        // Limit to top N if specified
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
                    row.setCustomerId(rs.getInt("customerId"));
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
     * Get customer orders within date range
     */
    public List<OrderDetailVM> customerOrders(int customerId, Timestamp fromDate, Timestamp toDate) throws SQLException {
        List<OrderDetailVM> orders = new ArrayList<>();

        String sql = "SELECT DISTINCT o.id as orderId, o.orderNumber, o.createdAt, " +
                     "i.status as invoiceStatus " +
                     "FROM tblOrder o " +
                     "INNER JOIN tblInvoice i ON o.id = i.orderId " +
                     "WHERE o.customerId = ? " +
                     "AND i.issueDate BETWEEN ? AND ? " +
                     "AND i.status IN ('PAID', 'PARTIALLY_PAID') " +
                     "ORDER BY o.createdAt DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ps.setTimestamp(2, fromDate);
            ps.setTimestamp(3, toDate);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetailVM order = new OrderDetailVM();
                    order.setOrderId(rs.getInt("orderId"));
                    order.setOrderNumber(rs.getString("orderNumber"));
                    order.setCreatedAt(rs.getTimestamp("createdAt"));

                    String statusStr = rs.getString("invoiceStatus");
                    order.setInvoiceStatus(statusStr != null ? InvoiceStatus.valueOf(statusStr) : null);

                    orders.add(order);
                }
            }
        }
        return orders;
    }

    /**
     * Count total customers matching the revenue filter
     */
    public int countCustomerRevenue(Timestamp fromDate, Timestamp toDate,
                                     MembershipTier tier, BigDecimal minRevenue,
                                     boolean includeUnpaid) throws SQLException {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(DISTINCT c.id) ");
        sql.append("FROM tblCustomer c ");
        sql.append("INNER JOIN tblOrder o ON c.id = o.customerId ");
        sql.append("INNER JOIN tblInvoice i ON o.id = i.orderId ");
        sql.append("LEFT JOIN tblMembershipCard mc ON c.id = mc.customerId ");
        sql.append("WHERE i.issueDate BETWEEN ? AND ? ");

        if (!includeUnpaid) {
            sql.append("AND i.status IN ('PAID', 'PARTIALLY_PAID') ");
        }

        if (tier != null) {
            sql.append("AND mc.tier = ? ");
        }

        if (minRevenue != null) {
            sql.append("GROUP BY c.id HAVING SUM(i.total) >= ? ");
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

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
}
