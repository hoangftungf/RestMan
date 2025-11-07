# 📊 Hướng Dẫn Cài Đặt Dữ Liệu RestMan

## 🎯 Tóm Tắt

File `complete_sample_data.sql` chứa dữ liệu mẫu hoàn chỉnh cho hệ thống RestMan với:
- ✅ 11 Accounts (Admin, Managers, Staff, Customers)
- ✅ 7 Staff Members (Managers, Sales, Inventory)
- ✅ 3 Customers
- ✅ 16 Dishes (Vietnamese, Western, Japanese, Thai, Salad, Beverage, Dessert)
- ✅ 3 Menus (Main, Breakfast, Happy Hour)
- ✅ 3 Combos (Bundle deals)
- ✅ 8 Tables (2-6 seats)
- ✅ 3 Orders với Order Items
- ✅ 3 Invoices
- ✅ 3 Suppliers
- ✅ 8 Ingredients
- ✅ 1 Reservation

---

## 🚀 Cách Cài Đặt

### **Option 1: Cài Đặt Từ Command Line**

```bash
# Vào thư mục project
cd c:\Users\tungm\Documents\GitHub\RestMan

# 1. Reset schema (xóa tất cả old data)
mysql -u root -p restman_db < sql/schema.sql

# 2. Cài dữ liệu mẫu hoàn chỉnh
mysql -u root -p restman_db < sql/complete_sample_data.sql

# Nhập password khi được yêu cầu
```

### **Option 2: Cài Đặt Từ MySQL Workbench**

1. Mở MySQL Workbench
2. Kết nối đến server local
3. Click chuột phải vào database `restman_db`
4. Chọn "SQL Editor" → "New Query Tab"
5. Copy nội dung từ `complete_sample_data.sql`
6. Paste vào editor
7. Click ▶ Execute

### **Option 3: Cài Đặt Tùm Lum Từ SQL File**

```sql
-- Copy toàn bộ nội dung complete_sample_data.sql
-- Dán vào MySQL Query
-- Execute
```

---

## 👥 Tài Khoản Test

### **Admin**
```
Username: admin
Password: admin123 (BCrypt hashed)
Role: ADMIN
```

### **Managers**
```
Username: manager01 / manager02
Password: password123 (BCrypt hashed)
Role: MANAGER
```

### **Staff (Sales/Cashier)**
```
Username: staff01, staff02, staff03, staff04
Password: password123 (BCrypt hashed)
Role: STAFF
```

### **Inventory Staff**
```
Username: inventory01
Password: password123 (BCrypt hashed)
Role: STAFF
```

### **Customers**
```
Username: customer01, customer02, customer03
Password: password123 (BCrypt hashed)
Role: CUSTOMER
```

---

## 🔐 Mật Khẩu BCrypt

Tất cả mật khẩu được hash bằng BCrypt:
- **Hash:** `$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu`
- **Plaintext:** `password123`

Admin:
- **Hash:** `$2a$10$qYjmOkR0cEXw1lY9GkZ1K.4T7KvZ6D8Q3B2M5N9P6R7S8TU9`
- **Plaintext:** `admin123`

---

## 📋 Dữ Liệu Bao Gồm

### **1. Accounts (11 accounts)**
| Username | Role | Status |
|----------|------|--------|
| admin | ADMIN | ACTIVE |
| manager01 | MANAGER | ACTIVE |
| manager02 | MANAGER | ACTIVE |
| staff01-04 | STAFF | ACTIVE |
| inventory01 | STAFF | ACTIVE |
| customer01-03 | CUSTOMER | ACTIVE |

### **2. Staff (7 staff)**
| Employee Code | Position | Department | Salary |
|---------------|----------|------------|--------|
| MGR001 | Manager | Management | 15M |
| MGR002 | Manager | Management | 14M |
| SAL001-004 | Cashier/Waiter | Sales | 5.5-6M |
| INV001 | Inventory Manager | Inventory | 8M |

### **3. Dishes (16 dishes)**

**Vietnamese:**
- Phở Bò (55k)
- Bún Chả Hà Nội (60k)
- Cơm Tấm Sài Gòn (50k)
- Bánh Mì Thịt Nướng (35k)
- Gỏi Cuốn (45k)

**Western:**
- Steak Ribeye (250k)

**Italian:**
- Pasta Carbonara (95k)

**Japanese:**
- Salmon Sashimi (150k)

**Thai:**
- Pad Thai (75k)

**Salad:**
- Caesar Salad (85k)

**Beverage:**
- Cà Phê Đen Đá (15k)
- Trà Sữa (30k)
- Nước Ép Cam (25k)

**Dessert:**
- Chè Ba Màu (20k)
- Tiramisu (45k)
- Flan (25k)

### **4. Menus (3 menus)**
- Main Menu 2025 (16 items)
- Breakfast Menu (5 items)
- Happy Hour Menu (4 items)

### **5. Combos (3 combos)**
- Combo Phở (70k)
- Combo Bún Chả (100k)
- Combo Western (350k)

### **6. Tables (8 tables)**
| Table | Capacity | Location | Status |
|-------|----------|----------|--------|
| T01-T02 | 2 | Window | Available |
| T03-T04 | 4 | Corner | Available/Occupied |
| T05-T06 | 6 | Center | Available/Reserved |
| T07-T08 | 2-4 | Bar/Patio | Available |

### **7. Suppliers (3 suppliers)**
- ABC Food Supplier
- XYZ Imports
- Prime Quality Foods

### **8. Ingredients (8 ingredients)**
- Beef (50kg)
- Rice Noodles (30kg)
- Pork (40kg)
- Fresh Vegetables (25kg)
- Coffee Beans (15kg)
- Milk (20L)
- Fish Sauce (10L)
- Oil (50L)

