<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Nhân Viên - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .login-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .login-box {
            background: white;
            padding: 50px 40px;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
        }

        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .login-header h1 {
            color: #0066cc;
            font-size: 2em;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .login-header p {
            color: #666;
            font-size: 0.95em;
        }

        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }

        .form-group label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.95em;
            text-align: left;
        }

        .form-group input {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: #0066cc;
            box-shadow: 0 0 0 3px rgba(0, 102, 204, 0.1);
        }

        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-size: 0.95em;
            text-align: center;
        }

        .alert-error {
            background: #fff5f5;
            border-left: 4px solid #e74c3c;
            color: #c0392b;
        }

        .alert-success {
            background: #d4edda;
            border-left: 4px solid #28a745;
            color: #155724;
        }

        .btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 1.05em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-primary {
            background: #0066cc;
            color: white;
        }

        .btn-primary:hover {
            background: #0052a3;
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0, 102, 204, 0.3);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
            margin-top: 15px;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .divider {
            text-align: center;
            margin: 30px 0;
            position: relative;
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
            padding: 0 15px;
            color: #999;
            font-size: 0.9em;
            position: relative;
            z-index: 1;
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: #0066cc;
            text-decoration: none;
            font-size: 0.95em;
        }

        .back-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .login-box {
                padding: 40px 30px;
            }

            .login-header h1 {
                font-size: 1.6em;
            }
        }
    </style>
</head>
<body>
    <!-- System Header -->
    <jsp:include page="/WEB-INF/jsp/common/systemHeader.jsp" />

    <div class="login-container">
        <div class="login-box">
            <div class="login-header">
                <h1>🔐 Đăng Nhập Nhân Viên</h1>
                <p>Vui lòng đăng nhập để truy cập hệ thống</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <strong>❌ Lỗi:</strong> ${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <strong>✅ Thành công:</strong> ${success}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text"
                           id="username"
                           name="username"
                           placeholder="Nhập tên đăng nhập"
                           value="${username}"
                           required
                           autofocus>
                </div>

                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Nhập mật khẩu"
                           required>
                </div>

                <button type="submit" class="btn btn-primary">Đăng Nhập</button>
            </form>

            <div class="divider">
                <span>hoặc</span>
            </div>

            <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary">
                Truy cập với tư cách Khách hàng
            </a>

            <div class="back-link">
                <a href="${pageContext.request.contextPath}/">← Quay lại trang chủ</a>
            </div>
        </div>
    </div>
</body>
</html>
