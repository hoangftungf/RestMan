# RestMan - Hệ Thống Quản Lý Nhà Hàng

RestMan là một ứng dụng web quản lý nhà hàng được phát triển bằng Java Servlet/JSP với MySQL database.

## Tính năng

### Module Khách Hàng
- **Tìm kiếm món ăn**: Khách hàng có thể tìm kiếm thông tin món ăn theo menu
  - Chọn menu (Trưa, Tối, Đặc biệt, v.v.)
  - Tìm kiếm món ăn theo từ khóa
  - Xem danh sách kết quả với phân trang và sắp xếp
  - Xem chi tiết món ăn (tên, mô tả, giá, hình ảnh)

### Module Nhân Viên
- **Thống kê khách hàng theo doanh thu**: Nhân viên có thể xem báo cáo khách hàng
  - Lọc theo khoảng thời gian
  - Lọc theo hạng thành viên (Bronze, Silver, Gold, VIP)
  - Lọc theo doanh thu tối thiểu
  - Xem top N khách hàng
  - Xem chi tiết đơn hàng của khách
  - Xem chi tiết hóa đơn

## Cấu trúc dự án

```
RestMan/
├── sql/
│   ├── schema.sql          # Database schema
│   └── sample_data.sql     # Dữ liệu mẫu
├── src/
│   └── main/
│       ├── java/
│       │   ├── dao/        # Data Access Objects
│       │   ├── model/      # Entity models
│       │   │   ├── enums/  # Enumerations
│       │   │   └── vm/     # View Models
│       │   ├── servlet/    # Controllers
│       │   └── util/       # Utilities (DBUtil)
│       └── webapp/
│           ├── css/        # CSS files
│           ├── WEB-INF/
│           │   └── jsp/    # JSP pages
│           │       ├── customer/  # Customer pages
│           │       └── staff/     # Staff pages
│           └── index.jsp   # Landing page
├── pom.xml
├── .env.example
└── README.md
```

## Công nghệ sử dụng

- **Backend**: Java 17, Servlet 4.0, JSP, JSTL
- **Database**: MySQL 8.x
- **Build Tool**: Maven
- **Libraries**:
  - MySQL Connector/J 8.3.0
  - jBCrypt 0.4 (password hashing)
  - dotenv-java 3.0.0 (environment variables)
  - SLF4J 2.0.7 (logging)

## Cài đặt

### 1. Yêu cầu hệ thống
- JDK 17 hoặc cao hơn
- Maven 3.6+
- MySQL 8.x
- Apache Tomcat 9.x hoặc 10.x

### 2. Cấu hình database

Tạo database:
```sql
CREATE DATABASE restman_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Chạy script tạo bảng:
```bash
mysql -u root -p restman_db < sql/schema.sql
```

Nạp dữ liệu mẫu (tùy chọn):
```bash
mysql -u root -p restman_db < sql/sample_data.sql
```

### 3. Cấu hình môi trường

Copy file `.env.example` thành `.env` và cập nhật thông tin database:
```bash
cp .env.example .env
```

Chỉnh sửa file `.env`:
```properties
JDBC_URL=jdbc:mysql://localhost:3306/restman_db?useSSL=false&serverTimezone=UTC
JDBC_USER=root
JDBC_PASS=your_password
```

### 4. Build và chạy ứng dụng

Build project:
```bash
mvn clean package
```

Chạy với Tomcat Maven Plugin:
```bash
mvn tomcat7:run
```

Hoặc deploy file WAR vào Tomcat server:
```bash
cp target/RestMan-1.0-SNAPSHOT.war $TOMCAT_HOME/webapps/
```

Truy cập ứng dụng tại: `http://localhost:8080/restman`

## Sử dụng

### Module Khách Hàng
1. Truy cập trang chủ và chọn "Khách Hàng"
2. Chọn "Tìm Kiếm Món Ăn"
3. Chọn menu muốn tìm (Trưa/Tối/Đặc biệt)
4. Nhập từ khóa tìm kiếm (hoặc để trống để xem tất cả)
5. Chọn cách sắp xếp và số món hiển thị
6. Click vào món ăn để xem chi tiết

### Module Nhân Viên
1. Truy cập trang chủ và chọn "Nhân Viên"
2. Chọn "Báo Cáo"
3. Chọn "Khách Hàng Theo Doanh Thu"
4. Nhập các điều kiện lọc:
   - Ngày bắt đầu và kết thúc
   - Hạng thành viên (tùy chọn)
   - Doanh thu tối thiểu (tùy chọn)
   - Top N khách hàng (tùy chọn)
5. Click "Tạo Báo Cáo"
6. Click vào khách hàng để xem chi tiết đơn hàng
7. Click vào đơn hàng để xem chi tiết
8. Click vào hóa đơn để xem/in hóa đơn

## Database Schema

### Các bảng chính:
- `tblAccount`: Tài khoản người dùng
- `tblCustomer`: Thông tin khách hàng
- `tblMembershipCard`: Thẻ thành viên
- `tblMenu`: Menu món ăn
- `tblDish`: Món ăn
- `tblMenuItem`: Món ăn trong menu
- `tblOrder`: Đơn hàng
- `tblOrderItem`: Chi tiết đơn hàng
- `tblInvoice`: Hóa đơn thanh toán

Chi tiết schema xem file [sql/schema.sql](sql/schema.sql)

## API Endpoints

### Customer Module
- `GET /catalog` - Show menu list
- `GET /catalog?action=searchForm&menuId={id}` - Show search form
- `GET /catalog?action=search&menuId={id}&q={keyword}` - Search dishes
- `GET /catalog?action=viewDish&dishId={id}` - View dish details

### Staff Module
- `GET /report/customer-revenue` - Show filter form
- `GET /report/customer-revenue?action=runReport&fromDate={date}&toDate={date}` - Run report
- `GET /report/customer-revenue?action=viewCustomerDetail&customerId={id}` - View customer orders
- `GET /report/customer-revenue?action=viewOrder&orderId={id}` - View order details
- `GET /report/customer-revenue?action=viewInvoice&invoiceId={id}` - View invoice

## Tác giả

Phát triển bởi Team PTTK - Phân Tích Thiết Kế Hệ Thống

## License

This project is for educational purposes.
