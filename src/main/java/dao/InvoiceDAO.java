package dao;

import model.Invoice;
import model.enums.InvoiceStatus;
import model.enums.PaymentMethod;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InvoiceDAO {

    /**
     * Find invoice by ID
     */
    public Invoice findById(int invoiceId) throws SQLException {
        String sql = "SELECT * FROM tblInvoice WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, invoiceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToInvoice(rs);
                }
            }
        }
        return null;
    }

    /**
     * Find invoices by order ID
     */
    public List<Invoice> findByOrderId(int orderId) throws SQLException {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "SELECT * FROM tblInvoice WHERE orderId = ? ORDER BY issueDate DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    invoices.add(mapResultSetToInvoice(rs));
                }
            }
        }
        return invoices;
    }

    /**
     * Map ResultSet to Invoice object
     */
    private Invoice mapResultSetToInvoice(ResultSet rs) throws SQLException {
        Invoice invoice = new Invoice();
        invoice.setId(rs.getInt("id"));
        invoice.setInvoiceNumber(rs.getString("invoiceNumber"));
        invoice.setIssueDate(rs.getTimestamp("issueDate"));

        String paymentMethodStr = rs.getString("paymentMethod");
        invoice.setPaymentMethod(paymentMethodStr != null ? PaymentMethod.valueOf(paymentMethodStr) : null);

        String statusStr = rs.getString("status");
        invoice.setStatus(statusStr != null ? InvoiceStatus.valueOf(statusStr) : null);

        invoice.setTotal(rs.getBigDecimal("total"));
        invoice.setPaidAmount(rs.getBigDecimal("paidAmount"));
        invoice.setOrderId(rs.getInt("orderId"));

        Integer cashierStaffId = rs.getObject("cashierStaffId", Integer.class);
        invoice.setCashierStaffId(cashierStaffId);

        return invoice;
    }
}
