<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn Menu - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🔍 Tìm Kiếm Món Ăn</h1>
            <nav class="breadcrumb">
                <a href="${pageContext.request.contextPath}/WEB-INF/jsp/customer/gdChinhKH.jsp">Trang chủ</a>
                <span>›</span>
                <span>Chọn Menu</span>
            </nav>
        </header>

        <main class="content">
            <h2>Chọn Menu để tìm món</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <c:choose>
                <c:when test="${empty menus}">
                    <div class="alert alert-info">
                        Hiện tại không có menu nào đang hoạt động.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="menu-grid">
                        <c:forEach var="menu" items="${menus}">
                            <a href="${pageContext.request.contextPath}/catalog?action=searchForm&menuId=${menu.id}" class="menu-card">
                                <h3>${menu.name}</h3>
                                <p class="menu-type">${menu.type}</p>
                                <c:if test="${not empty menu.description}">
                                    <p class="menu-description">${menu.description}</p>
                                </c:if>
                                <div class="menu-period">
                                    <c:if test="${not empty menu.effectiveFrom}">
                                        <span>Từ: ${menu.effectiveFrom}</span>
                                    </c:if>
                                    <c:if test="${not empty menu.effectiveTo}">
                                        <span>Đến: ${menu.effectiveTo}</span>
                                    </c:if>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>

        <footer>
            <p>&copy; 2025 RestMan. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
