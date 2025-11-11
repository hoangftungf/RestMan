<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Bàn - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/staff.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🍽️ Quản Lý Bàn</h1>
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/staff">Trang chủ</a>
                <span>›</span>
                <span>Danh sách bàn</span>
            </nav>
        </header>

        <main class="content">
            <c:choose>
                <c:when test="${empty tables}">
                    <div class="alert alert-info">
                        <p>Chưa có bàn nào được cấu hình.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Số bàn</th>
                                <th>Sức chứa</th>
                                <th>Khu vực</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="table" items="${tables}">
                                <tr>
                                    <td>${table.id}</td>
                                    <td>${table.tableNumber}</td>
                                    <td>${table.capacity} khách</td>
                                    <td>Tầng ${table.location}</td>
                                    <td>
                                        <span class="badge badge-${table.status}">
                                            ${table.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </main>

        <footer>
            <button onclick="history.back()" class="btn btn-secondary">← Quay lại</button>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
