package servlet;

import dao.AccountDAO;
import model.Account;
import model.enums.Gender;
import model.enums.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

/**
 * Servlet for user registration
 * Handles new account creation with BCrypt password hashing
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Show registration form
        req.getRequestDispatcher("/WEB-INF/jsp/auth/gdDangKy.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullName = req.getParameter("fullName");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String genderStr = req.getParameter("gender");
        String dateOfBirthStr = req.getParameter("dateOfBirth");

        // Validate input
        if (!validateInput(fullName, username, password, confirmPassword, email, req)) {
            req.getRequestDispatcher("/WEB-INF/jsp/auth/gdDangKy.jsp").forward(req, resp);
            return;
        }

        try {
            // Check if username already exists
            if (accountDAO.findByUsername(username) != null) {
                req.setAttribute("error", "Tên đăng nhập đã tồn tại. Vui lòng chọn tên khác.");
                req.setAttribute("fullName", fullName);
                req.setAttribute("username", username);
                req.setAttribute("email", email);
                req.setAttribute("phone", phone);
                req.setAttribute("address", address);
                req.getRequestDispatcher("/WEB-INF/jsp/auth/gdDangKy.jsp").forward(req, resp);
                return;
            }

            // Create new account
            Account account = new Account();
            account.setFullName(fullName);
            account.setUsername(username);
            // ✅ Hash password using BCrypt
            account.setPassword(AccountDAO.hashPassword(password));
            account.setEmail(email);
            account.setPhone(phone);
            account.setAddress(address);
            
            // Set gender if provided
            if (genderStr != null && !genderStr.isEmpty()) {
                try {
                    account.setGender(Gender.valueOf(genderStr));
                } catch (IllegalArgumentException e) {
                    // Invalid gender, skip
                }
            }
            
            // Set date of birth if provided
            if (dateOfBirthStr != null && !dateOfBirthStr.isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date utilDate = sdf.parse(dateOfBirthStr);
                    account.setDateOfBirth(new Date(utilDate.getTime()));
                } catch (Exception e) {
                    // Invalid date format, skip
                }
            }
            
            // New users are CUSTOMER by default
            account.setRole(Role.CUSTOMER);

            // Save account to database
            boolean success = accountDAO.create(account);
            
            if (success) {
                // Registration successful
                req.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
                req.getRequestDispatcher("/WEB-INF/jsp/auth/gdDangNhap.jsp").forward(req, resp);
            } else {
                // Failed to create account
                req.setAttribute("error", "Có lỗi xảy ra khi tạo tài khoản. Vui lòng thử lại.");
                req.setAttribute("fullName", fullName);
                req.setAttribute("username", username);
                req.setAttribute("email", email);
                req.setAttribute("phone", phone);
                req.setAttribute("address", address);
                req.getRequestDispatcher("/WEB-INF/jsp/auth/gdDangKy.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra trong quá trình đăng ký. Vui lòng thử lại.");
            req.setAttribute("fullName", fullName);
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            req.setAttribute("address", address);
            req.getRequestDispatcher("/WEB-INF/jsp/auth/gdDangKy.jsp").forward(req, resp);
        }
    }

    /**
     * Validate registration input
     */
    private boolean validateInput(String fullName, String username, String password, 
                                  String confirmPassword, String email, HttpServletRequest req) {
        // Full name validation
        if (fullName == null || fullName.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập họ và tên.");
            return false;
        }

        // Username validation
        if (username == null || username.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập tên đăng nhập.");
            return false;
        }
        
        if (username.length() < 3) {
            req.setAttribute("error", "Tên đăng nhập phải có ít nhất 3 ký tự.");
            return false;
        }
        
        if (!username.matches("^[a-zA-Z0-9_]+$")) {
            req.setAttribute("error", "Tên đăng nhập chỉ được chứa chữ cái, số và dấu gạch dưới.");
            return false;
        }

        // Password validation
        if (password == null || password.isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập mật khẩu.");
            return false;
        }
        
        if (password.length() < 6) {
            req.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự.");
            return false;
        }

        // Confirm password validation
        if (confirmPassword == null || confirmPassword.isEmpty()) {
            req.setAttribute("error", "Vui lòng xác nhận mật khẩu.");
            return false;
        }
        
        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            return false;
        }

        // Email validation
        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập địa chỉ email.");
            return false;
        }
        
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            req.setAttribute("error", "Địa chỉ email không hợp lệ.");
            return false;
        }

        return true;
    }
}
