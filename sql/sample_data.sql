-- Sample Data for RestMan Database

-- Insert sample accounts
INSERT INTO tblAccount (fullName, username, password, email, phone, address, gender, dateOfBirth, role) VALUES
('Hoàng Văn Em', 'hoangvanem', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu', 'hoangvanem@email.com', '0852963741', '654 Đường JKL, Quận 2, TP.HCM', 'MALE', '1992-05-15', 'CUSTOMER'),
('Nguyễn Văn An', 'nguyenvanan', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu', 'nguyenvanan@email.com', '0123456789', '123 Đường ABC, Quận 1, TP.HCM', 'MALE', '1990-01-15', 'CUSTOMER'),
('Trần Thị Bình', 'tranthibinh', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu', 'tranthibinh@email.com', '0987654321', '456 Đường DEF, Quận 3, TP.HCM', 'FEMALE', '1995-03-20', 'CUSTOMER'),
('Lê Văn Cường', 'levancuong', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu', 'levancuong@email.com', '0369852147', '789 Đường GHI, Quận 5, TP.HCM', 'MALE', '1988-07-10', 'CUSTOMER'),
('Phạm Thị Dung', 'phamthidung', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu', 'phamthidung@email.com', '0741852963', '321 Đường MNO, Quận 7, TP.HCM', 'FEMALE', '1993-11-25', 'CUSTOMER'),
('Mai Hoàng Tùng', 'maihoang', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu', 'maihoang@email.com', '0912345678', '111 Đường PQR, Quận 10, TP.HCM', 'MALE', '1985-06-01', 'STAFF');

-- Insert customers (including walk-in customers without accounts)
INSERT INTO tblCustomer (accountId, fullName, phone, email, address, dateOfBirth, gender) VALUES
(1, 'Hoàng Văn Em', '0852963741', 'hoangvanem@email.com', '654 Đường JKL, Quận 2, TP.HCM', '1992-05-15', 'MALE'),
(2, 'Nguyễn Văn An', '0123456789', 'nguyenvanan@email.com', '123 Đường ABC, Quận 1, TP.HCM', '1990-01-15', 'MALE'),
(3, 'Trần Thị Bình', '0987654321', 'tranthibinh@email.com', '456 Đường DEF, Quận 3, TP.HCM', '1995-03-20', 'FEMALE'),
(4, 'Lê Văn Cường', '0369852147', 'levancuong@email.com', '789 Đường GHI, Quận 5, TP.HCM', '1988-07-10', 'MALE'),
(5, 'Phạm Thị Dung', '0741852963', 'phamthidung@email.com', '321 Đường MNO, Quận 7, TP.HCM', '1993-11-25', 'FEMALE');

-- Insert staff
INSERT INTO tblStaff (accountId, employeeCode, department, position, hireDate, salary, status) VALUES
(6, 'EMP001', 'Sales', 'Sale Staff', '2020-01-15', 15000000, 'ACTIVE');

INSERT INTO tblSaleStaff (staffId, commissionRate) VALUES (1, 5.00);

-- Insert membership cards
INSERT INTO tblMembershipCard (cardNumber, tier, points, customerId, issuedByStaffId, status) VALUES
('MC001', 'VIP', 1500, 1, 1, 'ACTIVE'),
('MC002', 'GOLD', 800, 2, 1, 'ACTIVE'),
('MC003', 'SILVER', 300, 3, 1, 'ACTIVE');

-- Insert dishes
INSERT INTO tblDish (name, category, description, price, imageUrl, status) VALUES
('Phở Bò Tái', 'Món chính', 'Phở bò tái truyền thống với nước dưỡng thơm ngon, thịt bò tái mềm', 65000, '/images/pho-bo-tai.jpg', 'ACTIVE'),
('Bún Chả Hà Nội', 'Món chính', 'Bún chả Hà Nội đặc trưng với thịt nướng thơm lừng', 55000, '/images/bun-cha.jpg', 'ACTIVE'),
('Cơm Tấm Sườn Nướng', 'Món chính', 'Cơm tấm sườn nướng với chả trứng và bì hành', 45000, '/images/com-tam.jpg', 'ACTIVE'),
('Bánh Mì Thịt Nướng', 'Món nhanh', 'Bánh mì giòn với thịt nướng và rau củ tươi', 25000, '/images/banh-mi.jpg', 'ACTIVE'),
('Gỏi Cuốn Tôm Thịt', 'Khai vị', 'Gỏi cuốn tươi mát với tôm và thịt ba chỉ', 35000, '/images/goi-cuon.jpg', 'ACTIVE'),
('Chả Cá Lã Vọng', 'Món chính', 'Chả cá Lã Vọng truyền thống với thì là và hành', 85000, '/images/cha-ca.jpg', 'ACTIVE');

-- Insert menus
INSERT INTO tblMenu (name, type, effectiveFrom, effectiveTo, status, description) VALUES
('Menu Trưa', 'LUNCH', '2025-01-01', '2025-12-31', 'ACTIVE', 'Menu các món ăn cho bữa trưa'),
('Menu Tối', 'DINNER', '2025-01-01', '2025-12-31', 'ACTIVE', 'Menu các món ăn cho bữa tối'),
('Menu Đặc Biệt', 'SPECIAL', '2025-01-01', '2025-03-31', 'ACTIVE', 'Menu đặc biệt dịp Tết');

-- Insert menu items
INSERT INTO tblMenuItem (displayOrder, menuId, dishId, effectiveFrom, effectiveTo) VALUES
(1, 1, 1, '2025-01-01', '2025-12-31'),
(2, 1, 2, '2025-01-01', '2025-12-31'),
(3, 1, 3, '2025-01-01', '2025-12-31'),
(4, 1, 4, '2025-01-01', '2025-12-31'),
(5, 1, 5, '2025-01-01', '2025-12-31'),
(1, 2, 1, '2025-01-01', '2025-12-31'),
(2, 2, 3, '2025-01-01', '2025-12-31'),
(3, 2, 6, '2025-01-01', '2025-12-31');

-- Insert tables
INSERT INTO tblTable (tableNumber, capacity, location, status) VALUES
('T01', 4, 'Tầng 1 - Khu A', 'AVAILABLE'),
('T02', 2, 'Tầng 1 - Khu A', 'AVAILABLE'),
('T03', 6, 'Tầng 1 - Khu B', 'AVAILABLE'),
('T04', 4, 'Tầng 2 - Khu A', 'AVAILABLE'),
('T05', 8, 'Tầng 2 - Khu VIP', 'AVAILABLE');

-- Insert orders
INSERT INTO tblOrder (orderNumber, channel, status, customerId, saleStaffId, tableId, createdAt) VALUES
('ORD2025001', 'IN_STORE', 'COMPLETED', 1, 1, 1, '2025-10-05 11:30:00'),
('ORD2025002', 'ONLINE', 'COMPLETED', 2, 1, NULL, '2025-06-10 18:45:00'),
('ORD2025003', 'IN_STORE', 'COMPLETED', 3, 1, 3, '2025-07-20 12:15:00');

-- Insert order items
INSERT INTO tblOrderItem (quantity, unitPrice, discount, orderId, dishId) VALUES
(2, 65000, 0, 1, 1),
(1, 85000, 0, 1, 6),
(1, 35000, 0, 1, 5),
(2, 55000, 0, 2, 2),
(1, 25000, 0, 3, 4),
(1, 45000, 0, 3, 3),
(2, 35000, 0, 3, 5);

-- Insert invoices
INSERT INTO tblInvoice (invoiceNumber, issueDate, paymentMethod, status, total, paidAmount, orderId, cashierStaffId) VALUES
('INV2025001', '2025-10-05 12:00:00', 'CASH', 'PAID', 385000, 385000, 1, 1),
('INV2025002', '2025-06-10 19:00:00', 'E_WALLET', 'PAID', 295000, 295000, 2, 1),
('INV2025003', '2025-07-20 12:45:00', 'CREDIT_CARD', 'PAID', 425000, 425000, 3, 1);
