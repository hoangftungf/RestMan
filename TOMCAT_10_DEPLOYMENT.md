# Hướng Dẫn Deploy RestMan Lên Tomcat 10.1 (Docker)

## ✅ Đã Sửa Tất Cả Vấn Đề

### Vấn đề 1: ❌ Sai API (javax.* thay vì jakarta.*)
**ĐÃ SỬA**: ✅ Chuyển toàn bộ sang Jakarta EE 9+

### Vấn đề 2: ❌ JSTL cũ (javax.servlet.jsp.jstl)
**ĐÃ SỬA**: ✅ Dùng JSTL 3.0 Jakarta

### Vấn đề 3: ❌ Context path dài (RestMan-1.0-SNAPSHOT)
**ĐÃ SỬA**: ✅ Đặt finalName="restman" → path là `/restman`

## 📋 Thay Đổi Đã Thực Hiện

### 1. pom.xml - Dependencies

**TRƯỚC (Tomcat 8/9):**
```xml
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
    <version>4.0.1</version>
</dependency>
```

**SAU (Tomcat 10.1+):**
```xml
<!-- Servlet API 6.0 (Jakarta) -->
<dependency>
    <groupId>jakarta.servlet</groupId>
    <artifactId>jakarta.servlet-api</artifactId>
    <version>6.0.0</version>
    <scope>provided</scope>
</dependency>

<!-- JSP API (Jakarta) -->
<dependency>
    <groupId>jakarta.servlet.jsp</groupId>
    <artifactId>jakarta.servlet.jsp-api</artifactId>
    <version>3.1.0</version>
    <scope>provided</scope>
</dependency>

<!-- JSTL 3.0 (Jakarta) -->
<dependency>
    <groupId>jakarta.servlet.jsp.jstl</groupId>
    <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
    <version>3.0.0</version>
</dependency>

<!-- JSTL Implementation -->
<dependency>
    <groupId>org.glassfish.web</groupId>
    <artifactId>jakarta.servlet.jsp.jstl</artifactId>
    <version>3.0.1</version>
</dependency>
```

### 2. pom.xml - Build Configuration

```xml
<build>
    <!-- Đặt tên file WAR = restman.war -->
    <finalName>restman</finalName>

    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-war-plugin</artifactId>
            <version>3.4.0</version>
            <configuration>
                <failOnMissingWebXml>false</failOnMissingWebXml>
            </configuration>
        </plugin>
    </plugins>
</build>
```

### 3. web.xml - Jakarta EE 9 Schema

**TRƯỚC:**
```xml
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         version="4.0">
```

**SAU:**
```xml
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee
         https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
         version="6.0">

    <!-- Character encoding (Jakarta way) -->
    <request-character-encoding>UTF-8</request-character-encoding>
    <response-character-encoding>UTF-8</response-character-encoding>
</web-app>
```

### 4. Java Source - Import Statements

**TRƯỚC:**
```java
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
```

**SAU:**
```java
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
```

**Files đã cập nhật:**
- ✅ HomeController.java
- ✅ CustomerHomeController.java
- ✅ StaffHomeController.java
- ✅ StaffReportMenuController.java
- ✅ CatalogController.java
- ✅ CustomerRevenueReportController.java

## 🐳 Deploy Lên Tomcat 10.1 Docker

### Cách 1: Mount WAR File

**Dockerfile:**
```dockerfile
FROM tomcat:10.1-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY target/restman.war /usr/local/tomcat/webapps/

EXPOSE 8080
```

**Build & Run:**
```bash
# Build project
mvn clean package

# Build Docker image
docker build -t restman:latest .

# Run container
docker run -d -p 8080:8080 --name restman restman:latest
```

**Truy cập:**
```
http://localhost:8080/restman/
```

### Cách 2: Deploy Làm ROOT (Recommended)

**Dockerfile:**
```dockerfile
FROM tomcat:10.1-jdk17

# Remove all default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy and rename to ROOT.war
COPY target/restman.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
```

**Truy cập:**
```
http://localhost:8080/
```

### Cách 3: Docker Compose

