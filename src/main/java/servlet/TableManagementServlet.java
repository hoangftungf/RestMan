package servlet;

import dao.TableDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Table;

import java.io.IOException;
import java.util.List;

/**
 * Simple staff-facing servlet to inspect dining tables.
 */
@WebServlet("/staff/tables")
public class TableManagementServlet extends HttpServlet {

    private final TableDAO tableDAO = new TableDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"STAFF".equals(role) && !"MANAGER".equals(role) && !"ADMIN".equals(role)) {
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            List<Table> tables = tableDAO.findAll();
            req.setAttribute("tables", tables);
            req.getRequestDispatcher("/WEB-INF/jsp/staff/gdDanhSachBan.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("Không thể tải danh sách bàn: " + e.getMessage(), e);
        }
    }
}
