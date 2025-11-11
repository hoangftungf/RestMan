<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Đặt Hàng - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/staff.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📋 Lịch Sử Đặt Hàng (${orders.size()} đơn)</h1>
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/staff">Trang chủ</a>
                <span>›</span>
                <a href="${pageContext.request.contextPath}/staff/reports">Báo cáo</a>
                <span>›</span>
                <span>Đơn hàng khách hàng</span>
            </nav>
        </header>

        <main class="content">
            <div class="order-info">
                <h2>Thông Tin Khách Hàng</h2>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="label">Tên khách:</span>
                        <span class="value">${customerName}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Số điện thoại:</span>
                        <span class="value">${customerPhone}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Email:</span>
                        <span class="value">${customerEmail}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Khoảng thời gian:</span>
                        <span class="value">${fromDate} - ${toDate}</span>
                    </div>
                </div>
            </div>

            <c:choose>
                <c:when test="${empty orders}">
                    <div class="alert alert-info">
                        <p>Khách hàng này chưa có đơn hàng nào trong khoảng thời gian đã chọn.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Mã Đơn Hàng</th>
                                <th>Thời Gian Đặt</th>
                                <th>Trạng Thái Đơn</th>
                                <th>Trạng Thái Hóa Đơn</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>${order.displayCode}</td>
                                    <td>${order.createdAt}</td>
                                    <td><span class="badge badge-${order.orderStatus}">${order.orderStatus}</span></td>
                                    <td><span class="badge badge-${order.invoiceStatus}">${order.invoiceStatus}</span></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/report/customer-revenue?action=viewOrder&orderId=${order.orderId}"
                                           class="btn btn-small">Xem chi tiết</a>
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
