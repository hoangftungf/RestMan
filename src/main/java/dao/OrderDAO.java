package dao;

import model.Order;
import model.OrderItem;
import model.enums.OrderChannel;
import model.enums.OrderStatus;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    /**
     * Find order by ID
     */
    public Order findById(int orderId) throws SQLException {
        String sql = "SELECT * FROM tblOrder WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToOrder(rs);
                }
            }
        }
        return null;
    }

    /**
     * Find order items by order ID
     */
    public List<OrderItem> findItems(int orderId) throws SQLException {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, d.name as dishName " +
                     "FROM tblOrderItem oi " +
                     "LEFT JOIN tblDish d ON oi.dishId = d.id " +
                     "WHERE oi.orderId = ? " +
                     "ORDER BY oi.id";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setUnitPrice(rs.getBigDecimal("unitPrice"));
                    item.setDiscount(rs.getBigDecimal("discount"));
                    item.setNote(rs.getString("note"));
                    item.setOrderId(rs.getInt("orderId"));

                    Integer dishId = rs.getObject("dishId", Integer.class);
                    item.setDishId(dishId);

                    Integer comboId = rs.getObject("comboId", Integer.class);
                    item.setComboId(comboId);

                    items.add(item);
                }
            }
        }
        return items;
    }

    /**
     * Map ResultSet to Order object
     */
    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setOrderNumber(rs.getString("orderNumber"));

        String channelStr = rs.getString("channel");
        order.setChannel(channelStr != null ? OrderChannel.valueOf(channelStr) : null);

        String statusStr = rs.getString("status");
        order.setStatus(statusStr != null ? OrderStatus.valueOf(statusStr) : null);

        order.setCreatedAt(rs.getTimestamp("createdAt"));
        order.setUpdatedAt(rs.getTimestamp("updatedAt"));

        Integer customerId = rs.getObject("customerId", Integer.class);
        order.setCustomerId(customerId);

        Integer saleStaffId = rs.getObject("saleStaffId", Integer.class);
        order.setSaleStaffId(saleStaffId);

        Integer tableId = rs.getObject("tableId", Integer.class);
        order.setTableId(tableId);

        return order;
    }
}
