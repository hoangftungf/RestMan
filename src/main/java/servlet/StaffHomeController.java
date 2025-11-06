package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Staff home page controller
 */
@WebServlet("/staff")
public class StaffHomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            // Not logged in - redirect to login page
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Check if user has staff/manager/admin role
        String role = (String) session.getAttribute("role");
        if (!"STAFF".equals(role) && !"MANAGER".equals(role) && !"ADMIN".equals(role)) {
            // Not authorized
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // User is authenticated and authorized - show staff home page
        req.getRequestDispatcher("/WEB-INF/jsp/staff/gdChinhNV.jsp").forward(req, resp);
    }
}