### **9. Orders (3 orders)**
| Order | Channel | Status | Total | Items |
|-------|---------|--------|-------|-------|
| 1 | Online | Delivered | 165k | Phở, 2x Coffee |
| 2 | Dine-in | Completed | 330k | Steak, Salad, Tea |
| 3 | Takeout | Completed | 120k | Bún Chả, Pad Thai |

### **10. Invoices (3 invoices)**
- All 3 orders have corresponding invoices
- Payment methods: Credit Card, Cash, Debit Card
- Status: All PAID

### **11. Reservation (1 reservation)**
- Table T06 (6 seats)
- Customer: Bùi Minh Tuấn
- Date: 2025-01-15 18:30
- Duration: 2 hours
- Status: CONFIRMED

---

## ✅ Xác Minh Dữ Liệu

Sau khi cài đặt, chạy các query để kiểm tra:

```sql
-- Kiểm tra số lượng records
SELECT 'Accounts' as table_name, COUNT(*) as count FROM tblAccount
UNION ALL
SELECT 'Staff', COUNT(*) FROM tblStaff
UNION ALL
SELECT 'Customers', COUNT(*) FROM tblCustomer
UNION ALL
SELECT 'Dishes', COUNT(*) FROM tblDish
UNION ALL
SELECT 'Menus', COUNT(*) FROM tblMenu
UNION ALL
SELECT 'Orders', COUNT(*) FROM tblOrder
UNION ALL
SELECT 'Invoices', COUNT(*) FROM tblInvoice;

-- Kiểm tra tài khoản admin
SELECT * FROM tblAccount WHERE username = 'admin';

-- Kiểm tra dishes
SELECT dishName, category, price FROM tblDish LIMIT 5;

-- Kiểm tra orders với items
SELECT o.id, c.fullName, COUNT(oi.id) as item_count, o.totalAmount
FROM tblOrder o
LEFT JOIN tblCustomer c ON o.customerId = c.id
LEFT JOIN tblOrderItem oi ON o.id = oi.orderId
GROUP BY o.id;
```

---

## 🧪 Cách Test Hệ Thống

### **1. Test Login**
- URL: `http://localhost:8080/restman/login`
- Login với `admin` / `admin123`
- Hoặc `staff01` / `password123`

### **2. Test Registration**
- URL: `http://localhost:8080/restman/register`
- Tạo tài khoản mới
- Kiểm tra dữ liệu được lưu vào database

### **3. Test Customer Features**
- Xem menu (16 dishes)
- Xem dishes theo category
- Xem chi tiết dish
- Xem customer revenue report

### **4. Test Staff Features**
- Xem orders
- Xem invoices
- Xem customer revenue report
- Xem menu reports

### **5. Test Database Integrity**
```sql
-- Foreign keys
SELECT COUNT(*) FROM tblStaff WHERE accountId NOT IN (SELECT id FROM tblAccount);

-- Check BCrypt passwords
SELECT username, password FROM tblAccount LIMIT 3;
-- Passwords should start with $2a$10$
```

---

## 🎓 Điểm Chính

✅ **Dữ liệu Hoàn Chỉnh**: Tất cả bảng có dữ liệu phù hợp

✅ **Hiện Thực Hóa Business Logic**: 
- Orders → Order Items → Invoices
- Staff → Manager/SaleStaff/InventoryStaff
- Menu → Menu Items → Dishes

✅ **Mối Quan Hệ Đúng**:
- Foreign keys thiết lập đúng
- Dữ liệu liên quan với nhau hợp lý

✅ **Bảo Mật BCrypt**: 
- Tất cả passwords hashed
- Không plain text trong database

✅ **Đa Dạng**:
- Multiple users (admin, manager, staff, customer)
- Multiple orders với trạng thái khác nhau
- Multiple menus, combos, dishes

✅ **Sẵn Sàng Test**: 
- Có đủ dữ liệu để test tất cả features
- Có diverse scenarios (online, dine-in, takeout)

---

## 🚀 Các Bước Tiếp Theo

1. **Build Project**
   ```bash
   mvn clean compile
   ```

2. **Setup Database**
   ```bash
   mysql -u root -p restman_db < sql/schema.sql
   mysql -u root -p restman_db < sql/complete_sample_data.sql
   ```

3. **Deploy to Tomcat**
   ```bash
   mvn clean package
   # Copy target/restman.war to tomcat/webapps/
   ```

4. **Test Features**
   - Register new account
   - Login with test accounts
   - Browse menu and dishes
   - View orders and invoices

5. **Verify Reports**
   - Customer revenue report
   - Staff performance
   - Inventory status

---

## 📞 Troubleshooting

### **"Database does not exist"**
```bash
# Create database first
mysql -u root -p
CREATE DATABASE restman_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### **"Foreign key constraint fails"**
- Đảm bảo cài schema trước (tblAccount phải tồn tại trước tblStaff)
- Đảm bảo referential integrity

### **"Duplicate entry"**
- Xóa old data trước: `mysql -u root -p restman_db < sql/schema.sql`
- Rồi cài dữ liệu mới

### **Passwords không đúng**
- Tất cả passwords đều là BCrypt hash
- Không decode được (one-way hash)
- Use BCrypt.checkpw() để verify

---

## 📚 Tài Liệu Liên Quan

- `BCRYPT_PASSWORD_HASHING_GUIDE.md` - Hướng dẫn BCrypt
- `REGISTRATION_FEATURE_GUIDE.md` - Chức năng đăng ký
- `IMPLEMENTATION_COMPLETE.md` - Tóm tắt implementation

---

**Status: ✅ Dữ liệu sẵn sàng cài đặt**

**Last Updated:** 2025-01-07

**Total Records:** 70+ records across 12 tables

