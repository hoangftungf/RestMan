# 📝 Hướng Dẫn Chức Năng Đăng Ký (Register)

## ✅ Các File Đã Tạo/Sửa

### **1. RegisterServlet.java** ✏️
```
📁 src/main/java/servlet/RegisterServlet.java
```

**Chức năng:**
- ✅ Hiển thị form đăng ký (GET)
- ✅ Xử lý đăng ký tài khoản mới (POST)
- ✅ Hash mật khẩu với BCrypt
- ✅ Validate input (username, email, password, v.v.)
- ✅ Kiểm tra username đã tồn tại chưa
- ✅ Lưu account mới vào database

**URL:** `/register`

---

### **2. gdDangKy.jsp** ✏️
```
📁 src/main/webapp/WEB-INF/jsp/auth/gdDangKy.jsp
```

**Form đăng ký:**
- ✅ Họ và tên (bắt buộc)
- ✅ Tên đăng nhập (bắt buộc, 3-20 ký tự)
- ✅ Email (bắt buộc)
- ✅ Mật khẩu (bắt buộc, ≥6 ký tự)
- ✅ Xác nhận mật khẩu (bắt buộc)
- ✅ Số điện thoại (tùy chọn)
- ✅ Địa chỉ (tùy chọn)
- ✅ Giới tính (tùy chọn)
- ✅ Ngày sinh (tùy chọn)

---

### **3. AccountDAO.java** ✏️
```
📁 src/main/java/dao/AccountDAO.java
```

**Thêm method:**
```java
// Tạo account mới
public boolean create(Account account) throws SQLException {
    // Hash mật khẩu tự động
    // Lưu vào database
    // Trả về true/false
}
```

---

### **4. test_accounts.sql** ✏️
```
📁 sql/test_accounts.sql
```

**Thay đổi:**
- ✅ Xóa plain text password
- ✅ Thêm BCrypt hash cho tất cả test accounts
- ✅ Thêm comment giải thích

**Test credentials (BCrypt hashed):**
- `staff01` / `password123`
- `manager01` / `password123`
- `admin` / `admin123`
- `customer01` / `password123`

---

## 🔄 Luồng Đăng Ký

```
1. User truy cập /register
   ↓
2. RegisterServlet.doGet()
   ↓
3. Hiển thị form: gdDangKy.jsp
   ↓
4. User điền form và submit
   ↓
5. RegisterServlet.doPost()
   ├─ Validate input
   ├─ Kiểm tra username tồn tại
   ├─ Hash mật khẩu: AccountDAO.hashPassword()
   ├─ Tạo Account object
   ├─ Lưu vào DB: accountDAO.create()
   └─ Redirect → Login page (nếu thành công)
   ↓
6. User login với tài khoản mới
```

---

## 🛡️ Validate Rules

### **Username:**
- ✅ Bắt buộc
- ✅ Tối thiểu 3 ký tự
- ✅ Chỉ chứa: a-z, A-Z, 0-9, _ (underscore)
- ✅ Không được duplicate

### **Password:**
- ✅ Bắt buộc
- ✅ Tối thiểu 6 ký tự
- ✅ Phải giống Confirm Password
- ✅ **Sẽ được hash BCrypt trước khi lưu**

### **Email:**
- ✅ Bắt buộc
- ✅ Format email hợp lệ
- ✅ Không kiểm tra duplicate (tùy chọn)

### **Full Name:**
- ✅ Bắt buộc
- ✅ Không để trống

---

## 💾 Database Changes

### **Before (Plain Text):**
```sql
INSERT INTO tblAccount (..., password, ...)
VALUES (..., 'password123', ...);  -- ❌ Plain text
```

### **After (BCrypt):**
```sql
INSERT INTO tblAccount (..., password, ...)
VALUES (..., '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu', ...);  -- ✅ Hashed
```

---

## 🧪 Cách Test

