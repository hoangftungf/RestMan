package servlet;

import dao.AccountDAO;
import model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Servlet for staff login authentication
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if already logged in
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            resp.sendRedirect(req.getContextPath() + "/staff");
            return;
        }

        // Check for logout success message
        String logout = req.getParameter("logout");
        if ("success".equals(logout)) {
            req.setAttribute("success", "Đăng xuất thành công!");
        }

        // Show login page
        req.getRequestDispatcher("/WEB-INF/jsp/auth/gdDangNhap.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Validate input
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/WEB-INF/jsp/auth/gdDangNhap.jsp").forward(req, resp);
            return;
        }

        try {
            // Authenticate user
            Account account = accountDAO.authenticate(username, password);

            if (account == null) {
                // Login failed
                req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
                req.setAttribute("username", username);
                req.getRequestDispatcher("/WEB-INF/jsp/auth/gdDangNhap.jsp").forward(req, resp);
                return;
            }

            // Check if account is staff/manager/admin
            if (account.getRole() != model.enums.Role.STAFF &&
                account.getRole() != model.enums.Role.MANAGER &&
                account.getRole() != model.enums.Role.ADMIN) {
                req.setAttribute("error", "Tài khoản này không có quyền truy cập hệ thống nhân viên");
                req.setAttribute("username", username);
                req.getRequestDispatcher("/WEB-INF/jsp/auth/gdDangNhap.jsp").forward(req, resp);
                return;
            }

            // Login successful - create session
            HttpSession session = req.getSession(true);
            session.setAttribute("loggedInUser", account);
            session.setAttribute("userId", account.getId());
            session.setAttribute("username", account.getUsername());
            session.setAttribute("fullName", account.getFullName());
            session.setAttribute("role", account.getRole().name());
            session.setMaxInactiveInterval(3600); // 1 hour

            // Redirect to staff home
            resp.sendRedirect(req.getContextPath() + "/staff");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra trong quá trình đăng nhập. Vui lòng thử lại.");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/WEB-INF/jsp/auth/gdDangNhap.jsp").forward(req, resp);
        }
    }
}
