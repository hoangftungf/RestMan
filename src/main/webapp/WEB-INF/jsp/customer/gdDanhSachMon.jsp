<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm Kiếm Món Ăn - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css">
</head>
<body>
    <!-- System Header -->
    <jsp:include page="/WEB-INF/jsp/common/systemHeader.jsp" />

    <div class="container">
        <header class="page-header">
            <h1>🔍 Tìm Kiếm Món Ăn</h1>
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/customer">Trang chủ</a>
                <span>›</span>
                <span>Tìm kiếm món ăn</span>
            </nav>
        </header>

        <main class="content">
            <!-- SEARCH SECTION -->
            <div class="search-section">
                <h2>Tìm kiếm món ăn trong thực đơn</h2>

                <form action="${pageContext.request.contextPath}/catalog" method="get" class="search-form">
                    <input type="hidden" name="action" value="search">

                    <div class="search-input-group">
                        <input type="text" name="q" id="keyword"
                               value="${keyword}"
                               placeholder="Nhập tên món ăn cần tìm..."
                               class="search-input"
                               autofocus>
                        <button type="submit" class="btn btn-primary">TÌM KIẾM</button>
                        <a href="${pageContext.request.contextPath}/catalog" class="btn btn-secondary">HIỆN TẤT CẢ</a>
                    </div>

                    <div class="search-options">
                        <label>
                            Sắp xếp:
                            <select name="sort">
                                <option value="name_asc" ${sort == 'name_asc' ? 'selected' : ''}>Tên (A-Z)</option>
                                <option value="name_desc" ${sort == 'name_desc' ? 'selected' : ''}>Tên (Z-A)</option>
                                <option value="price_asc" ${sort == 'price_asc' ? 'selected' : ''}>Giá (Thấp đến Cao)</option>
                                <option value="price_desc" ${sort == 'price_desc' ? 'selected' : ''}>Giá (Cao đến Thấp)</option>
                            </select>
                        </label>

                        <label>
                            Hiển thị:
                            <select name="size">
                                <option value="12" ${pageSize == 12 ? 'selected' : ''}>12 món/trang</option>
                                <option value="24" ${pageSize == 24 ? 'selected' : ''}>24 món/trang</option>
                                <option value="48" ${pageSize == 48 ? 'selected' : ''}>48 món/trang</option>
                            </select>
                        </label>
                    </div>
                </form>

                <c:if test="${not empty keyword}">
                    <div class="search-info">
                        <p>Tìm kiếm: "<strong>${keyword}</strong>" - Tìm thấy <strong>${totalDishes}</strong> món</p>
                    </div>
                </c:if>
                <c:if test="${empty keyword}">
                    <div class="search-info">
                        <p>Hiển thị tất cả <strong>${totalDishes}</strong> món ăn</p>
                    </div>
                </c:if>
            </div>

            <!-- DISHES GRID -->
            <c:choose>
                <c:when test="${empty dishes}">
                    <div class="alert alert-info">
                        <c:choose>
                            <c:when test="${not empty keyword}">
                                <p>Không tìm thấy món ăn nào phù hợp với từ khóa "<strong>${keyword}</strong>".</p>
                                <a href="${pageContext.request.contextPath}/catalog" class="btn btn-primary">
                                    Xem tất cả món ăn
                                </a>
                            </c:when>
                            <c:otherwise>
                                <p>Hiện tại chưa có món ăn nào trong hệ thống.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="dishes-grid">
                        <c:forEach var="dish" items="${dishes}">
                            <div class="dish-card">
                                <c:if test="${not empty dish.imageUrl}">
                                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 400 300'%3E%3Crect fill='%23f0f0f0' width='400' height='300'/%3E%3C/svg%3E"
                                         data-src="${pageContext.request.contextPath}${dish.imageUrl}"
                                         alt="${dish.name}"
                                         class="dish-image lazy"
                                         onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'; this.classList.remove('lazy')">
                                </c:if>
                                <c:if test="${empty dish.imageUrl}">
                                    <img src="${pageContext.request.contextPath}/images/no-image.jpg"
                                         alt="No image"
                                         class="dish-image">
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

                    <!-- PAGINATION -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="${pageContext.request.contextPath}/catalog?action=search&q=${keyword}&sort=${sort}&size=${pageSize}&page=${currentPage - 1}"
                                   class="page-link">← Trước</a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="page-link active">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/catalog?action=search&q=${keyword}&sort=${sort}&size=${pageSize}&page=${i}"
                                           class="page-link">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a href="${pageContext.request.contextPath}/catalog?action=search&q=${keyword}&sort=${sort}&size=${pageSize}&page=${currentPage + 1}"
                                   class="page-link">Sau →</a>
                            </c:if>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </main>

        <footer>
            <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary">← Quay lại trang chủ</a>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>

    <script>
        // Lazy Load Images with Intersection Observer
        // This improves performance by loading images only when they're visible
        (function() {
            // Check if browser supports Intersection Observer
            if ('IntersectionObserver' in window) {
                const imageElements = document.querySelectorAll('img.lazy');

                const imageObserver = new IntersectionObserver((entries, observer) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            const img = entry.target;
                            const dataSrc = img.getAttribute('data-src');

                            if (dataSrc) {
                                img.src = dataSrc;
                                img.removeAttribute('data-src');
                                img.classList.remove('lazy');
                            }

                            // Stop observing this image
                            observer.unobserve(img);
                        }
                    });
                }, {
                    rootMargin: '50px'  // Load images 50px before they're visible
                });

                imageElements.forEach(img => imageObserver.observe(img));
            } else {
                // Fallback for browsers that don't support Intersection Observer
                const imageElements = document.querySelectorAll('img.lazy');
                imageElements.forEach(img => {
                    const dataSrc = img.getAttribute('data-src');
                    if (dataSrc) {
                        img.src = dataSrc;
                        img.removeAttribute('data-src');
                        img.classList.remove('lazy');
                    }
                });
            }
        })();
    </script>
</body>
</html>
