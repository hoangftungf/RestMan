<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn Hàng - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/staff.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📋 Chi Tiết Đơn Hàng</h1>
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/WEB-INF/jsp/staff/gdChinhNV.jsp">Trang chủ</a>
                <span>›</span>
                <a href="${pageContext.request.contextPath}/WEB-INF/jsp/staff/gdMenuBaoCao.jsp">Báo cáo</a>
                <span>›</span>
                <span>Chi tiết đơn</span>
            </nav>
        </header>

        <main class="content">
            <div class="order-info">
                <h2>Thông Tin Đơn Hàng</h2>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="label">Mã đơn hàng:</span>
                        <span class="value">${order.orderNumber}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Thời gian:</span>
                        <span class="value">${order.createdAt}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Kênh:</span>
                        <span class="value">${order.channel}</span>
                    </div>
                    <div class="info-item">
                        <span class="label">Trạng thái:</span>
                        <span class="badge badge-${order.status}">${order.status}</span>
                    </div>
                </div>
            </div>

            <div class="order-items">
                <h2>Chi Tiết Món Đã Đặt</h2>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Tên Món</th>
                            <th>Số Lượng</th>
                            <th>Đơn Giá</th>
                            <th>Giảm Giá</th>
                            <th>Thành Tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${items}">
                            <tr>
                                <td>Phở Bò Tái</td>
                                <td>${item.quantity}</td>
                                <td><fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/> đ</td>
                                <td><fmt:formatNumber value="${item.discount}" type="number" groupingUsed="true"/> đ</td>
                                <td class="amount"><fmt:formatNumber value="${item.lineTotal}" type="number" groupingUsed="true"/> đ</td>
                            </tr>
                        </c:forEach>
                        <tr class="total-row">
                            <td colspan="4"><strong>Tổng cộng:</strong></td>
                            <td class="amount"><strong><fmt:formatNumber value="${orderTotal}" type="number" groupingUsed="true"/> đ</strong></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="invoices-section">
                <h2>Hóa Đơn Thanh Toán (${invoices.size()} hóa đơn)</h2>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Mã Hóa Đơn</th>
                            <th>Ngày Xuất</th>
                            <th>Tổng Tiền</th>
                            <th>Phương Thức</th>
                            <th>Trạng Thái</th>
                            <th>Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="invoice" items="${invoices}">
                            <tr>
                                <td>${invoice.invoiceNumber}</td>
                                <td>${invoice.issueDate}</td>
                                <td class="amount"><fmt:formatNumber value="${invoice.total}" type="number" groupingUsed="true"/> đ</td>
                                <td>${invoice.paymentMethod}</td>
                                <td>
                                    <span class="badge badge-${invoice.status}">${invoice.status}</span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/report/customer-revenue?action=viewInvoice&invoiceId=${invoice.id}"
                                       class="btn btn-small">Xem hóa đơn</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>

        <footer>
            <button onclick="history.back()" class="btn btn-secondary">← Quay lại</button>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
