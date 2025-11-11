package dao;

import model.Order;
import model.OrderItem;
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
                    item.setDishName(rs.getString("dishName"));

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
        order.setName(rs.getString("name"));
        order.setEmail(rs.getString("email"));
        order.setPhone(rs.getString("phone"));
        order.setNumberOfGuests(rs.getObject("number", Integer.class));
        order.setNote(rs.getString("note"));

        String statusStr = rs.getString("status");
        order.setStatus(statusStr != null ? OrderStatus.valueOf(statusStr) : null);

        order.setSubTotal(rs.getBigDecimal("subTotal"));
        order.setCreatedAt(rs.getTimestamp("createAt"));
        order.setUpdatedAt(rs.getTimestamp("updateAt"));

        Integer tableId = rs.getObject("tblTableId", Integer.class);
        order.setTableId(tableId);

        Integer accountId = rs.getObject("tblAccountId", Integer.class);
        order.setAccountId(accountId);

        return order;
    }
}
