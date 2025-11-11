package util;

import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load();

    private static final String URL = dotenv.get("JDBC_URL", "jdbc:mysql://localhost:3306/restman");
    private static final String USER = dotenv.get("JDBC_USER", "root");
    private static final String PASSWORD = dotenv.get("JDBC_PASS", "root");

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