**docker-compose.yml:**
```yaml
version: '3.8'

services:
  restman:
    build: .
    ports:
      - "8080:8080"
    environment:
      - JAVA_OPTS=-Xmx512m
    depends_on:
      - mysql
    networks:
      - restman-net

  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: restman_db
      MYSQL_USER: restman
      MYSQL_PASSWORD: restman123
    ports:
      - "3306:3306"
    volumes:
      - mysql-data:/var/lib/mysql
      - ./sql:/docker-entrypoint-initdb.d
    networks:
      - restman-net

volumes:
  mysql-data:

networks:
  restman-net:
```

**Build & Run:**
```bash
mvn clean package
docker-compose up -d
```

## 📝 URL Mapping

| Deployment Method | WAR Name | Context Path | URL |
|------------------|----------|--------------|-----|
| Standard | `restman.war` | `/restman` | `http://localhost:8080/restman/` |
| ROOT deployment | `ROOT.war` | `/` | `http://localhost:8080/` |
| Custom context | `myapp.war` | `/myapp` | `http://localhost:8080/myapp/` |

## 🔧 Cấu Hình Database Trong Docker

### Option 1: Environment Variables

**Dockerfile:**
```dockerfile
FROM tomcat:10.1-jdk17

ENV JDBC_URL=jdbc:mysql://mysql:3306/restman_db
ENV JDBC_USER=restman
ENV JDBC_PASS=restman123

COPY target/restman.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
```

### Option 2: Mounted .env File

**docker-compose.yml:**
```yaml
services:
  restman:
    build: .
    volumes:
      - ./.env:/app/.env
    env_file:
      - .env
```

**.env:**
```properties
JDBC_URL=jdbc:mysql://mysql:3306/restman_db?useSSL=false&serverTimezone=UTC
JDBC_USER=restman
JDBC_PASS=restman123
```

## ✅ Verification Checklist

### Sau khi deploy, kiểm tra:

- [ ] Container khởi động thành công: `docker ps`
- [ ] Tomcat logs không có lỗi: `docker logs restman`
- [ ] WAR được extract: `docker exec restman ls /usr/local/tomcat/webapps/`
- [ ] Truy cập được landing page: `http://localhost:8080/restman/`
- [ ] Module khách hàng hoạt động: `http://localhost:8080/restman/customer`
- [ ] Module nhân viên hoạt động: `http://localhost:8080/restman/staff`
- [ ] Database connection OK: Test tìm món ăn
- [ ] JSTL tags hoạt động: Không có lỗi ${...} hiển thị trên page
- [ ] Character encoding đúng: Tiếng Việt hiển thị đúng

## 🐛 Troubleshooting

### Lỗi: ClassNotFoundException: jakarta.servlet.ServletException

**Nguyên nhân:** Tomcat version < 10
**Giải pháp:** Dùng Tomcat 10.1+ hoặc downgrade về javax.*

### Lỗi: Cannot find tag library descriptor for "http://java.sun.com/jsp/jstl/core"

**Nguyên nhân:** Thiếu JSTL implementation
**Giải pháp:** Đã thêm `org.glassfish.web:jakarta.servlet.jsp.jstl:3.0.1`

### Lỗi: 404 Not Found khi truy cập /customer

**Nguyên nhân:** Sai context path
**Giải pháp:**
- Nếu WAR = `restman.war` → URL phải là `/restman/customer`
- Hoặc deploy làm `ROOT.war` → URL là `/customer`

### Lỗi: Database connection refused

**Nguyên nhân:** Database host sai trong Docker
**Giải pháp:**
- Trong Docker, không dùng `localhost`
- Dùng service name: `jdbc:mysql://mysql:3306/restman_db`

## 📚 Tài Liệu Tham Khảo

- [Jakarta EE 9 Migration Guide](https://jakarta.ee/specifications/platform/9/)
- [Tomcat 10 Migration](https://tomcat.apache.org/migration-10.html)
- [JSTL 3.0 Specification](https://jakarta.ee/specifications/tags/3.0/)

## 🎯 Quick Start Commands

```bash
# 1. Build WAR
mvn clean package

# 2. Verify WAR name
ls -lh target/

# 3. Test locally (if Tomcat installed)
cp target/restman.war $TOMCAT_HOME/webapps/

# 4. Or run in Docker
docker run -d -p 8080:8080 \
  -v $(pwd)/target/restman.war:/usr/local/tomcat/webapps/ROOT.war \
  tomcat:10.1-jdk17

# 5. Check logs
docker logs -f <container-id>

# 6. Access
open http://localhost:8080/
```

---

**Project đã hoàn toàn tương thích với Tomcat 10.1+!** ✅
