<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm Kiếm Món Ăn - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <style>
        body {
            background: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
            padding: 24px 20px 18px;
            border-bottom: 2px solid #4a74db;
            margin-bottom: 30px;
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
            width: 100vw;
            position: relative;
            left: 50%;
            right: 50%;
            margin-left: -50vw;
            margin-right: -50vw;
            padding: 40px 0;
            background: #f8f8f8;
        }

        .content > * {
            max-width: 1100px;
            margin: 0 auto 30px;
            padding: 0 32px;
        }

        /* Search Section */
        .search-section {
            background: white;
            padding: 0;
            margin-bottom: 30px;
        }

        .search-section h2 {
            display: none;
        }

        .search-form {
            background: white;
            padding: 0;
            margin-bottom: 20px;
        }

        .search-input-group {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
            align-items: center;
        }

        .search-input {
            flex: 1;
            padding: 12px 20px;
            border: 2px solid #ddd;
            border-radius: 6px;
            font-size: 1em;
        }

        .search-input:focus {
            outline: none;
            border-color: #0066cc;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: #0066cc;
            color: white;
        }

        .btn-primary:hover {
            background: #0052a3;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .search-options {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            align-items: center;
        }

        .search-options label {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #555;
            font-size: 0.95em;
        }

        .search-options select {
            padding: 8px 12px;
            border: 2px solid #ddd;
            border-radius: 6px;
            font-size: 0.95em;
        }

        .search-options select:focus {
            outline: none;
            border-color: #0066cc;
        }

        /* Search Info */
        .search-info {
            text-align: left;
            margin-bottom: 20px;
            padding: 0;
            background: white;
            border: none;
        }

        .search-info p {
            color: #333;
            font-size: 1.2em;
            font-weight: 600;
            margin: 0;
        }

        .search-info strong {
            color: #0066cc;
        }

        /* Dishes Grid - exactly 3 columns */
        .dishes-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            margin-bottom: 40px;
        }

        .dish-card {
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .dish-card:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transform: translateY(-3px);
        }

        .dish-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .dish-info {
            padding: 20px;
        }

        .dish-info h3 {
            color: #333;
            margin-bottom: 8px;
            font-size: 1.2em;
            font-weight: 600;
        }

        .dish-category {
            display: inline-block;
            background: #e3f2fd;
            color: #0066cc;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 0.85em;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .dish-description {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 15px;
            line-height: 1.5;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            min-height: 42px;
        }

        .dish-price {
            color: #e74c3c;
            font-size: 1.4em;
            font-weight: 700;
            margin-bottom: 15px;
        }

        .dish-card .btn-view {
            background: #0066cc;
            color: white;
            padding: 10px 24px;
            border-radius: 6px;
            font-weight: 600;
            width: 80%;
            text-align: center;
            display: block;
            margin: 0 auto 10px;
        }

        .dish-card .btn-view:hover {
            background: #0052a3;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin-top: 40px;
        }

        .page-link {
            padding: 10px 16px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 6px;
            text-decoration: none;
            color: #333;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .page-link.active {
            background: #0066cc;
            color: white;
            border-color: #0066cc;
        }

        .page-link:hover:not(.active) {
            background: #f0f0f0;
        }

        /* Alert */
        .alert {
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .alert-info {
            background: #e3f2fd;
            border-left: 4px solid #0066cc;
            color: #0066cc;
        }

        .alert-info p {
            margin: 0 0 15px 0;
            color: #0066cc;
        }

        /* Footer */
        footer {
            background: #f8f9fa;
            padding: 25px;
            text-align: center;
            border-top: 1px solid #e0e0e0;
            display: flex;
            flex-direction: column;
            gap: 15px;
            align-items: center;
        }

        footer p {
            color: #666;
            margin: 0;
            font-size: 0.9em;
        }

        @media (max-width: 992px) {
            .dishes-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .dishes-grid {
                grid-template-columns: 1fr;
            }

            .search-input-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            header h1 {
                font-size: 1.5em;
            }
        }
    </style>
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
                                <c:choose>
                                    <c:when test="${not empty dish.imageUrl}">
                                        <img src="${pageContext.request.contextPath}${dish.imageUrl}"
                                             alt="${dish.name}"
                                             class="dish-image">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/images/no-image.jpg"
                                             alt="No image"
                                             class="dish-image">
                                    </c:otherwise>
                                </c:choose>
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
</body>
</html>
