package dao;

import model.Table;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for interacting with tblTable.
 */
public class TableDAO {

    public Table findById(int tableId) throws SQLException {
        String sql = "SELECT * FROM tblTable WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, tableId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        }
        return null;
    }

    public List<Table> findAll() throws SQLException {
        List<Table> tables = new ArrayList<>();
        String sql = "SELECT * FROM tblTable ORDER BY tableNumber";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                tables.add(mapRow(rs));
            }
        }
        return tables;
    }

    public List<Table> findByStatus(String status) throws SQLException {
        List<Table> tables = new ArrayList<>();
        String sql = "SELECT * FROM tblTable WHERE status = ? ORDER BY tableNumber";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    tables.add(mapRow(rs));
                }
            }
        }
        return tables;
    }

    private Table mapRow(ResultSet rs) throws SQLException {
        Table table = new Table();
        table.setId(rs.getInt("id"));
        table.setTableNumber(rs.getInt("tableNumber"));
        table.setCapacity(rs.getInt("capacity"));
        table.setLocation(rs.getInt("location"));
        table.setStatus(rs.getString("status"));
        return table;
    }
}
