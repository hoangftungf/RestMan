<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RestMan - Hệ Thống Quản Lý Nhà Hàng</title>
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
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 60px;
            text-align: center;
        }

        h1 {
            color: #333;
            font-size: 3em;
            margin-bottom: 20px;
        }

        p {
            color: #666;
            font-size: 1.2em;
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            border-radius: 15px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .module-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }

        .module-card h2 {
            font-size: 1.8em;
            margin-bottom: 15px;
        }

        .module-card p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1em;
        }

        .staff-card {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        footer {
            margin-top: 50px;
            color: #666;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🍽️ RestMan</h1>
        <p>Hệ Thống Quản Lý Nhà Hàng Chuyên Nghiệp</p>

        <div class="modules">
            <a href="${pageContext.request.contextPath}/WEB-INF/jsp/customer/gdChinhKH.jsp" class="module-card">
                <h2>👥 Khách Hàng</h2>
                <p>Tìm kiếm món ăn, đặt bàn và đặt món online</p>
            </a>

            <a href="${pageContext.request.contextPath}/WEB-INF/jsp/staff/gdChinhNV.jsp" class="module-card staff-card">
                <h2>👨‍💼 Nhân Viên</h2>
                <p>Quản lý đơn hàng, thống kê báo cáo</p>
            </a>
        </div>

        <footer>
            <p>&copy; 2025 RestMan. Phát triển bởi Team PTTK.</p>
        </footer>
    </div>
</body>
</html>
