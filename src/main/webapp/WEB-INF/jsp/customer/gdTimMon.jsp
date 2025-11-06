<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm Món - ${menu.name}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🔍 Tìm Kiếm Món Ăn</h1>
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/WEB-INF/jsp/customer/gdChinhKH.jsp">Trang chủ</a>
                <span>›</span>
                <a href="${pageContext.request.contextPath}/catalog">Chọn Menu</a>
                <span>›</span>
                <span>Tìm món</span>
            </nav>
        </header>

        <main class="content">
            <div class="search-section">
                <h2>${menu.name}</h2>
                <p class="menu-description">${menu.description}</p>

                <form action="${pageContext.request.contextPath}/catalog" method="get" class="search-form">
                    <input type="hidden" name="action" value="search">
                    <input type="hidden" name="menuId" value="${menu.id}">

                    <div class="search-input-group">
                        <input type="text" name="q" id="keyword"
                               placeholder="Nhập tên món ăn cần tìm..."
                               class="search-input"
                               autofocus>
                        <button type="submit" class="btn btn-primary">TÌM KIẾM</button>
                    </div>

                    <div class="search-options">
                        <label>
                            Sắp xếp:
                            <select name="sort">
                                <option value="name_asc">Tên (A-Z)</option>
                                <option value="name_desc">Tên (Z-A)</option>
                                <option value="price_asc">Giá (Thấp đến Cao)</option>
                                <option value="price_desc">Giá (Cao đến Thấp)</option>
                            </select>
                        </label>

                        <label>
                            Hiển thị:
                            <select name="size">
                                <option value="12">12 món/trang</option>
                                <option value="24">24 món/trang</option>
                                <option value="48">48 món/trang</option>
                            </select>
                        </label>
                    </div>
                </form>

                <div class="help-text">
                    <p>💡 Mẹo: Bạn có thể để trống từ khóa để xem tất cả các món trong menu này.</p>
                </div>
            </div>
        </main>

        <footer>
            <a href="${pageContext.request.contextPath}/catalog" class="btn btn-secondary">← Quay lại</a>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
