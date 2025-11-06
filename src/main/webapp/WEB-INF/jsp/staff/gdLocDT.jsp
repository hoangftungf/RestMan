<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống Kê Khách Hàng Theo Doanh Thu - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/staff.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📊 Thống Kê Khách Hàng Theo Doanh Thu</h1>
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/staff">Trang chủ</a>
                <span>›</span>
                <a href="${pageContext.request.contextPath}/staff/reports">Báo cáo</a>
                <span>›</span>
                <span>Khách hàng theo doanh thu</span>
            </nav>
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
