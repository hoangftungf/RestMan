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
     * Search dishes by menu with keyword filter, pagination and sorting
     */
    public List<DishCardVM> searchByMenu(int menuId, String keyword, int page, int pageSize, String sort) throws SQLException {
        List<DishCardVM> dishes = new ArrayList<>();

        // Build sort clause
        String sortClause = "d.name ASC";
        if ("price_asc".equals(sort)) {
            sortClause = "COALESCE(mi.priceOverride, d.price) ASC";
        } else if ("price_desc".equals(sort)) {
            sortClause = "COALESCE(mi.priceOverride, d.price) DESC";
        } else if ("name_desc".equals(sort)) {
            sortClause = "d.name DESC";
        }

        String sql = "SELECT DISTINCT d.id, d.name, d.category, d.description, " +
                     "COALESCE(mi.priceOverride, d.price) AS price, d.imageUrl " +
                     "FROM tblDish d " +
                     "INNER JOIN tblMenuItem mi ON d.id = mi.dishId " +
                     "WHERE mi.menuId = ? " +
                     "AND d.status = 'ACTIVE' " +
                     "AND (mi.effectiveFrom IS NULL OR mi.effectiveFrom <= CURDATE()) " +
                     "AND (mi.effectiveTo IS NULL OR mi.effectiveTo >= CURDATE()) ";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += "AND d.name LIKE ? ";
        }

        sql += "ORDER BY " + sortClause + " LIMIT ? OFFSET ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int paramIndex = 1;
            ps.setInt(paramIndex++, menuId);

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
     * Count dishes by menu with keyword filter
     */
    public int countByMenu(int menuId, String keyword) throws SQLException {
        String sql = "SELECT COUNT(DISTINCT d.id) " +
                     "FROM tblDish d " +
                     "INNER JOIN tblMenuItem mi ON d.id = mi.dishId " +
                     "WHERE mi.menuId = ? " +
                     "AND d.status = 'ACTIVE' " +
                     "AND (mi.effectiveFrom IS NULL OR mi.effectiveFrom <= CURDATE()) " +
                     "AND (mi.effectiveTo IS NULL OR mi.effectiveTo >= CURDATE()) ";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += "AND d.name LIKE ? ";
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, menuId);

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(2, "%" + keyword + "%");
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
}
