<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống Kê Khách Hàng Theo Doanh Thu - RestMan</title>
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

        .filter-form {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }

        .form-group input,
        .form-group select {
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1em;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #5b9bd5;
        }

        .checkbox-group label {
            flex-direction: row;
            align-items: center;
            gap: 10px;
        }

        .checkbox-group input[type="checkbox"] {
            width: auto;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-start;
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

        .btn-primary {
            background: linear-gradient(135deg, #5b9bd5 0%, #4a7fb8 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(91, 155, 213, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .alert {
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .alert-error {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }

        .help-section {
            background: #e3f2fd;
            padding: 20px;
            border-left: 4px solid #2196f3;
            border-radius: 5px;
            margin-top: 20px;
        }

        .help-section h3 {
            color: #1565c0;
            margin-bottom: 10px;
        }

        .help-section ul {
            list-style-position: inside;
            color: #1565c0;
        }

        .help-section li {
            margin-bottom: 8px;
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

            .form-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="header-content">
                <div>
                    <h1>📊 Thống Kê Khách Hàng Theo Doanh Thu</h1>
                    <nav class="breadcrumb">
                        <a href="${pageContext.request.contextPath}/staff">Trang chủ</a>
                        <span>›</span>
                        <a href="${pageContext.request.contextPath}/staff/reports">Báo cáo</a>
                        <span>›</span>
                        <span>Khách hàng theo doanh thu</span>
                    </nav>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/logout" class="btn-logout">🚪 Đăng Xuất</a>
                </div>
            </div>
        </header>

        <main class="content">
            <h2>Chọn điều kiện lọc</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/report/customer-revenue" method="get" class="filter-form">
                <input type="hidden" name="action" value="runReport">

                <div class="form-grid">
                    <div class="form-group">
                        <label for="fromDate">Ngày bắt đầu:</label>
                        <input type="date" id="fromDate" name="fromDate"
                               value="${fromDate != null ? fromDate : ''}"
                               required>
                    </div>

                    <div class="form-group">
                        <label for="toDate">Ngày kết thúc:</label>
                        <input type="date" id="toDate" name="toDate"
                               value="${toDate != null ? toDate : ''}"
                               required>
                    </div>

                    <div class="form-group">
                        <label for="tier">Hạng thành viên:</label>
                        <select id="tier" name="tier">
                            <option value="">-- Tất cả --</option>
                            <option value="BRONZE">Bronze</option>
                            <option value="SILVER">Silver</option>
                            <option value="GOLD">Gold</option>
                            <option value="VIP">VIP</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="minRevenue">Doanh thu tối thiểu (đ):</label>
                        <input type="number" id="minRevenue" name="minRevenue"
                               min="0" step="1000"
                               placeholder="VD: 1000000">
                    </div>

                    <div class="form-group">
                        <label for="topN">Top N khách hàng:</label>
                        <input type="number" id="topN" name="topN"
                               min="1" max="100"
                               placeholder="VD: 10 (để trống nếu muốn xem tất cả)">
                    </div>

                    <div class="form-group checkbox-group">
                        <label>
                            <input type="checkbox" name="includeUnpaid" value="true">
                            Bao gồm hóa đơn chưa thanh toán
                        </label>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">TẠO BÁO CÁO</button>
                    <button type="reset" class="btn btn-secondary">Đặt lại</button>
                </div>
            </form>

            <div class="help-section">
                <h3>Hướng dẫn:</h3>
                <ul>
                    <li>Chọn khoảng thời gian để thống kê doanh thu</li>
                    <li>Có thể lọc theo hạng thành viên (Bronze, Silver, Gold, VIP)</li>
                    <li>Có thể đặt mức doanh thu tối thiểu để chỉ hiển thị khách hàng đạt ngưỡng</li>
                    <li>Sử dụng "Top N" để chỉ xem N khách hàng có doanh thu cao nhất</li>
                </ul>
            </div>
        </main>

        <footer>
            <a href="${pageContext.request.contextPath}/staff/reports" class="btn btn-secondary">← Quay lại</a>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
