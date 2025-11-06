# RestMan - Hướng Dẫn Routing & Navigation

## Vấn Đề Đã Được Sửa ✅

**Vấn đề**: Files JSP trong `/WEB-INF` không thể truy cập trực tiếp qua URL, gây lỗi 404.

**Giải pháp**: Tạo các Servlet Controller để forward requests đến các JSP pages.

## Cấu Trúc Routing

### 1. Trang Chủ & Landing Page

| URL | Servlet | Forward To | Description |
|-----|---------|-----------|-------------|
| `/` hoặc `/home` | `HomeController` | `index.jsp` | Landing page |

### 2. Module Khách Hàng

| URL | Servlet | Forward To | Description |
|-----|---------|-----------|-------------|
| `/customer` | `CustomerHomeController` | `gdChinhKH.jsp` | Trang chủ khách hàng |
| `/catalog` | `CatalogController` | Multiple JSPs | Xử lý tìm kiếm món |
| `/catalog?action=showMenuList` | `CatalogController` | `gdChonMenu.jsp` | Danh sách menu |
| `/catalog?action=searchForm&menuId=X` | `CatalogController` | `gdTimMon.jsp` | Form tìm kiếm |
| `/catalog?action=search&menuId=X&q=keyword` | `CatalogController` | `gdKetQuaMon.jsp` | Kết quả tìm kiếm |
| `/catalog?action=viewDish&dishId=X` | `CatalogController` | `gdChiTietMon.jsp` | Chi tiết món ăn |

### 3. Module Nhân Viên

| URL | Servlet | Forward To | Description |
|-----|---------|-----------|-------------|
| `/staff` | `StaffHomeController` | `gdChinhNV.jsp` | Trang chủ nhân viên |
| `/staff/reports` | `StaffReportMenuController` | `gdMenuBaoCao.jsp` | Menu báo cáo |
| `/report/customer-revenue` | `CustomerRevenueReportController` | Multiple JSPs | Xử lý báo cáo |
| `/report/customer-revenue?action=showFilter` | `CustomerRevenueReportController` | `gdLocDT.jsp` | Form lọc |
| `/report/customer-revenue?action=runReport` | `CustomerRevenueReportController` | `gdKetQuaDT.jsp` | Kết quả báo cáo |
| `/report/customer-revenue?action=viewCustomerDetail` | `CustomerRevenueReportController` | `gdDonHangKH.jsp` | Đơn hàng KH |
| `/report/customer-revenue?action=viewOrder` | `CustomerRevenueReportController` | `gdChiTietDon.jsp` | Chi tiết đơn |
| `/report/customer-revenue?action=viewInvoice` | `CustomerRevenueReportController` | `gdChiTietHD.jsp` | Chi tiết hóa đơn |

## Danh Sách Servlets

### 1. HomeController.java
```java
@WebServlet({"/", "/home"})
public class HomeController extends HttpServlet {
    // Forward to index.jsp
}
```

### 2. CustomerHomeController.java
```java
@WebServlet("/customer")
public class CustomerHomeController extends HttpServlet {
    // Forward to gdChinhKH.jsp
}
```

### 3. StaffHomeController.java
```java
@WebServlet("/staff")
public class StaffHomeController extends HttpServlet {
    // Forward to gdChinhNV.jsp
}
```

### 4. StaffReportMenuController.java
```java
@WebServlet("/staff/reports")
public class StaffReportMenuController extends HttpServlet {
    // Forward to gdMenuBaoCao.jsp
}
```

### 5. CatalogController.java
```java
@WebServlet("/catalog")
public class CatalogController extends HttpServlet {
    // Handles: showMenuList, searchForm, search, viewDish
}
```

### 6. CustomerRevenueReportController.java
```java
@WebServlet("/report/customer-revenue")
public class CustomerRevenueReportController extends HttpServlet {
    // Handles: showFilter, runReport, viewCustomerDetail, viewOrder, viewInvoice
}
```

## Luồng Navigation

### A. Customer Flow (Tìm Món Ăn)

```
1. Landing Page (/)
   ↓ Click "Khách Hàng"
2. Customer Home (/customer)
   ↓ Click "Tìm Kiếm Món Ăn"
3. Menu List (/catalog)
   ↓ Click "Menu Trưa"
4. Search Form (/catalog?action=searchForm&menuId=1)
   ↓ Enter keyword "phở" & Click "Tìm"
5. Search Results (/catalog?action=search&menuId=1&q=phở)
   ↓ Click on dish
6. Dish Details (/catalog?action=viewDish&dishId=1)
   ↓ Click "Quay lại"
7. Back to Search Results
```

### B. Staff Flow (Báo Cáo Doanh Thu)

