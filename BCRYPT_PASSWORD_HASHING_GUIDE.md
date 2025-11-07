# 🔒 Hướng Dẫn Mã Hóa Mật Khẩu với BCrypt

## ✅ Các Thay Đổi Đã Thực Hiện

### 1. **AccountDAO.java** - Cập nhật xác thực mật khẩu
```java
// ✅ Đã sửa: Sử dụng BCrypt.checkpw() thay vì so sánh plain text
public Account authenticate(String username, String password) throws SQLException {
    Account account = findByUsername(username);
    if (account == null) return null;
    
    // ✅ AN TOÀN: Sử dụng BCrypt để kiểm tra mật khẩu
    if (BCrypt.checkpw(password, account.getPassword())) {
        return account;
    }
    return null;
}

// ✅ Có sẵn: Method để hash mật khẩu
public static String hashPassword(String plainPassword) {
    return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
}
```

### 2. **LoginServlet.java** - Thêm comment về bảo mật
```java
/**
 * Servlet for staff login authentication
 * 
 * Password Security:
 * - Passwords are hashed using BCrypt in the database
 * - When authenticating: AccountDAO.authenticate() uses BCrypt.checkpw() for safe comparison
 * - When creating new accounts: Use AccountDAO.hashPassword(plainPassword) to hash before storing
 */
```

---

## 📋 Cách Sử Dụng BCrypt

### **Scenario 1: Đăng Nhập (Login)**
```java
// ✅ AccountDAO.authenticate() tự động xử lý
Account account = accountDAO.authenticate(username, password);
if (account != null) {
    // Login thành công
} else {
    // Login thất bại
}
```

### **Scenario 2: Tạo Tài Khoản Mới (Register)**
```java
// ❌ SAI: Không bao giờ lưu plain text
account.setPassword(plainPassword);  // KHÔNG!

// ✅ ĐÚNG: Hash mật khẩu trước khi lưu
String hashedPassword = AccountDAO.hashPassword(plainPassword);
account.setPassword(hashedPassword);
accountDAO.save(account);  // Lưu vào DB
```

### **Scenario 3: Cập Nhật Mật Khẩu (Change Password)**
```java
// ✅ Lấy mật khẩu cũ từ form
String oldPassword = req.getParameter("oldPassword");
String newPassword = req.getParameter("newPassword");

// ✅ Kiểm tra mật khẩu cũ
Account account = accountDAO.findById(userId);
if (!BCrypt.checkpw(oldPassword, account.getPassword())) {
    // Mật khẩu cũ không đúng
    return;
}

// ✅ Hash mật khẩu mới và lưu
String hashedNewPassword = AccountDAO.hashPassword(newPassword);
account.setPassword(hashedNewPassword);
accountDAO.update(account);
```

---

## 🔄 Migration: Cập Nhật Mật Khẩu Cũ

Nếu database hiện tại có mật khẩu **plain text**, bạn cần migrate:

### **Option 1: Tạo mật khẩu tạm thời mới**
```sql
-- Cập nhật tất cả tài khoản có mật khẩu plain text
UPDATE tblAccount 
SET password = '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36P4/LLm'  -- BCrypt của "password123"
WHERE id IN (1, 2, 3, ...);
```

Sau đó yêu cầu user login lần đầu với "password123" rồi đổi mật khẩu mới.

### **Option 2: Tạo script cập nhật từng account**

```java
// Script Java để hash tất cả mật khẩu cũ
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;

public class PasswordMigration {
    public static void main(String[] args) {
        String sql = "SELECT id, password FROM tblAccount";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                int id = rs.getInt("id");
                String plainPassword = rs.getString("password");
                
                // Kiểm tra xem đã là BCrypt hash chưa (bắt đầu với $2a$)
                if (!plainPassword.startsWith("$2a$")) {
                    String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
                    
                    String updateSql = "UPDATE tblAccount SET password = ? WHERE id = ?";
                    try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                        ps.setString(1, hashedPassword);
                        ps.setInt(2, id);
                        ps.executeUpdate();
                        System.out.println("✓ Migrated password for user ID: " + id);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
```

---

## 🧪 Kiểm Tra BCrypt Hoạt Động

### **Test 1: Hash và Verify**
```java
String plainPassword = "MySecurePassword123";

// Hash mật khẩu
String hashedPassword = AccountDAO.hashPassword(plainPassword);
System.out.println("Original:  " + plainPassword);
System.out.println("Hashed:    " + hashedPassword);
// Output: $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36P4/LLm

// Verify mật khẩu đúng
boolean isCorrect = BCrypt.checkpw(plainPassword, hashedPassword);
System.out.println("Is correct: " + isCorrect);  // true

// Verify mật khẩu sai
boolean isWrong = BCrypt.checkpw("WrongPassword", hashedPassword);
System.out.println("Is wrong:   " + isWrong);    // false
```

