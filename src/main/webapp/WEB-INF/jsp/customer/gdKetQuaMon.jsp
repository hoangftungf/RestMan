<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả tìm kiếm - ${menu.name}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🔍 Kết Quả Tìm Kiếm</h1>
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/WEB-INF/jsp/customer/gdChinhKH.jsp">Trang chủ</a>
                <span>›</span>
                <a href="${pageContext.request.contextPath}/catalog">Chọn Menu</a>
                <span>›</span>
                <a href="${pageContext.request.contextPath}/catalog?action=searchForm&menuId=${menu.id}">Tìm món</a>
                <span>›</span>
                <span>Kết quả</span>
            </nav>
        </header>

        <main class="content">
            <div class="search-header">
                <h2>${menu.name}</h2>
                <c:if test="${not empty keyword}">
                    <p class="search-query">Tìm kiếm: "<strong>${keyword}</strong>"</p>
                </c:if>
                <p class="result-count">Tìm thấy ${totalDishes} món</p>
            </div>

            <c:choose>
                <c:when test="${empty dishes}">
                    <div class="alert alert-info">
                        <p>Không tìm thấy món ăn nào phù hợp với từ khóa "<strong>${keyword}</strong>".</p>
                        <a href="${pageContext.request.contextPath}/catalog?action=searchForm&menuId=${menu.id}" class="btn btn-primary">
                            Thử lại
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="dishes-grid">
                        <c:forEach var="dish" items="${dishes}">
                            <div class="dish-card">
                                <c:if test="${not empty dish.imageUrl}">
                                    <img src="${pageContext.request.contextPath}${dish.imageUrl}"
                                         alt="${dish.name}"
                                         class="dish-image"
                                         onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'">
                                </c:if>
                                <div class="dish-info">
                                    <h3>${dish.name}</h3>
                                    <p class="dish-category">${dish.category}</p>
                                    <p class="dish-description">${dish.description}</p>
                                    <p class="dish-price">${dish.formattedPrice}</p>
                                    <a href="${pageContext.request.contextPath}/catalog?action=viewDish&dishId=${dish.dishId}"
                                       class="btn btn-view">Xem chi tiết</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="${pageContext.request.contextPath}/catalog?action=search&menuId=${menu.id}&q=${keyword}&sort=${sort}&size=${pageSize}&page=${currentPage - 1}"
                                   class="page-link">← Trước</a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="page-link active">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/catalog?action=search&menuId=${menu.id}&q=${keyword}&sort=${sort}&size=${pageSize}&page=${i}"
                                           class="page-link">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a href="${pageContext.request.contextPath}/catalog?action=search&menuId=${menu.id}&q=${keyword}&sort=${sort}&size=${pageSize}&page=${currentPage + 1}"
                                   class="page-link">Sau →</a>
                            </c:if>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </main>

        <footer>
            <a href="${pageContext.request.contextPath}/catalog?action=searchForm&menuId=${menu.id}" class="btn btn-secondary">
                ← Tìm lại
            </a>
            <a href="${pageContext.request.contextPath}/catalog" class="btn btn-secondary">
                Chọn menu khác
            </a>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
