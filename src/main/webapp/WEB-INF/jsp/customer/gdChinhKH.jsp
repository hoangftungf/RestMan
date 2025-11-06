<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ Khách Hàng - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <style>
        body {
            background: #f5f5f5;
        }

        .main-content {
            max-width: 1000px;
            margin: 40px auto;
            padding: 60px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            color: #333;
            font-size: 1.8em;
            margin-bottom: 40px;
            position: relative;
            display: inline-block;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            right: 0;
            height: 4px;
            background: #0066cc;
            border-radius: 2px;
        }

        .functions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
            margin-top: 50px;
        }

        .function-card {
            background: #0066cc;
            color: white;
            padding: 40px 25px;
            border-radius: 15px;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 180px;
        }

        .function-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0, 102, 204, 0.3);
            background: #0052a3;
        }

        .function-card.disabled {
            background: #95a5a6;
            opacity: 0.6;
            cursor: not-allowed;
        }

        .function-card.disabled:hover {
            transform: none;
            box-shadow: none;
            background: #95a5a6;
        }

        .function-card h3 {
            font-size: 1.5em;
            margin-bottom: 15px;
        }

        .function-card p {
            color: rgba(255, 255, 255, 0.95);
            font-size: 0.95em;
            line-height: 1.5;
        }

        .function-card.disabled p {
            color: rgba(255, 255, 255, 0.7);
            font-style: italic;
        }

        footer {
            margin-top: 60px;
            padding-top: 30px;
            border-top: 2px solid #eee;
            color: #999;
            font-size: 0.9em;
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 40px 30px;
            }

            h2 {
                font-size: 1.5em;
            }

            .functions {
                grid-template-columns: 1fr;
                gap: 20px;
            }
        }
    </style>
</head>
<body>
    <!-- System Header -->
    <jsp:include page="/WEB-INF/jsp/common/systemHeader.jsp" />

    <div class="main-content">
        <h2>Chức năng của Khách Hàng</h2>

        <div class="functions">
            <a href="${pageContext.request.contextPath}/catalog" class="function-card">
                <h3>🔍 Tìm Kiếm Món Ăn</h3>
                <p>Tìm kiếm thông tin các món ăn trong menu</p>
            </a>

            <a href="#" class="function-card disabled">
                <h3>📅 Đặt Bàn</h3>
                <p>Đặt bàn trước (Chức năng đang phát triển)</p>
            </a>

            <a href="#" class="function-card disabled">
                <h3>🛒 Đặt Món Online</h3>
                <p>Đặt món ăn trực tuyến (Chức năng đang phát triển)</p>
            </a>

            <a href="#" class="function-card disabled">
                <h3>👤 Thông Tin Cá Nhân</h3>
                <p>Quản lý thông tin tài khoản (Chức năng đang phát triển)</p>
            </a>
        </div>

        <footer>
            <p>&copy; 2025 RestMan. Phát triển bởi Team PTTK.</p>
        </footer>
    </div>
</body>
</html>
