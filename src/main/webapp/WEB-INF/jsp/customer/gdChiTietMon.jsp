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
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            color: #1f2a44;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            background: transparent;
            padding-bottom: 40px;
        }

        .page-header {
            background: #fff;
            color: #1f2a44;
            padding: 24px 10px 18px;
            border-bottom: 2px solid #4a74db;
            margin-bottom: 25px;
            width: 100vw;
            position: relative;
            left: 50%;
            right: 50%;
            margin-left: -50vw;
            margin-right: -50vw;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.08);
        }

        .page-header h1 {
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .breadcrumb {
            display: inline-flex;
            gap: 8px;
            font-size: 0.95rem;
        }

        .breadcrumb a {
            color: #4a74db;
            text-decoration: none;
        }

        .content {
            padding: 40px 32px;
            max-width: 1100px;
            margin: 0 auto;
        }

        .dish-detail-page {
            display: flex;
            justify-content: center;
        }

        .dish-detail-card {
            width: min(560px, 100%);
            margin: 0 auto;
            background: #fff;
            border-radius: 18px;
            border: 1px solid #e4e8f0;
            box-shadow: 0 15px 45px rgba(31, 56, 134, 0.08);
            overflow: hidden;
        }

        .dish-card-image {
            width: 100%;
            height: 220px;
            background: #f4f6fb;
            border-bottom: 1px solid #e4e8f0;
        }

        .dish-card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .dish-card-body {
            padding: 30px 32px 10px;
        }

        .dish-card-title {
            font-size: 1.9em;
            margin-bottom: 12px;
            color: #1f2a44;
        }

        .dish-card-category {
            display: inline-block;
            padding: 6px 16px;
            background: #e8f1ff;
            color: #1a57d9;
            border-radius: 999px;
            font-size: 0.9em;
            font-weight: 600;
            margin-bottom: 16px;
        }

        .dish-card-description {
            color: #5b6174;
            font-size: 1.05em;
            line-height: 1.7;
        }

        .dish-price-large {
            color: #e74c3c;
            font-size: 2.1em;
            font-weight: 700;
            margin: 18px 0 12px;
        }

        .dish-card-extra {
            border-top: 1px solid #e4e8f0;
            padding: 20px 32px 28px;
        }

        .dish-card-extra h3 {
            color: #1f2a44;
            font-size: 1.05em;
            margin-bottom: 12px;
        }

        .ingredients-list {
            list-style: none;
            padding-left: 0;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 0;
        }

        .ingredients-list li {
            padding: 6px 14px;
            border-radius: 999px;
            background: #f1f4fb;
            color: #3f4560;
            font-weight: 600;
            font-size: 0.9em;
        }

        footer {
            text-align: center;
            padding: 24px;
            color: #666;
        }

        @media (max-width: 768px) {
            .content {
                padding: 30px 18px;
            }

            .dish-card-image {
                height: 180px;
            }

            .dish-card-body,
            .dish-card-extra {
                padding: 22px 20px;
            }

            .dish-card-title {
                font-size: 1.6em;
            }
        }

        @media (max-width: 576px) {
            .page-header {
                padding: 24px;
            }

            .dish-detail-card {
                border-radius: 14px;
            }
        }
    </style>
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

        <main class="content dish-detail-page">
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <c:if test="${not empty dish}">
                <section class="dish-detail-card">
                    <div class="dish-card-image">
                        <c:choose>
                            <c:when test="${not empty dish.imageUrl}">
                                <img src="${pageContext.request.contextPath}${dish.imageUrl}"
                                     alt="${dish.name}">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/images/no-image.jpg" alt="No image">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="dish-card-body">
                        <h2 class="dish-card-title">${dish.name}</h2>
                        <c:if test="${not empty dish.category}">
                            <span class="dish-card-category">${dish.category}</span>
                        </c:if>
                        <p class="dish-card-description">${dish.description}</p>
                        <p class="dish-price-large">${dish.formattedPrice}</p>
                    </div>

                    <c:if test="${not empty dish.ingredients}">
                        <div class="dish-card-extra">
                            <h3>Nguyên liệu</h3>
                            <ul class="ingredients-list">
                                <c:forEach var="ingredient" items="${dish.ingredients}">
                                    <li>${ingredient}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                </section>
            </c:if>
        </main>

        <footer>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
