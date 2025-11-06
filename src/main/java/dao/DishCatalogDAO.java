package dao;

import model.vm.DishCardVM;
import model.vm.DishDetailVM;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for customer dish catalog functionality
 */
public class DishCatalogDAO {

    /**
     * Find dish by ID for detail view
     */
    public DishDetailVM findDishById(int dishId) throws SQLException {
        String sql = "SELECT id, name, category, description, price, imageUrl, status " +
                     "FROM tblDish WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, dishId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    DishDetailVM dish = new DishDetailVM();
                    dish.setDishId(rs.getInt("id"));
                    dish.setName(rs.getString("name"));
                    dish.setCategory(rs.getString("category"));
                    dish.setDescription(rs.getString("description"));
                    dish.setPrice(rs.getBigDecimal("price"));
                    dish.setImageUrl(rs.getString("imageUrl"));
                    return dish;
                }
            }
        }
        return null;
    }

    /**
     * Search all active dishes with keyword filter, pagination and sorting
     * (Not filtered by menu - search across all dishes)
     */
    public List<DishCardVM> searchAllDishes(String keyword, int page, int pageSize, String sort) throws SQLException {
        List<DishCardVM> dishes = new ArrayList<>();

        // Build sort clause
        String sortClause = "name ASC";
        if ("price_asc".equals(sort)) {
            sortClause = "price ASC";
        } else if ("price_desc".equals(sort)) {
            sortClause = "price DESC";
        } else if ("name_desc".equals(sort)) {
            sortClause = "name DESC";
        }

        String sql = "SELECT id, name, category, description, price, imageUrl " +
                     "FROM tblDish " +
                     "WHERE status = 'ACTIVE' ";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += "AND name LIKE ? ";
        }

        sql += "ORDER BY " + sortClause + " LIMIT ? OFFSET ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int paramIndex = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + keyword + "%");
            }

            ps.setInt(paramIndex++, pageSize);
            ps.setInt(paramIndex, (page - 1) * pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DishCardVM dish = new DishCardVM();
                    dish.setDishId(rs.getInt("id"));
                    dish.setName(rs.getString("name"));
                    dish.setCategory(rs.getString("category"));
                    dish.setDescription(rs.getString("description"));
                    dish.setPrice(rs.getBigDecimal("price"));
                    dish.setImageUrl(rs.getString("imageUrl"));
                    dishes.add(dish);
                }
            }
        }
        return dishes;
    }

    /**
     * Count all active dishes with keyword filter
     * (Not filtered by menu - count across all dishes)
     */
    public int countAllDishes(String keyword) throws SQLException {
        String sql = "SELECT COUNT(*) FROM tblDish WHERE status = 'ACTIVE' ";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += "AND name LIKE ? ";
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(1, "%" + keyword + "%");
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
