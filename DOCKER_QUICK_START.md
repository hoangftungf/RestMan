# 🐳 RestMan - Docker Quick Start Guide

## ✅ Tất Cả Vấn Đề Đã Được Sửa

- ✅ Chuyển từ `javax.*` sang `jakarta.*` (Tomcat 10.1 compatible)
- ✅ Cập nhật JSTL 3.0 Jakarta
- ✅ Đặt `finalName=restman` cho context path đơn giản
- ✅ Cập nhật web.xml sang Jakarta EE 9+
- ✅ Tất cả servlet đã migrate sang jakarta.servlet

## 🚀 Deploy Trong 3 Bước

### Bước 1: Build WAR File

```bash
mvn clean package
```

**Kết quả:** File `target/restman.war` được tạo

### Bước 2: Start Docker Compose

```bash
docker-compose up -d
```

**Quá trình:**
1. Build Docker image cho RestMan
2. Pull MySQL 8.0 image
3. Tạo MySQL container với database `restman_db`
4. Import schema và sample data tự động
5. Start RestMan container
6. Wait for health checks

### Bước 3: Truy Cập Ứng Dụng

```
http://localhost:8080/
```

**Hoặc từ máy khác trong mạng:**
```
http://<your-ip>:8080/
```

## 🎯 URL Endpoints

| Module | URL | Description |
|--------|-----|-------------|
| Landing Page | `http://localhost:8080/` | Trang chủ |
| Customer | `http://localhost:8080/customer` | Module khách hàng |
| Staff | `http://localhost:8080/staff` | Module nhân viên |
| Catalog | `http://localhost:8080/catalog` | Tìm món ăn |
| Reports | `http://localhost:8080/staff/reports` | Menu báo cáo |
| Revenue | `http://localhost:8080/report/customer-revenue` | Báo cáo doanh thu |

## 📊 Kiểm Tra Trạng Thái

### Xem Logs

```bash
# Xem tất cả logs
docker-compose logs -f

# Chỉ xem logs của RestMan
docker-compose logs -f restman

# Chỉ xem logs của MySQL
docker-compose logs -f mysql
```

### Kiểm Tra Containers

```bash
# Xem containers đang chạy
docker-compose ps

# Kiểm tra health status
docker ps
```

### Kiểm Tra Database

```bash
# Kết nối vào MySQL container
docker exec -it restman-mysql mysql -u restman -prestman123

# Trong MySQL shell
mysql> USE restman_db;
mysql> SHOW TABLES;
mysql> SELECT * FROM tblDish;
mysql> SELECT * FROM tblCustomer;
```

## 🛠️ Các Lệnh Hữu Ích

### Stop & Remove

```bash
# Stop containers
docker-compose stop

# Stop và remove containers
docker-compose down

# Stop, remove containers + volumes (XÓA DỮ LIỆU DATABASE)
docker-compose down -v
```

### Rebuild

```bash
# Rebuild WAR file
mvn clean package

# Rebuild Docker image
docker-compose build

# Rebuild và restart
docker-compose up -d --build
```

### Restart Services

```bash
# Restart tất cả
docker-compose restart

# Chỉ restart RestMan
docker-compose restart restman

# Chỉ restart MySQL
docker-compose restart mysql
```

### View Container Shell

```bash
# Vào RestMan container
docker exec -it restman-app bash

# Vào MySQL container
docker exec -it restman-mysql bash
```

## 🔧 Cấu Hình

### Thay Đổi Port

**File: docker-compose.yml**

```yaml
services:
  restman:
    ports:
      - "9090:8080"  # Change 8080 to any port you want
```

Truy cập: `http://localhost:9090/`

### Thay Đổi Database Credentials

**File: docker-compose.yml**

```yaml
services:
  mysql:
    environment:
      MYSQL_ROOT_PASSWORD: your_root_password
      MYSQL_DATABASE: restman_db
      MYSQL_USER: your_username
      MYSQL_PASSWORD: your_password

  restman:
    environment:
      JDBC_USER: "your_username"
      JDBC_PASS: "your_password"
```

### Tăng Memory Cho RestMan

