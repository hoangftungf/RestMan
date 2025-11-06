<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Báo Cáo - RestMan</title>
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
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        header {
            background: linear-gradient(135deg, #5b9bd5 0%, #4a7fb8 100%);
            color: white;
            padding: 30px;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        .breadcrumb {
            margin-top: 15px;
            font-size: 0.9em;
        }

        .breadcrumb a {
            color: #fff;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .breadcrumb span {
            margin: 0 8px;
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .btn-logout {
            display: inline-block;
            padding: 12px 24px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            border: 2px solid white;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-logout:hover {
            background: white;
            color: #4a7fb8;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .content {
            padding: 40px;
        }

        .content h2 {
            color: #333;
            margin-bottom: 25px;
            font-size: 1.8em;
        }

        .report-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .report-card {
            background: white;
            border: 2px solid #5b9bd5;
            border-radius: 10px;
            padding: 30px;
            text-decoration: none;
            color: #333;
            transition: all 0.3s ease;
            text-align: center;
        }

        .report-card:hover:not(.disabled) {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(91, 155, 213, 0.3);
            border-color: #4a7fb8;
            background: #f0f7ff;
        }

        .report-card.disabled {
            opacity: 0.5;
            cursor: not-allowed;
            background: #f5f5f5;
            border-color: #ddd;
        }

        .report-card h3 {
            color: #4a7fb8;
            margin-bottom: 15px;
            font-size: 1.4em;
        }

        .report-card p {
            color: #666;
            line-height: 1.6;
        }

        .btn {
            display: inline-block;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-size: 1em;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        footer {
            background: #f8f9fa;
            padding: 20px;
            text-align: center;
            border-top: 1px solid #e0e0e0;
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
            align-items: center;
        }

        footer p {
            color: #666;
        }

        @media (max-width: 768px) {
            header h1 {
                font-size: 1.8em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="header-content">
                <div>
                    <h1>📊 Báo Cáo Thống Kê</h1>
                    <nav class="breadcrumb">
                        <a href="${pageContext.request.contextPath}/staff">Trang chủ</a>
                        <span>›</span>
                        <span>Báo cáo</span>
                    </nav>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/logout" class="btn-logout">🚪 Đăng Xuất</a>
                </div>
            </div>
        </header>

        <main class="content">
            <h2>Chọn loại báo cáo</h2>

            <div class="report-grid">
                <a href="${pageContext.request.contextPath}/report/customer-revenue" class="report-card">
                    <h3>💰 Khách Hàng Theo Doanh Thu</h3>
                    <p>Thống kê khách hàng theo tổng doanh thu trong khoảng thời gian</p>
                </a>

                <div class="report-card disabled">
                    <h3>📈 Doanh Thu Theo Thời Gian</h3>
                    <p>Báo cáo doanh thu theo ngày/tháng/năm (Đang phát triển)</p>
                </div>

                <div class="report-card disabled">
                    <h3>🍽️ Món Ăn Bán Chạy</h3>
                    <p>Thống kê món ăn được đặt nhiều nhất (Đang phát triển)</p>
                </div>

                <div class="report-card disabled">
                    <h3>📊 Tồn Kho</h3>
                    <p>Báo cáo tình trạng kho nguyên liệu (Đang phát triển)</p>
                </div>
            </div>
        </main>

        <footer>
            <a href="${pageContext.request.contextPath}/staff" class="btn btn-secondary">← Quay lại</a>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
