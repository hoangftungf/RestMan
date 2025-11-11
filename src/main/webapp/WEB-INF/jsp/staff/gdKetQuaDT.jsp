<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo Cáo Doanh Thu Khách Hàng - RestMan</title>
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

        .report-summary {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        .report-summary h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 1.5em;
        }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 15px;
        }

        .summary-item {
            background: white;
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid #5b9bd5;
        }

        .summary-item .label {
            display: block;
            font-size: 0.9em;
            color: #666;
            margin-bottom: 8px;
        }

        .summary-item .value {
            display: block;
            font-size: 1.3em;
            font-weight: 600;
            color: #333;
        }

        .summary-item .value.highlight {
            color: #28a745;
            font-size: 1.5em;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            margin-bottom: 20px;
        }

        .data-table thead {
            background: linear-gradient(135deg, #5b9bd5 0%, #4a7fb8 100%);
            color: white;
        }

        .data-table th,
        .data-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        .data-table th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85em;
            letter-spacing: 0.5px;
        }

        .data-table tbody tr:hover {
            background: #f8f9fa;
        }

        .data-table .amount {
            text-align: right;
            font-weight: 600;
            color: #28a745;
        }

        .badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.85em;
            font-weight: 600;
            text-transform: uppercase;
        }

        .badge-VIP {
            background: #ffd700;
            color: #333;
        }

        .badge-GOLD {
            background: #ffb347;
            color: #333;
        }

        .badge-SILVER {
            background: #c0c0c0;
            color: #333;
        }

        .badge-BRONZE {
            background: #cd7f32;
            color: white;
        }

        .badge-none {
            background: #e0e0e0;
            color: #666;
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

        .btn-small {
            padding: 6px 12px;
            font-size: 0.85em;
            background: #5b9bd5;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .btn-small:hover {
            background: #4a7fb8;
        }

        .pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 30px;
        }

        .page-link {
            padding: 10px 15px;
            background: white;
            border: 1px solid #5b9bd5;
            border-radius: 5px;
            text-decoration: none;
            color: #4a7fb8;
        }

        .page-link.active {
            background: #5b9bd5;
            color: white;
        }

        .page-link:hover:not(.active) {
            background: #f0f0f0;
        }

        .alert {
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .alert-info {
            background: #d1ecf1;
            border: 1px solid #bee5eb;
            color: #0c5460;
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

            .data-table {
                font-size: 0.85em;
            }

            .summary-grid {
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
                    <h1>📊 Báo Cáo Doanh Thu Khách Hàng (${totalCustomers} khách hàng)</h1>
                    <nav class="breadcrumb">
                        <a href="${pageContext.request.contextPath}/staff">Trang chủ</a>
                        <span>›</span>
                        <a href="${pageContext.request.contextPath}/staff/reports">Báo cáo</a>
                        <span>›</span>
                        <span>Kết quả</span>
                    </nav>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/logout" class="btn-logout">🚪 Đăng Xuất</a>
                </div>
            </div>
        </header>

        <main class="content">
            <div class="report-summary">
                <h2>Tổng quan</h2>
                <div class="summary-grid">
                    <div class="summary-item">
                        <span class="label">Thời gian:</span>
                        <span class="value">${fromDate} đến ${toDate}</span>
                    </div>
                    <div class="summary-item">
                        <span class="label">Tổng khách hàng:</span>
                        <span class="value">${totalCustomers}</span>
                    </div>
                    <div class="summary-item">
                        <span class="label">Tổng doanh thu:</span>
                        <span class="value highlight"><fmt:formatNumber value="${grandTotal}" type="number" groupingUsed="true"/> đ</span>
                    </div>
                </div>
            </div>

            <c:choose>
                <c:when test="${empty customers}">
                    <div class="alert alert-info">
                        <p>Không có khách hàng nào phù hợp với điều kiện lọc.</p>
                        <a href="${pageContext.request.contextPath}/report/customer-revenue" class="btn btn-primary">
                            Đổi điều kiện lọc
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Tên Khách Hàng</th>
                                <th>Số Điện Thoại</th>
                                <th>Email</th>
                                <th>Hạng Thành Viên</th>
                                <th>Số Đơn Hàng</th>
                                <th>Số Hóa Đơn</th>
                                <th>Tổng Doanh Thu</th>
                                <th>Loại KH</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="customer" items="${customers}" varStatus="status">
                                <c:url var="customerDetailUrl" value="${pageContext.request.contextPath}/report/customer-revenue">
                                    <c:param name="action" value="viewCustomerDetail"/>
                                    <c:param name="customerKey" value="${customer.customerKey}"/>
                                    <c:param name="guest" value="${customer.guest}"/>
                                    <c:param name="accountId" value="${customer.accountId != null ? customer.accountId : ''}"/>
                                    <c:param name="customerName" value="${customer.fullName}"/>
                                    <c:param name="phone" value="${customer.phone}"/>
                                    <c:param name="email" value="${customer.email}"/>
                                    <c:param name="fromDate" value="${fromDate}"/>
                                    <c:param name="toDate" value="${toDate}"/>
                                </c:url>
                                <tr>
                                    <td>${(currentPage - 1) * pageSize + status.index + 1}</td>
                                    <td>${customer.fullName}</td>
                                    <td>${customer.phone}</td>
                                    <td>${customer.email}</td>
                                    <td>
                                        <span class="badge badge-${customer.tier != null ? customer.tier : 'none'}">
                                            ${customer.tierDisplay}
                                        </span>
                                    </td>
                                    <td>${customer.orderCount}</td>
                                    <td>${customer.invoiceCount}</td>
                                    <td class="amount">${customer.formattedRevenue}</td>
                                    <td>${customer.guest ? 'Khách lẻ' : 'Tài khoản'}</td>
                                    <td>
                                        <a href="${customerDetailUrl}" class="btn btn-small">Chi tiết</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="${pageContext.request.contextPath}/report/customer-revenue?action=runReport&fromDate=${fromDate}&toDate=${toDate}&tier=${tier}&minRevenue=${minRevenue}&topN=${topN}&includeUnpaid=${includeUnpaid}&page=${currentPage - 1}"
                                   class="page-link">← Trước</a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="page-link active">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/report/customer-revenue?action=runReport&fromDate=${fromDate}&toDate=${toDate}&tier=${tier}&minRevenue=${minRevenue}&topN=${topN}&includeUnpaid=${includeUnpaid}&page=${i}"
                                           class="page-link">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a href="${pageContext.request.contextPath}/report/customer-revenue?action=runReport&fromDate=${fromDate}&toDate=${toDate}&tier=${tier}&minRevenue=${minRevenue}&topN=${topN}&includeUnpaid=${includeUnpaid}&page=${currentPage + 1}"
                                   class="page-link">Sau →</a>
                            </c:if>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </main>

        <footer>
            <a href="${pageContext.request.contextPath}/report/customer-revenue" class="btn btn-secondary">← Đổi bộ lọc</a>
            <a href="${pageContext.request.contextPath}/staff/reports" class="btn btn-secondary">Menu báo cáo</a>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