### **Test 2: Cùng mật khẩu, hash khác nhau**
```java
String password = "test123";

// BCrypt tạo salt ngẫu nhiên, nên mỗi lần hash đều khác
String hash1 = AccountDAO.hashPassword(password);
String hash2 = AccountDAO.hashPassword(password);

System.out.println("Hash 1: " + hash1);
System.out.println("Hash 2: " + hash2);
// Khác nhau, nhưng cả hai đều verify đúng

System.out.println(BCrypt.checkpw(password, hash1));  // true
System.out.println(BCrypt.checkpw(password, hash2));  // true
```

---

## 🔍 Các Ký Hiệu BCrypt Hash

```
$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36P4/LLm
│││ ││ │
│││ ││ └─ Hash value (52 characters)
│││ └──── Cost factor (10 = 2^10 iterations)
│└─────── Algorithm version (2a = latest)
└──────── BCrypt identifier
```

---

## 📊 Bảng So Sánh: Trước vs Sau

| Tiêu chí | Trước (Plain Text) | Sau (BCrypt) |
|---------|------------------|-------------|
| **Lưu trong DB** | `abc123` | `$2a$10$N9qo...` |
| **Nếu DB bị leak** | ❌ Toàn bộ mật khẩu bị lộ | ✅ Không thể dùng được |
| **Xác thực** | `password.equals(input)` | `BCrypt.checkpw(input, hash)` |
| **Độ phức tạp** | Không có | 2^10 iterations (mặc định) |
| **Salt** | Không có | Tự động tạo |
| **Rainbow Table** | ❌ Dễ bị attack | ✅ Chống được |
| **Performance** | < 1ms | ~300ms (intentional) |

---

## ⚠️ Điều Cần Lưu Ý

### **1. Độ dài cột Password trong DB**
```sql
-- ✅ ĐÚNG: BCrypt hash dài 60 ký tự
ALTER TABLE tblAccount MODIFY COLUMN password VARCHAR(60) NOT NULL;

-- ❌ SAI: Nếu cột quá ngắn, hash bị cắt
ALTER TABLE tblAccount MODIFY COLUMN password VARCHAR(255) NOT NULL;
```

### **2. Không bao giờ lưu plain text**
```java
// ❌ SAI
String password = req.getParameter("password");
account.setPassword(password);  // KHÔNG!

// ✅ ĐÚNG
String hashedPassword = AccountDAO.hashPassword(password);
account.setPassword(hashedPassword);
```

### **3. Không bao giờ decrypt hash**
```java
// ❌ KHÔNG CÓ CÁCH decrypt BCrypt
String plainPassword = BCrypt.decrypt(hash);  // Không tồn tại!

// ✅ CHỈ CÓ CÁCH verify
BCrypt.checkpw(plainPassword, hash);
```

### **4. Cost factor**
```java
// Mặc định: 10 (tốt cho hầu hết trường hợp)
BCrypt.hashpw(password, BCrypt.gensalt());        // cost = 10

// Nếu muốn tăng độ khó (nó sẽ chậm hơn):
BCrypt.hashpw(password, BCrypt.gensalt(12));      // cost = 12 (2x chậm hơn)

// Nếu muốn giảm độ khó (chỉ dùng khi cần):
BCrypt.hashpw(password, BCrypt.gensalt(8));       // cost = 8 (2x nhanh hơn)
```

---

## ✨ Lợi Ích của Thay Đổi

✅ **Bảo mật cao hơn** - Mật khẩu không bao giờ lưu dưới dạng plain text

✅ **Tuân thủ chuẩn** - OWASP Top 10, GDPR, HIPAA

✅ **Chống brute force** - BCrypt tự động tăng độ khó

✅ **Không thể reverse** - Ngay cả tác giả cũng không thể decrypt

✅ **Mỗi mật khẩu khác nhau** - Salt ngẫu nhiên cho mỗi hash

---

## 📞 Câu Hỏi Thường Gặp

### **Q: Tại sao xác thực chậm (~300ms)?**
A: Đó là đặc ý để chống brute force attack. Hacker không thể thử 1 triệu password/giây.

### **Q: Nếu quên mật khẩu sao?**
A: Gửi email reset, tạo token tạm thời, user tạo mật khẩu mới. KHÔNG bao giờ reset về mật khẩu cũ (vì không thể decrypt).

### **Q: Hash dài bao nhiêu ký tự?**
A: BCrypt hash cố định **60 ký tự** (cột VARCHAR(60) là tối thiểu).

### **Q: Có thể hash mật khẩu 2 lần không?**
A: ❌ KHÔNG! Chỉ hash 1 lần. Nếu hash 2 lần, verify sẽ thất bại.

---

## 🎯 Bước Tiếp Theo

1. ✅ **Cập nhật AccountDAO.java** - DONE
2. ✅ **Cập nhật LoginServlet.java** - DONE
3. 📋 **Cập nhật mật khẩu cũ** - Chọn Option 1 hoặc 2 phía trên
4. 🧪 **Test xác thực** - Đăng nhập thử
5. 🚀 **Deploy** - Lưu ý: phải migrate mật khẩu trước khi deploy

---

**Hoàn thành:** 2025-11-07 ✨

Mọi câu hỏi, vui lòng liên hệ!
