<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Món - ${dish.name}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css">
</head>
<body>
    <!-- System Header -->
    <jsp:include page="/WEB-INF/jsp/common/systemHeader.jsp" />

    <div class="container">
        <header class="page-header">
            <h1>📋 Chi Tiết Món Ăn</h1>
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/customer">Trang chủ</a>
                <span>›</span>
                <a href="${pageContext.request.contextPath}/catalog">Tìm kiếm món ăn</a>
                <span>›</span>
                <span>Chi tiết món</span>
            </nav>
        </header>

        <main class="content">
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <c:if test="${not empty dish}">
                <div class="dish-detail">
                    <div class="dish-detail-image">
                        <c:choose>
                            <c:when test="${not empty dish.imageUrl}">
                                <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 400 400'%3E%3Crect fill='%23f0f0f0' width='400' height='400'/%3E%3C/svg%3E"
                                     data-src="${pageContext.request.contextPath}${dish.imageUrl}"
                                     alt="${dish.name}"
                                     class="lazy"
                                     onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'; this.classList.remove('lazy')">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/images/no-image.jpg" alt="No image">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="dish-detail-info">
                        <h2>${dish.name}</h2>

                        <div class="detail-section">
                            <h3>Danh mục</h3>
                            <p class="dish-category">${dish.category}</p>
                        </div>

                        <div class="detail-section">
                            <h3>Mô tả</h3>
                            <p class="dish-description">${dish.description}</p>
                        </div>

                        <div class="detail-section">
                            <h3>Giá bán</h3>
                            <p class="dish-price-large">${dish.formattedPrice}</p>
                        </div>

                        <c:if test="${not empty dish.ingredients}">
                            <div class="detail-section">
                                <h3>Nguyên liệu</h3>
                                <ul class="ingredients-list">
                                    <c:forEach var="ingredient" items="${dish.ingredients}">
                                        <li>${ingredient}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>
        </main>

        <footer>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>

    <script>
        // Lazy Load Images with Intersection Observer
        (function() {
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
                            observer.unobserve(img);
                        }
                    });
                }, { rootMargin: '50px' });

                imageElements.forEach(img => imageObserver.observe(img));
            } else {
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
