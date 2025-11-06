<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ Nhân Viên - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/staff.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>RestMan - Hệ Thống Quản Lý Nhà Hàng</h1>
            <p>Xin chào, Nhân viên Mai Hoàng Tùng</p>
        </header>

        <nav class="main-nav">
            <h2>Chức năng của Nhân Viên</h2>
            <div class="nav-grid">
                <a href="${pageContext.request.contextPath}/staff/reports" class="nav-card">
                    <h3>📊 Báo Cáo</h3>
                    <p>Xem các báo cáo thống kê</p>
                </a>
                <a href="#" class="nav-card disabled">
                    <h3>📝 Quản Lý Đơn Hàng</h3>
                    <p>Xem và quản lý đơn hàng (Chức năng đang phát triển)</p>
                </a>
                <a href="#" class="nav-card disabled">
                    <h3>🍽️ Quản Lý Menu</h3>
                    <p>Quản lý menu và món ăn (Chức năng đang phát triển)</p>
                </a>
                <a href="#" class="nav-card disabled">
                    <h3>👥 Quản Lý Khách Hàng</h3>
                    <p>Xem thông tin khách hàng (Chức năng đang phát triển)</p>
                </a>
            </div>
        </nav>

        <footer>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
