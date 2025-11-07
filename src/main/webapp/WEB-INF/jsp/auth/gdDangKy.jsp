<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding: 20px;
        }

        .auth-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            max-width: 650px;
            margin: auto;
            width: 100%;
        }

        .auth-box {
            background: white;
            padding: 50px 45px;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            width: 100%;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .auth-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .auth-header h1 {
            font-size: 2.2em;
            color: #667eea;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .auth-header p {
            color: #666;
            font-size: 0.95em;
            margin-top: 5px;
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
            font-size: 0.95em;
        }

        .required {
            color: #e74c3c;
            font-weight: 700;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 0.95em;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .form-group input::placeholder,
        .form-group select::placeholder {
            color: #999;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            background-color: #f9fafb;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-row .form-group {
            margin-bottom: 0;
        }

        .password-note {
            font-size: 0.85em;
            color: #999;
            margin-top: 6px;
            line-height: 1.4;
        }

        .error-message {
            display: flex;
            align-items: flex-start;
            padding: 14px 18px;
            background: #fff5f5;
            border-left: 4px solid #e74c3c;
            border-radius: 6px;
            margin-bottom: 25px;
            animation: slideIn 0.3s ease-out;
        }

        .error-message::before {
            content: '❌';
            margin-right: 12px;
            font-size: 1.1em;
            flex-shrink: 0;
        }

        .error-message-text {
            color: #c0392b;
            font-size: 0.95em;
            line-height: 1.5;
        }

        .success-message {
            display: flex;
            align-items: flex-start;
            padding: 14px 18px;
            background: #e8f5e9;
            border-left: 4px solid #27ae60;
            border-radius: 6px;
            margin-bottom: 25px;
            animation: slideIn 0.3s ease-out;
        }

        .success-message::before {
            content: '✅';
            margin-right: 12px;
            font-size: 1.1em;
            flex-shrink: 0;
        }

        .success-message-text {
            color: #155724;
            font-size: 0.95em;
            line-height: 1.5;
        }

        .btn-submit {
            width: 100%;
            padding: 14px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 15px;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(102, 126, 234, 0.6);
        }

        .btn-submit:active {
            transform: translateY(0);
            box-shadow: 0 2px 10px rgba(102, 126, 234, 0.4);
        }

        .divider {
            text-align: center;
            margin: 25px 0;
            position: relative;
            color: #999;
            font-size: 0.85em;
        }

        .divider::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            width: 100%;
            height: 1px;
            background: #e0e0e0;
        }

        .divider span {
            background: white;
            padding: 0 10px;
            position: relative;
            z-index: 1;
        }

        .auth-footer {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #e0e0e0;
        }

        .auth-footer p {
            margin: 0;
            font-size: 0.95em;
            color: #666;
        }

        .auth-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .auth-footer a:hover {
            color: #764ba2;
        }

        @media (max-width: 768px) {
            .auth-box {
                padding: 40px 30px;
            }

            .auth-header h1 {
                font-size: 1.8em;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .form-group input,
            .form-group select {
                padding: 12px 14px;
                font-size: 16px;
            }

            .btn-submit {
                padding: 12px 18px;
                font-size: 0.95em;
            }
        }

        @media (max-width: 480px) {
            .auth-box {
                padding: 30px 20px;
            }

            .auth-header h1 {
                font-size: 1.5em;
            }

            .auth-header p {
                font-size: 0.9em;
            }

            .form-group {
                margin-bottom: 18px;
            }

            .form-group label {
                font-size: 0.9em;
            }

            .password-note {
                font-size: 0.8em;
            }
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-box">
            <div class="auth-header">
                <h1>📝 Đăng Ký Tài Khoản</h1>
                <p>Tạo tài khoản mới để truy cập hệ thống RestMan</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <span class="error-message-text"><%= request.getAttribute("error") %></span>
                </div>
            <% } %>

            <% if (request.getAttribute("success") != null) { %>
                <div class="success-message">
                    <span class="success-message-text"><%= request.getAttribute("success") %></span>
                </div>
            <% } %>

            <form method="POST" action="${pageContext.request.contextPath}/register">
                <!-- Họ và tên -->
                <div class="form-group">
                    <label for="fullName">👤 Họ và tên <span class="required">*</span></label>
                    <input type="text" id="fullName" name="fullName" 
                           value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>"
                           placeholder="Nhập họ và tên"
                           required>
                </div>

                <!-- Username -->
                <div class="form-group">
                    <label for="username">🔤 Tên đăng nhập <span class="required">*</span></label>
                    <input type="text" id="username" name="username" 
                           value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                           placeholder="3-20 ký tự (a-z, 0-9, _)"
                           required>
                    <div class="password-note">💡 Tối thiểu 3 ký tự, chỉ chứa chữ cái, số và dấu gạch dưới</div>
                </div>

                <!-- Email -->
                <div class="form-group">
                    <label for="email">📧 Email <span class="required">*</span></label>
                    <input type="email" id="email" name="email" 
                           value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                           placeholder="Nhập địa chỉ email"
                           required>
                </div>

                <!-- Mật khẩu -->
                <div class="form-group">
                    <label for="password">🔐 Mật khẩu <span class="required">*</span></label>
                    <input type="password" id="password" name="password" 
                           placeholder="Tối thiểu 6 ký tự"
                           required>
                    <div class="password-note">💡 Tối thiểu 6 ký tự. Mật khẩu sẽ được mã hóa bằng BCrypt</div>
                </div>

                <!-- Xác nhận mật khẩu -->
                <div class="form-group">
                    <label for="confirmPassword">🔑 Xác nhận mật khẩu <span class="required">*</span></label>
                    <input type="password" id="confirmPassword" name="confirmPassword" 
                           placeholder="Nhập lại mật khẩu"
                           required>
                </div>

                <!-- Số điện thoại -->
                <div class="form-group">
                    <label for="phone">📱 Số điện thoại</label>
                    <input type="tel" id="phone" name="phone" 
                           value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>"
                           placeholder="VD: 0123456789">
                </div>

                <!-- Địa chỉ -->
                <div class="form-group">
                    <label for="address">📍 Địa chỉ</label>
                    <input type="text" id="address" name="address" 
                           value="<%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %>"
                           placeholder="Nhập địa chỉ">
                </div>

                <!-- Giới tính & Ngày sinh -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="gender">👥 Giới tính</label>
                        <select id="gender" name="gender">
                            <option value="">-- Chọn giới tính --</option>
                            <option value="MALE">Nam</option>
                            <option value="FEMALE">Nữ</option>
                            <option value="OTHER">Khác</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="dateOfBirth">📅 Ngày sinh</label>
                        <input type="date" id="dateOfBirth" name="dateOfBirth">
                    </div>
                </div>

                <!-- Nút đăng ký -->
                <button type="submit" class="btn-submit">✨ Đăng Ký Tài Khoản</button>
            </form>

            <div class="divider">
                <span>hoặc</span>
            </div>

            <div class="auth-footer">
                <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập tại đây</a></p>
            </div>
        </div>
    </div>
</body>
</html>
