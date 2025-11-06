<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Báo Cáo - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/staff.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📊 Báo Cáo Thống Kê</h1>
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/staff">Trang chủ</a>
                <span>›</span>
                <span>Báo cáo</span>
            </nav>
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