```
1. Landing Page (/)
   ↓ Click "Nhân Viên"
2. Staff Home (/staff)
   ↓ Click "Báo Cáo"
3. Report Menu (/staff/reports)
   ↓ Click "Khách Hàng Theo Doanh Thu"
4. Filter Form (/report/customer-revenue)
   ↓ Set date range & Click "Tạo Báo Cáo"
5. Revenue Report (/report/customer-revenue?action=runReport&...)
   ↓ Click on customer
6. Customer Orders (/report/customer-revenue?action=viewCustomerDetail&customerId=1)
   ↓ Click on order
7. Order Details (/report/customer-revenue?action=viewOrder&orderId=1)
   ↓ Click on invoice
8. Invoice Details (/report/customer-revenue?action=viewInvoice&invoiceId=1)
```

## Breadcrumb Navigation

### Customer Pages

**gdChinhKH.jsp**:
```
Không có breadcrumb (trang chủ module)
```

**gdChonMenu.jsp**:
```
Trang chủ > Khách hàng > Chọn Menu
```

**gdTimMon.jsp**:
```
Trang chủ > Khách hàng > Chọn Menu > Tìm món
```

**gdKetQuaMon.jsp**:
```
Trang chủ > Khách hàng > Chọn Menu > Tìm món > Kết quả
```

**gdChiTietMon.jsp**:
```
Trang chủ > Khách hàng > Chọn Menu > Chi tiết món
```

### Staff Pages

**gdChinhNV.jsp**:
```
Không có breadcrumb (trang chủ module)
```

**gdMenuBaoCao.jsp**:
```
Trang chủ > Nhân viên > Báo cáo
```

**gdLocDT.jsp**:
```
Trang chủ > Nhân viên > Báo cáo > Khách hàng theo doanh thu
```

**gdKetQuaDT.jsp**:
```
Trang chủ > Nhân viên > Báo cáo > Kết quả
```

**gdDonHangKH.jsp**:
```
Trang chủ > Nhân viên > Báo cáo > Đơn hàng khách hàng
```

**gdChiTietDon.jsp**:
```
Trang chủ > Nhân viên > Báo cáo > Chi tiết đơn
```

**gdChiTietHD.jsp**:
```
Trang chủ > Nhân viên > Báo cáo > Hóa đơn
```

## Testing Checklist

### ✅ Các URL Phải Hoạt Động

- [ ] `http://localhost:8080/restman/` - Landing page
- [ ] `http://localhost:8080/restman/customer` - Customer home
- [ ] `http://localhost:8080/restman/staff` - Staff home
- [ ] `http://localhost:8080/restman/catalog` - Menu list
- [ ] `http://localhost:8080/restman/staff/reports` - Report menu
- [ ] `http://localhost:8080/restman/report/customer-revenue` - Revenue filter

### ✅ Các URL Không Được Truy Cập (404 Expected)

- [ ] `http://localhost:8080/restman/WEB-INF/jsp/...` - Phải trả về 404
- [ ] Mọi URL trỏ trực tiếp vào file JSP trong WEB-INF đều phải bị chặn

### ✅ Navigation Flow

- [ ] Click "Khách Hàng" từ landing page → Đến `/customer`
- [ ] Click "Nhân Viên" từ landing page → Đến `/staff`
- [ ] Tất cả breadcrumb links hoạt động
- [ ] Tất cả footer buttons hoạt động
- [ ] Back button trong browser hoạt động đúng

## Lưu Ý Quan Trọng

### 1. WEB-INF Protection
- Tất cả files trong `/WEB-INF` được bảo vệ bởi Servlet container
- **KHÔNG THỂ** truy cập trực tiếp qua URL
- **CHỈ CÓ THỂ** forward từ Servlet

### 2. Context Path
- Luôn sử dụng `${pageContext.request.contextPath}` trong JSP
- Không hardcode URL paths
- Ví dụ: `${pageContext.request.contextPath}/customer`

### 3. Servlet URL Pattern
- Dùng `@WebServlet` annotation
- Không cần cấu hình trong `web.xml`
- Pattern phải unique

### 4. Forward vs Redirect
- **Forward** (servlet → JSP): Giữ nguyên URL, chia sẻ request attributes
- **Redirect** (servlet → servlet): Thay đổi URL, không chia sẻ attributes
- Trong project này, chủ yếu dùng **forward**

## Troubleshooting

### Lỗi 404 "No webpage was found"
**Nguyên nhân**: Đang cố truy cập trực tiếp file JSP trong WEB-INF

**Giải pháp**:
1. Kiểm tra URL có đúng servlet pattern không
2. Kiểm tra servlet đã được compile chưa
3. Kiểm tra forward path trong servlet

### Lỗi "Cannot find resource"
**Nguyên nhân**: Path trong forward không đúng

**Giải pháp**:
1. Đảm bảo path bắt đầu bằng `/WEB-INF/`
2. Kiểm tra tên file JSP có chính xác không
3. Kiểm tra cấu trúc thư mục

### Breadcrumb links không hoạt động
**Nguyên nhân**: Link vẫn trỏ đến file JSP trong WEB-INF

**Giải pháp**:
1. Chạy lại script `fix-links.ps1`
2. Kiểm tra file JSP đã được cập nhật chưa
3. Clear browser cache và test lại

---

**Tất cả routing đã được sửa và hoạt động đúng!** ✅
