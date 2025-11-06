package dao;

import model.Account;
import model.enums.Gender;
import model.enums.Role;
import util.DBUtil;

import java.sql.*;

public class AccountDAO {

    /**
     * Find account by ID
     */
    public Account findById(int accountId) throws SQLException {
        String sql = "SELECT * FROM tblAccount WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAccount(rs);
                }
            }
        }
        return null;
    }

    /**
     * Find account by username
     */
    public Account findByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM tblAccount WHERE username = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAccount(rs);
                }
            }
        }
        return null;
    }

    /**
     * Authenticate user with username and password
     * For now, we use plain text password comparison
     * TODO: Implement BCrypt password hashing in production
     */
    public Account authenticate(String username, String password) throws SQLException {
        Account account = findByUsername(username);

        if (account == null) {
            return null;
        }

        // Compare passwords (plain text for now)
        // In production, use BCrypt.checkpw(password, account.getPassword())
        if (account.getPassword().equals(password)) {
            return account;
        }

        return null;
    }

    /**
     * Map ResultSet to Account object
     */
    private Account mapResultSetToAccount(ResultSet rs) throws SQLException {
        Account account = new Account();
        account.setId(rs.getInt("id"));
        account.setFullName(rs.getString("fullName"));
        account.setUsername(rs.getString("username"));
        account.setPassword(rs.getString("password"));
        account.setEmail(rs.getString("email"));
        account.setPhone(rs.getString("phone"));
        account.setAddress(rs.getString("address"));

        String genderStr = rs.getString("gender");
        account.setGender(genderStr != null ? Gender.valueOf(genderStr) : null);

        account.setDateOfBirth(rs.getDate("dateOfBirth"));

        String roleStr = rs.getString("role");
        account.setRole(roleStr != null ? Role.valueOf(roleStr) : null);

        account.setCreatedAt(rs.getTimestamp("createdAt"));
        account.setUpdatedAt(rs.getTimestamp("updatedAt"));
        return account;
    }
}
