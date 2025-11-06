package dao;

import model.Menu;
import model.enums.MenuStatus;
import model.enums.MenuType;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAO {

    /**
     * Find active menus for customer selection
     */
    public List<Menu> findActiveMenus() throws SQLException {
        List<Menu> menus = new ArrayList<>();
        String sql = "SELECT * FROM tblMenu WHERE status = 'ACTIVE' AND " +
                     "(effectiveFrom IS NULL OR effectiveFrom <= CURDATE()) AND " +
                     "(effectiveTo IS NULL OR effectiveTo >= CURDATE()) " +
                     "ORDER BY type, name";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Menu menu = mapResultSetToMenu(rs);
                menus.add(menu);
            }
        }
        return menus;
    }

    /**
     * Find menu by ID
     */
    public Menu findById(int menuId) throws SQLException {
        String sql = "SELECT * FROM tblMenu WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, menuId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToMenu(rs);
                }
            }
        }
        return null;
    }

    /**
     * Map ResultSet to Menu object
     */
    private Menu mapResultSetToMenu(ResultSet rs) throws SQLException {
        Menu menu = new Menu();
        menu.setId(rs.getInt("id"));
        menu.setName(rs.getString("name"));

        String typeStr = rs.getString("type");
        menu.setType(typeStr != null ? MenuType.valueOf(typeStr) : null);

        menu.setEffectiveFrom(rs.getDate("effectiveFrom"));
        menu.setEffectiveTo(rs.getDate("effectiveTo"));

        String statusStr = rs.getString("status");
        menu.setStatus(statusStr != null ? MenuStatus.valueOf(statusStr) : null);

        menu.setDescription(rs.getString("description"));
        menu.setCreatedAt(rs.getTimestamp("createdAt"));
        return menu;
    }
}