### **Test 1: Đăng ký thành công**
1. Truy cập: `http://localhost:8080/restman/register`
2. Điền form:
   - Họ tên: "Nguyễn Thị Test"
   - Username: "nguyentest"
   - Email: "nguyentest@email.com"
   - Password: "Password123"
   - Confirm: "Password123"
3. Click "Đăng Ký"
4. **Kết quả mong đợi:** Redirect → Login page, có message "Đăng ký thành công"

### **Test 2: Username đã tồn tại**
1. Điền form với username: "staff01" (đã tồn tại)
2. Click "Đăng Ký"
3. **Kết quả mong đợi:** Error message "Tên đăng nhập đã tồn tại"

### **Test 3: Mật khẩu không khớp**
1. Điền Password: "password123"
2. Điền Confirm: "password456"
3. Click "Đăng Ký"
4. **Kết quả mong đợi:** Error message "Mật khẩu xác nhận không khớp"

### **Test 4: Mật khẩu quá ngắn**
1. Điền Password: "123"
2. Click "Đăng Ký"
3. **Kết quả mong đợi:** Error message "Mật khẩu phải có ít nhất 6 ký tự"

### **Test 5: Email không hợp lệ**
1. Điền Email: "not-an-email"
2. Click "Đăng Ký"
3. **Kết quả mong đợi:** Error message "Địa chỉ email không hợp lệ"

### **Test 6: Login với tài khoản mới**
1. Đăng ký thành công
2. Redirect → Login page
3. Điền username + password mới
4. Click "Đăng Nhập"
5. **Kết quả mong đợi:** Login thành công (BCrypt verify password)

---

## 🔐 Bảo Mật

✅ **Mật khẩu được hash BCrypt:**
- ✓ Không lưu plain text
- ✓ Không thể reverse
- ✓ Mỗi hash khác nhau (salt ngẫu nhiên)

✅ **Input validation:**
- ✓ Kiểm tra độ dài
- ✓ Kiểm tra format
- ✓ Kiểm tra duplicate username

✅ **Error handling:**
- ✓ Không expose chi tiết lỗi database
- ✓ User-friendly error messages

---

## 📋 SQL để xóa dữ liệu (nếu cần reset)

```sql
-- Xóa tất cả tài khoản
DELETE FROM tblAccount;

-- Xóa tất cả tài khoản ngoài test accounts
DELETE FROM tblAccount WHERE username NOT IN ('staff01', 'manager01', 'admin', 'customer01');

-- Reset AUTO_INCREMENT
ALTER TABLE tblAccount AUTO_INCREMENT = 1;
```

---

## 🎯 Workflow

```
┌─────────────────────────────────────┐
│   User Access /register             │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│   Show Registration Form (GET)      │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│   User Fills Form & Submits         │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│   Validate Input                    │
├─────────────────────────────────────┤
│   ✅ All fields filled?             │
│   ✅ Password length ≥ 6?           │
│   ✅ Password matches?              │
│   ✅ Email format?                  │
│   ✅ Username format?               │
└──────────────────┬──────────────────┘
                   │
        ┌──────────┴──────────┐
        │                     │
       ❌                     ✅
        │                     │
        ▼                     ▼
    Show Error         Check Username
    Message           Exists in DB
                            │
                 ┌──────────┴──────────┐
                 │                     │
                ✅                    ❌
                 │                     │
                 ▼                     ▼
            Hash Password          Show Error
            Create Account
            Save to DB
                 │
                 ▼
          ┌──────────────────┐
          │  Login Success   │
          │ Redirect → Login │
          └──────────────────┘
```

---

## ✨ Lợi ích của chức năng này

✅ **Bảo mật:** Mật khẩu hash BCrypt từ khi tạo

✅ **User-friendly:** Form rõ ràng, error messages dễ hiểu

✅ **Validate toàn diện:** Kiểm tra input phía server

✅ **Sạch sẽ:** Xóa hết mật khẩu plain text

✅ **Ready for production:** Có thể deploy ngay

---

**Hoàn thành:** 2025-11-07 ✨

Mọi câu hỏi, vui lòng liên hệ!