**File: docker-compose.yml**

```yaml
services:
  restman:
    environment:
      JAVA_OPTS: "-Xms512m -Xmx1024m"
```

## 🐛 Troubleshooting

### Lỗi: Port 8080 already in use

**Giải pháp 1:** Stop service đang dùng port 8080
```bash
# Windows
netstat -ano | findstr :8080
taskkill /PID <PID> /F

# Linux/Mac
lsof -ti:8080 | xargs kill -9
```

**Giải pháp 2:** Đổi port trong docker-compose.yml

### Lỗi: Cannot connect to database

**Kiểm tra:**
```bash
# MySQL có chạy không?
docker-compose ps mysql

# MySQL health check OK?
docker inspect restman-mysql | grep Health

# Test connection
docker exec restman-mysql mysqladmin ping -u root -prootpassword
```

**Giải pháp:**
```bash
# Restart MySQL
docker-compose restart mysql

# Hoặc recreate từ đầu
docker-compose down
docker-compose up -d
```

### Lỗi: 404 Not Found

**Nguyên nhân:** WAR chưa được deploy

**Kiểm tra:**
```bash
# Vào container
docker exec -it restman-app bash

# Xem webapps folder
ls -la /usr/local/tomcat/webapps/

# Xem Tomcat logs
cat /usr/local/tomcat/logs/catalina.out
```

**Giải pháp:**
```bash
# Rebuild từ đầu
mvn clean package
docker-compose down
docker-compose up -d --build
```

### Lỗi: Tiếng Việt hiển thị sai (???)

**Nguyên nhân:** Character encoding

**Giải pháp:** Đã fix trong web.xml:
```xml
<request-character-encoding>UTF-8</request-character-encoding>
<response-character-encoding>UTF-8</response-character-encoding>
```

## 📋 Pre-flight Checklist

Trước khi deploy, đảm bảo:

- [ ] JDK 17 đã cài đặt: `java -version`
- [ ] Maven đã cài đặt: `mvn -version`
- [ ] Docker đã cài đặt: `docker --version`
- [ ] Docker Compose đã cài đặt: `docker-compose --version`
- [ ] Port 8080 available
- [ ] Port 3306 available (hoặc đổi port MySQL)
- [ ] Đủ disk space (ít nhất 2GB)
- [ ] Internet connection (để pull images)

## 🎯 Production Deployment

### Với External Database

**docker-compose.prod.yml:**
```yaml
version: '3.8'

services:
  restman:
    build: .
    ports:
      - "8080:8080"
    environment:
      JDBC_URL: "jdbc:mysql://your-db-host:3306/restman_db"
      JDBC_USER: "your_username"
      JDBC_PASS: "your_password"
    restart: always
```

```bash
docker-compose -f docker-compose.prod.yml up -d
```

### Với SSL/HTTPS

Cần config reverse proxy (Nginx/Apache) phía trước Tomcat.

### Backup Database

```bash
# Backup
docker exec restman-mysql mysqldump -u restman -prestman123 restman_db > backup.sql

# Restore
docker exec -i restman-mysql mysql -u restman -prestman123 restman_db < backup.sql
```

## 📚 File Structure

```
RestMan/
├── Dockerfile                 # Docker build instructions
├── docker-compose.yml         # Docker Compose configuration
├── .dockerignore             # Files to ignore in Docker build
├── pom.xml                   # Maven configuration
├── sql/
│   ├── schema.sql            # Database schema
│   └── sample_data.sql       # Sample data
└── target/
    └── restman.war           # Built WAR file
```

## 🎉 Success!

Nếu mọi thứ OK, bạn sẽ thấy:

```
✅ MySQL container: healthy
✅ RestMan container: healthy
✅ Logs không có ERROR
✅ Truy cập http://localhost:8080/ thành công
✅ Tiếng Việt hiển thị đúng
✅ Tìm món ăn hoạt động
✅ Báo cáo doanh thu hoạt động
```

**Project đã sẵn sàng sử dụng!** 🚀

---

**Lưu ý:** Lần đầu chạy có thể mất 2-3 phút để pull images và khởi động services.
