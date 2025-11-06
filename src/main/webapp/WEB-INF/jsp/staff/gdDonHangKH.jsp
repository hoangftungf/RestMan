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
                <a href="${pageContext.request.contextPath}/WEB-INF/jsp/staff/gdChinhNV.jsp">Trang chủ</a>
                <span>›</span>
                <a href="${pageContext.request.contextPath}/WEB-INF/jsp/staff/gdMenuBaoCao.jsp">Báo cáo</a>
                <span>›</span>
                <span>Đơn hàng khách hàng</span>
            </nav>
        </header>

        <main class="content">
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
                                <th>Kênh</th>
                                <th>Trạng Thái</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>${order.orderNumber}</td>
                                    <td>${order.createdAt}</td>
                                    <td>Tại quán</td>
                                    <td>
                                        <span class="badge badge-${order.invoiceStatus}">
                                            ${order.invoiceStatus}
                                        </span>
                                    </td>
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
