<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ Khách Hàng - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>RestMan - Hệ Thống Quản Lý Nhà Hàng</h1>
            <p>Xin chào, Khách hàng!</p>
        </header>

        <nav class="main-nav">
            <h2>Chức năng của Khách Hàng</h2>
            <div class="nav-grid">
                <a href="${pageContext.request.contextPath}/catalog" class="nav-card">
                    <h3>🔍 Tìm Kiếm Món Ăn</h3>
                    <p>Tìm kiếm thông tin các món ăn trong menu</p>
                </a>
                <a href="#" class="nav-card disabled">
                    <h3>📅 Đặt Bàn</h3>
                    <p>Đặt bàn trước (Chức năng đang phát triển)</p>
                </a>
                <a href="#" class="nav-card disabled">
                    <h3>🛒 Đặt Món Online</h3>
                    <p>Đặt món ăn trực tuyến (Chức năng đang phát triển)</p>
                </a>
                <a href="#" class="nav-card disabled">
                    <h3>👤 Thông Tin Cá Nhân</h3>
                    <p>Quản lý thông tin tài khoản (Chức năng đang phát triển)</p>
                </a>
            </div>
        </nav>

        <footer>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
