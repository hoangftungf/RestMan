<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Món - ${dish.name}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>📋 Chi Tiết Món Ăn</h1>
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/WEB-INF/jsp/customer/gdChinhKH.jsp">Trang chủ</a>
                <span>›</span>
                <a href="${pageContext.request.contextPath}/catalog">Chọn Menu</a>
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
                                <img src="${pageContext.request.contextPath}${dish.imageUrl}"
                                     alt="${dish.name}"
                                     onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'">
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
            <button onclick="history.back()" class="btn btn-secondary">← Quay lại</button>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
