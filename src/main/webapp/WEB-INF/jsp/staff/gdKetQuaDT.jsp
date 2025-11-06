<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo Cáo Doanh Thu Khách Hàng - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/staff.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📊 Báo Cáo Doanh Thu Khách Hàng (${totalCustomers} khách hàng)</h1>
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/WEB-INF/jsp/staff/gdChinhNV.jsp">Trang chủ</a>
                <span>›</span>
                <a href="${pageContext.request.contextPath}/WEB-INF/jsp/staff/gdMenuBaoCao.jsp">Báo cáo</a>
                <span>›</span>
                <span>Kết quả</span>
            </nav>
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
                                <th>Ngày Tham Gia</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="customer" items="${customers}" varStatus="status">
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
                                    <td>12/5/2023</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/report/customer-revenue?action=viewCustomerDetail&customerId=${customer.customerId}&fromDate=${fromDate}&toDate=${toDate}"
                                           class="btn btn-small">Chi tiết</a>
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
            <a href="${pageContext.request.contextPath}/WEB-INF/jsp/staff/gdMenuBaoCao.jsp" class="btn btn-secondary">Menu báo cáo</a>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
