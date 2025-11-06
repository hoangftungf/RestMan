# Hướng Dẫn Cài Đặt Nhanh RestMan

## Bước 1: Chuẩn Bị Môi Trường

### Kiểm tra Java (cần JDK 17 trở lên)
```bash
java -version
javac -version
```

### Kiểm tra MySQL (cần MySQL 8.x)
```bash
mysql --version
```

## Bước 2: Tạo Database

1. Mở MySQL command line hoặc MySQL Workbench

2. Tạo database:
```sql
CREATE DATABASE restman_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

3. Import schema:
```bash
mysql -u root -p restman_db < sql/schema.sql
```

4. Import dữ liệu mẫu:
```bash
mysql -u root -p restman_db < sql/sample_data.sql
```

## Bước 3: Cấu Hình Kết Nối Database

1. File `.env` đã được tạo sẵn, chỉnh sửa nó:
```properties
JDBC_URL=jdbc:mysql://localhost:3306/restman_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
JDBC_USER=root
JDBC_PASS=your_password_here
```

2. Thay `your_password_here` bằng mật khẩu MySQL của bạn

## Bước 4: Build và Chạy

### Cách 1: Sử dụng Maven (khuyến nghị)

```bash
# Build project
mvn clean package

# Chạy với Tomcat embedded
mvn tomcat7:run
```

Truy cập: http://localhost:8080/restman

### Cách 2: Deploy lên Tomcat Server

```bash
# Build WAR file
mvn clean package

# Copy WAR file vào Tomcat
copy target\RestMan-1.0-SNAPSHOT.war %TOMCAT_HOME%\webapps\

# Khởi động Tomcat
%TOMCAT_HOME%\bin\startup.bat
```

Truy cập: http://localhost:8080/RestMan-1.0-SNAPSHOT

### Cách 3: Sử dụng IDE (NetBeans/IntelliJ/Eclipse)

1. Import project as Maven project
2. Configure Tomcat server trong IDE
3. Run/Debug project từ IDE

## Bước 5: Kiểm Tra

### Test Module Khách Hàng
1. Truy cập trang chủ
2. Chọn "Khách Hàng"
3. Click "Tìm Kiếm Món Ăn"
4. Chọn menu "Menu Trưa"
5. Tìm món (ví dụ: "phở")
6. Xem chi tiết món

### Test Module Nhân Viên
1. Truy cập trang chủ
2. Chọn "Nhân Viên"
3. Click "Báo Cáo"
4. Chọn "Khách Hàng Theo Doanh Thu"
5. Nhập ngày: 2025-01-01 đến 2025-12-31
6. Click "Tạo Báo Cáo"
7. Xem chi tiết khách hàng

## Bước 6: Dữ Liệu Mẫu

Sau khi import `sample_data.sql`, bạn sẽ có:
- 5 khách hàng với thẻ thành viên
- 6 món ăn trong menu
- 3 đơn hàng đã hoàn thành
- 3 hóa đơn đã thanh toán

## Xử Lý Lỗi Thường Gặp

### Lỗi: Cannot connect to database
**Giải pháp:**
- Kiểm tra MySQL đã chạy chưa
- Kiểm tra thông tin trong file `.env`
- Kiểm tra database `restman_db` đã được tạo chưa

### Lỗi: ClassNotFoundException: com.mysql.cj.jdbc.Driver
**Giải pháp:**
- Chạy `mvn clean install` để tải dependencies
- Kiểm tra file `pom.xml` có mysql-connector-j chưa

### Lỗi: 404 Not Found
**Giải pháp:**
- Kiểm tra URL đúng chưa: http://localhost:8080/restman
- Kiểm tra Tomcat đã deploy WAR file chưa
- Xem log trong Tomcat để tìm lỗi

### Lỗi: HTTP 500 Internal Server Error
**Giải pháp:**
- Xem log file trong Tomcat/logs hoặc console
- Kiểm tra database connection
- Kiểm tra các servlet đã được compile chưa

## Cấu Trúc URL

- Trang chủ: `/`
- Module khách hàng: `/WEB-INF/jsp/customer/gdChinhKH.jsp`
- Module nhân viên: `/WEB-INF/jsp/staff/gdChinhNV.jsp`
- Tìm món ăn: `/catalog`
- Báo cáo doanh thu: `/report/customer-revenue`

## Liên Hệ & Hỗ Trợ

Nếu gặp vấn đề, vui lòng kiểm tra:
1. Log file trong Tomcat
2. Browser console (F12)
3. Database có dữ liệu chưa
4. Firewall/Antivirus có chặn port 8080 không

---

Chúc bạn sử dụng RestMan thành công! 🍽️
