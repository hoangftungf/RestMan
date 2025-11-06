package servlet;

import util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;

/**
 * Servlet to test database connection
 * Access at: /test-db
 */
@WebServlet("/test-db")
public class TestDatabaseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        PrintWriter out = resp.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<title>Kiểm Tra Kết Nối Database - RestMan</title>");
        out.println("<style>");
        out.println("body { font-family: 'Segoe UI', Arial, sans-serif; background: #f5f5f5; padding: 40px; }");
        out.println(".container { max-width: 900px; margin: 0 auto; background: white; padding: 40px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }");
        out.println("h1 { color: #0066cc; border-bottom: 3px solid #0066cc; padding-bottom: 15px; }");
        out.println("h2 { color: #333; margin-top: 30px; }");
        out.println(".success { background: #d4edda; border-left: 4px solid #28a745; padding: 15px; margin: 20px 0; border-radius: 5px; color: #155724; }");
        out.println(".error { background: #f8d7da; border-left: 4px solid #dc3545; padding: 15px; margin: 20px 0; border-radius: 5px; color: #721c24; }");
        out.println(".info { background: #e3f2fd; padding: 10px 15px; margin: 10px 0; border-radius: 5px; color: #0066cc; }");
        out.println("table { width: 100%; border-collapse: collapse; margin: 20px 0; }");
        out.println("th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }");
        out.println("th { background: #0066cc; color: white; font-weight: 600; }");
        out.println("tr:hover { background: #f5f5f5; }");
        out.println(".btn { display: inline-block; padding: 12px 24px; background: #0066cc; color: white; text-decoration: none; border-radius: 6px; margin-top: 20px; }");
        out.println(".btn:hover { background: #0052a3; }");
        out.println("code { background: #f4f4f4; padding: 2px 6px; border-radius: 3px; font-family: 'Courier New', monospace; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container'>");
        out.println("<h1>🔍 Kiểm Tra Kết Nối Database</h1>");

        try (Connection conn = DBUtil.getConnection()) {
            // Connection successful
            out.println("<div class='success'>");
            out.println("<strong>✅ Kết nối database thành công!</strong>");
            out.println("</div>");

            // Get database metadata
            DatabaseMetaData metaData = conn.getMetaData();

            out.println("<h2>📊 Thông Tin Database</h2>");
            out.println("<table>");
            out.println("<tr><th>Thuộc tính</th><th>Giá trị</th></tr>");
            out.println("<tr><td>Database Product</td><td>" + metaData.getDatabaseProductName() + "</td></tr>");
            out.println("<tr><td>Database Version</td><td>" + metaData.getDatabaseProductVersion() + "</td></tr>");
            out.println("<tr><td>JDBC Driver</td><td>" + metaData.getDriverName() + "</td></tr>");
            out.println("<tr><td>Driver Version</td><td>" + metaData.getDriverVersion() + "</td></tr>");
            out.println("<tr><td>Database URL</td><td>" + metaData.getURL() + "</td></tr>");
            out.println("<tr><td>Username</td><td>" + metaData.getUserName() + "</td></tr>");
            out.println("</table>");

            // List all tables
            out.println("<h2>📋 Danh Sách Bảng Trong Database</h2>");
            ResultSet tables = metaData.getTables(null, null, "%", new String[]{"TABLE"});

            boolean hasTables = false;
            out.println("<table>");
            out.println("<tr><th>STT</th><th>Tên Bảng</th><th>Loại</th></tr>");

            int count = 0;
            while (tables.next()) {
                hasTables = true;
                count++;
                String tableName = tables.getString("TABLE_NAME");
                String tableType = tables.getString("TABLE_TYPE");
                out.println("<tr><td>" + count + "</td><td><code>" + tableName + "</code></td><td>" + tableType + "</td></tr>");
            }
            out.println("</table>");

            if (!hasTables) {
                out.println("<div class='info'>");
                out.println("<strong>⚠️ Database chưa có bảng nào!</strong>");
                out.println("<p>Bạn cần import schema SQL để tạo các bảng. Chạy lệnh:</p>");
                out.println("<code>mysql -u root -p restMan &lt; sql/schema.sql</code>");
                out.println("</div>");
            } else {
                out.println("<div class='info'>");
                out.println("<strong>✅ Tìm thấy " + count + " bảng trong database</strong>");
                out.println("</div>");
            }

            tables.close();

        } catch (Exception e) {
            // Connection failed
            out.println("<div class='error'>");
            out.println("<strong>❌ Lỗi kết nối database!</strong>");
            out.println("<p><strong>Chi tiết lỗi:</strong> " + e.getMessage() + "</p>");
            out.println("</div>");

            out.println("<h2>🔧 Hướng Dẫn Khắc Phục</h2>");
            out.println("<div class='info'>");
            out.println("<ol>");
            out.println("<li>Kiểm tra MySQL Server đã chạy chưa</li>");
            out.println("<li>Kiểm tra tên database <code>restMan</code> đã được tạo chưa");
            out.println("<br>→ Chạy lệnh: <code>CREATE DATABASE restMan CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;</code></li>");
            out.println("<li>Kiểm tra username và password trong file <code>.env</code> hoặc <code>DBUtil.java</code>");
            out.println("<br>→ Mặc định: user=<code>root</code>, password=<code>root</code></li>");
            out.println("<li>Kiểm tra port MySQL (mặc định: 3306)</li>");
            out.println("</ol>");
            out.println("</div>");

            out.println("<h2>📝 Stack Trace</h2>");
            out.println("<div style='background: #f4f4f4; padding: 15px; border-radius: 5px; overflow-x: auto;'>");
            out.println("<pre>");
            e.printStackTrace(out);
            out.println("</pre>");
            out.println("</div>");
        }

        out.println("<a href='" + req.getContextPath() + "/' class='btn'>← Quay về Trang Chủ</a>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}
