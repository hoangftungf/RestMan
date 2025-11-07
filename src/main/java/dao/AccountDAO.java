package dao;

import model.Account;
import model.enums.Gender;
import model.enums.Role;
import util.DBUtil;
import org.mindrot.jbcrypt.BCrypt;

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
     * Authenticate user with username and password using BCrypt
     */
    public Account authenticate(String username, String password) throws SQLException {
        Account account = findByUsername(username);

        if (account == null) {
            return null;
        }

        // Compare passwords using BCrypt
        if (BCrypt.checkpw(password, account.getPassword())) {
            return account;
        }

        return null;
    }

    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    /**
     * Create new account in database
     */
    public boolean create(Account account) throws SQLException {
        String sql = "INSERT INTO tblAccount (fullName, username, password, email, phone, address, gender, dateOfBirth, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, account.getFullName());
            ps.setString(2, account.getUsername());
            ps.setString(3, account.getPassword());
            ps.setString(4, account.getEmail());
            ps.setString(5, account.getPhone());
            ps.setString(6, account.getAddress());
            ps.setString(7, account.getGender() != null ? account.getGender().name() : null);
            ps.setDate(8, account.getDateOfBirth());
            ps.setString(9, account.getRole() != null ? account.getRole().name() : "CUSTOMER");

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
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
