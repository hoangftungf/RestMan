# Hướng Dẫn Sửa Links Trong JSP Files

## Vấn Đề

Files JSP trong `/WEB-INF` **KHÔNG THỂ** truy cập trực tiếp qua URL.
Phải dùng Servlet để forward.

## Giải Pháp

### Đã Tạo Các Servlet

1. **HomeController** (`/` hoặc `/home`) → forward đến `index.jsp`
2. **CustomerHomeController** (`/customer`) → forward đến `gdChinhKH.jsp`
3. **StaffHomeController** (`/staff`) → forward đến `gdChinhNV.jsp`
4. **StaffReportMenuController** (`/staff/reports`) → forward đến `gdMenuBaoCao.jsp`
5. **CatalogController** (`/catalog`) → xử lý tìm kiếm món ăn
6. **CustomerRevenueReportController** (`/report/customer-revenue`) → xử lý báo cáo

### Cần Thay Đổi Trong Các JSP Files

#### Thay đổi breadcrumb links:

**TỪ (SAI):**
```jsp
<a href="${pageContext.request.contextPath}/WEB-INF/jsp/customer/gdChinhKH.jsp">Trang chủ</a>
```

**THÀNH (ĐÚNG):**
```jsp
<a href="${pageContext.request.contextPath}/">Trang chủ</a>
<a href="${pageContext.request.contextPath}/customer">Khách hàng</a>
<a href="${pageContext.request.contextPath}/staff">Nhân viên</a>
```

### Chi Tiết Các File Cần Sửa:

#### 1. customer/gdChinhKH.jsp
```jsp
<!-- KHÔNG CẦN breadcrumb vì là trang chủ module -->
```

#### 2. customer/gdChonMenu.jsp
```jsp
<nav class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/customer">Khách hàng</a>
    <span>›</span>
    <span>Chọn Menu</span>
</nav>
```

#### 3. customer/gdTimMon.jsp
```jsp
<nav class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/customer">Khách hàng</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/catalog">Chọn Menu</a>
    <span>›</span>
    <span>Tìm món</span>
</nav>
```

#### 4. customer/gdKetQuaMon.jsp
```jsp
<nav class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/customer">Khách hàng</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/catalog">Chọn Menu</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/catalog?action=searchForm&menuId=${menu.id}">Tìm món</a>
    <span>›</span>
    <span>Kết quả</span>
</nav>
```

#### 5. customer/gdChiTietMon.jsp
```jsp
<nav class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/customer">Khách hàng</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/catalog">Chọn Menu</a>
    <span>›</span>
    <span>Chi tiết món</span>
</nav>
```

#### 6. staff/gdChinhNV.jsp
```jsp
<!-- KHÔNG CẦN breadcrumb vì là trang chủ module -->
```

#### 7. staff/gdMenuBaoCao.jsp
```jsp
<nav class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/staff">Nhân viên</a>
    <span>›</span>
    <span>Báo cáo</span>
</nav>
```

#### 8. staff/gdLocDT.jsp
```jsp
<nav class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/staff">Nhân viên</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/staff/reports">Báo cáo</a>
    <span>›</span>
    <span>Khách hàng theo doanh thu</span>
</nav>
```

#### 9. staff/gdKetQuaDT.jsp
```jsp
<nav class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/staff">Nhân viên</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/staff/reports">Báo cáo</a>
    <span>›</span>
    <span>Kết quả</span>
</nav>
```

#### 10. staff/gdDonHangKH.jsp
```jsp
<nav class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/staff">Nhân viên</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/staff/reports">Báo cáo</a>
    <span>›</span>
    <span>Đơn hàng khách hàng</span>
</nav>
```

#### 11. staff/gdChiTietDon.jsp
```jsp
<nav class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/staff">Nhân viên</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/staff/reports">Báo cáo</a>
    <span>›</span>
    <span>Chi tiết đơn</span>
</nav>
```

#### 12. staff/gdChiTietHD.jsp
```jsp
<nav class="breadcrumb">
    <a href="${pageContext.request.contextPath}/">Trang chủ</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/staff">Nhân viên</a>
    <span>›</span>
    <a href="${pageContext.request.contextPath}/staff/reports">Báo cáo</a>
    <span>›</span>
    <span>Hóa đơn</span>
</nav>
```

### Thay Đổi Footer Links

**TỪ (SAI):**
```jsp
<a href="${pageContext.request.contextPath}/WEB-INF/jsp/staff/gdChinhNV.jsp" class="btn btn-secondary">← Quay lại</a>
<a href="${pageContext.request.contextPath}/WEB-INF/jsp/staff/gdMenuBaoCao.jsp" class="btn btn-secondary">Menu báo cáo</a>
```

**THÀNH (ĐÚNG):**
```jsp
<a href="${pageContext.request.contextPath}/staff" class="btn btn-secondary">← Quay lại</a>
<a href="${pageContext.request.contextPath}/staff/reports" class="btn btn-secondary">Menu báo cáo</a>
```

### Cách Sửa Nhanh (Tìm và Thay Thế)

Dùng Find & Replace trong IDE:

**Tìm:** `/WEB-INF/jsp/customer/gdChinhKH.jsp`
**Thay bằng:** `/customer`

**Tìm:** `/WEB-INF/jsp/staff/gdChinhNV.jsp`
**Thay bằng:** `/staff`

**Tìm:** `/WEB-INF/jsp/staff/gdMenuBaoCao.jsp`
**Thay bằng:** `/staff/reports`

## URL Mapping Cuối Cùng

| URL | Controller | JSP Page |
|-----|-----------|----------|
| `/` hoặc `/home` | HomeController | index.jsp |
| `/customer` | CustomerHomeController | gdChinhKH.jsp |
| `/staff` | StaffHomeController | gdChinhNV.jsp |
| `/staff/reports` | StaffReportMenuController | gdMenuBaoCao.jsp |
| `/catalog` | CatalogController | gdChonMenu.jsp, gdTimMon.jsp, gdKetQuaMon.jsp, gdChiTietMon.jsp |
| `/report/customer-revenue` | CustomerRevenueReportController | gdLocDT.jsp, gdKetQuaDT.jsp, gdDonHangKH.jsp, gdChiTietDon.jsp, gdChiTietHD.jsp |

## Test Sau Khi Sửa

1. Truy cập: `http://localhost:8080/restman/`
2. Click "Khách Hàng" → Phải đến `/customer`
3. Click "Tìm Kiếm Món Ăn" → Phải đến `/catalog`
4. Click "Nhân Viên" → Phải đến `/staff`
5. Click "Báo Cáo" → Phải đến `/staff/reports`
6. Click "Khách Hàng Theo Doanh Thu" → Phải đến `/report/customer-revenue`

Tất cả breadcrumbs phải hoạt động và không có lỗi 404!
