<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hóa Đơn Thanh Toán - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/staff.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📄 Hóa Đơn Thanh Toán</h1>
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/WEB-INF/jsp/staff/gdChinhNV.jsp">Trang chủ</a>
                <span>›</span>
                <a href="${pageContext.request.contextPath}/WEB-INF/jsp/staff/gdMenuBaoCao.jsp">Báo cáo</a>
                <span>›</span>
                <span>Hóa đơn</span>
            </nav>
        </header>

        <main class="content">
            <div class="invoice-container">
                <div class="invoice-header">
                    <h2>NHÀ HÀNG ABC RESTAURANT</h2>
                    <p>123 Đường XYZ, Quận 1, TP. Hồ Chí Minh</p>
                    <p>Hotline: 0123 456 789 | Email: abc@restaurant.com</p>
                </div>

                <div class="invoice-title">
                    <h2>📄 HÓA ĐƠN THANH TOÁN</h2>
                    <p>Mã hóa đơn: <strong>${invoice.invoiceNumber}</strong></p>
                </div>

                <div class="invoice-info">
                    <h3>Thông Tin Hóa Đơn</h3>
                    <div class="info-grid">
                        <div class="info-row">
                            <span class="label">Mã hóa đơn:</span>
                            <span class="value">${invoice.invoiceNumber}</span>
                        </div>
                        <div class="info-row">
                            <span class="label">Mã đơn hàng:</span>
                            <span class="value">${order.orderNumber}</span>
                        </div>
                        <div class="info-row">
                            <span class="label">Ngày xuất:</span>
                            <span class="value">${invoice.issueDate}</span>
                        </div>
                        <div class="info-row">
                            <span class="label">Phương thức thanh toán:</span>
                            <span class="value">${invoice.paymentMethod}</span>
                        </div>
                        <div class="info-row">
                            <span class="label">Trạng thái:</span>
                            <span class="badge badge-${invoice.status}">${invoice.status}</span>
                        </div>
                    </div>
                </div>

                <div class="invoice-items">
                    <h3>Danh Sách Món Ăn Đã Đặt</h3>
                    <table class="invoice-table">
                        <thead>
                            <tr>
                                <th>TT</th>
                                <th>Tên Món</th>
                                <th>SL</th>
                                <th>Đơn Giá</th>
                                <th>Giảm Giá</th>
                                <th>Thành Tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${items}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>Phở Bò Tái</td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/> đ</td>
                                    <td><fmt:formatNumber value="${item.discount}" type="number" groupingUsed="true"/> đ</td>
                                    <td class="amount"><fmt:formatNumber value="${item.lineTotal}" type="number" groupingUsed="true"/> đ</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="invoice-summary">
                    <h3>Thông Tin Thanh Toán</h3>
                    <div class="summary-rows">
                        <div class="summary-row">
                            <span class="label">Tạm tính (chưa VAT):</span>
                            <span class="value"><fmt:formatNumber value="${invoice.total / 1.1}" type="number" groupingUsed="true"/> đ</span>
                        </div>
                        <div class="summary-row">
                            <span class="label">Giảm giá chi tiết VIP:</span>
                            <span class="value discount">-10.000 đ</span>
                        </div>
                        <div class="summary-row">
                            <span class="label">Thuế VAT (10%):</span>
                            <span class="value"><fmt:formatNumber value="${invoice.total * 0.1}" type="number" groupingUsed="true"/> đ</span>
                        </div>
                        <div class="summary-row total">
                            <span class="label"><strong>Tổng thanh toán:</strong></span>
                            <span class="value"><strong><fmt:formatNumber value="${invoice.total}" type="number" groupingUsed="true"/> đ</strong></span>
                        </div>
                    </div>
                </div>

                <div class="invoice-payment">
                    <h3>Phương Thức Thanh Toán</h3>
                    <p><strong>Hình thức:</strong> ${invoice.paymentMethod}</p>
                    <p><strong>Tình trạng:</strong> <span class="badge badge-${invoice.status}">${invoice.status}</span></p>
                    <p><strong>Đã thanh toán:</strong> <fmt:formatNumber value="${invoice.paidAmount}" type="number" groupingUsed="true"/> đ</p>
                </div>

                <div class="invoice-footer">
                    <p>Cảm ơn quý khách đã sử dụng dịch vụ!</p>
                    <p>Hẹn gặp lại!</p>
                </div>
            </div>
        </main>

        <footer>
            <button onclick="history.back()" class="btn btn-secondary">← Quay lại</button>
            <button onclick="window.print()" class="btn btn-primary">🖨️ In hóa đơn</button>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
