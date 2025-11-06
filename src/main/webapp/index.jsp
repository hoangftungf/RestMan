<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RestMan - Hệ Thống Quản Lý Nhà Hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <style>
        body {
            background: #f5f5f5;
        }

        .main-content {
            max-width: 800px;
            margin: 40px auto;
            padding: 60px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            color: #333;
            font-size: 2em;
            margin-bottom: 20px;
        }

        p {
            color: #666;
            font-size: 1.1em;
            margin-bottom: 40px;
            line-height: 1.6;
        }

        .modules {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        .module-card {
            background: #0066cc;
            color: white;
            padding: 40px 30px;
            border-radius: 15px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .module-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0, 102, 204, 0.3);
            background: #0052a3;
        }

        .module-card h3 {
            font-size: 1.8em;
            margin-bottom: 15px;
        }

        .module-card p {
            color: rgba(255, 255, 255, 0.95);
            font-size: 1em;
            margin: 0;
        }

        .staff-card {
            background: #e74c3c;
        }

        .staff-card:hover {
            background: #c0392b;
            box-shadow: 0 10px 30px rgba(231, 76, 60, 0.3);
        }

        footer {
            margin-top: 50px;
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

            .modules {
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
        <h2>Chọn Chế Độ Sử Dụng</h2>
        <p>Vui lòng chọn một trong hai chế độ dưới đây để tiếp tục</p>

        <div class="modules">
            <a href="${pageContext.request.contextPath}/customer" class="module-card">
                <h3>👥 Khách Hàng</h3>
                <p>Tìm kiếm món ăn, đặt bàn và đặt món online</p>
            </a>

            <a href="${pageContext.request.contextPath}/login" class="module-card staff-card">
                <h3>👨‍💼 Nhân Viên</h3>
                <p>Quản lý đơn hàng, thống kê báo cáo (Yêu cầu đăng nhập)</p>
            </a>
        </div>

        <footer>
            <p>&copy; 2025 RestMan. Phát triển bởi Team PTTK.</p>
        </footer>
    </div>
</body>
</html>
