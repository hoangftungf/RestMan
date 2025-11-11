-- ================================================================
-- RestMan - November Orders (01/11 - 11/11)
-- Customers 11 → 20
-- ================================================================

-- Orders
INSERT INTO tblOrder (orderNumber, channel, status, customerId, saleStaffId, tableId, createdAt) VALUES
('ORD20251101', 'IN_STORE', 'COMPLETED', 11, 1, (SELECT id FROM tblTable WHERE tableNumber = 'T02'), '2025-11-01 11:05:00'),
('ORD20251102', 'ONLINE', 'COMPLETED', 12, 1, NULL, '2025-11-02 18:20:00'),
('ORD20251103', 'IN_STORE', 'COMPLETED', 13, 1, (SELECT id FROM tblTable WHERE tableNumber = 'T03'), '2025-11-03 12:10:00'),
('ORD20251104', 'IN_STORE', 'COMPLETED', 14, 1, (SELECT id FROM tblTable WHERE tableNumber = 'T02'), '2025-11-04 19:00:00'),
('ORD20251105', 'ONLINE', 'COMPLETED', 15, 1, NULL, '2025-11-05 17:35:00'),
('ORD20251106', 'IN_STORE', 'COMPLETED', 16, 1, (SELECT id FROM tblTable WHERE tableNumber = 'T01'), '2025-11-06 08:15:00'),
('ORD20251107', 'IN_STORE', 'COMPLETED', 17, 1, (SELECT id FROM tblTable WHERE tableNumber = 'T04'), '2025-11-07 20:05:00'),
('ORD20251108', 'ONLINE', 'COMPLETED', 18, 1, NULL, '2025-11-08 13:40:00'),
('ORD20251109', 'IN_STORE', 'COMPLETED', 19, 1, (SELECT id FROM tblTable WHERE tableNumber = 'T05'), '2025-11-09 19:45:00'),
('ORD20251110', 'ONLINE', 'COMPLETED', 20, 1, NULL, '2025-11-10 10:50:00'),
('ORD20251111', 'IN_STORE', 'COMPLETED', 11, 1, (SELECT id FROM tblTable WHERE tableNumber = 'T03'), '2025-11-11 14:25:00');

-- Order Items
INSERT INTO tblOrderItem (quantity, unitPrice, discount, orderId, dishId) VALUES
(1, 55000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251101'), (SELECT id FROM tblDish WHERE name = 'Phở Bò')),
(1, 45000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251101'), (SELECT id FROM tblDish WHERE name = 'Gỏi Cuốn')),
(1, 20000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251101'), (SELECT id FROM tblDish WHERE name = 'Cà Phê Sữa Đá')),

(2, 95000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251102'), (SELECT id FROM tblDish WHERE name = 'Beef Burger')),
(1, 35000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251102'), (SELECT id FROM tblDish WHERE name = 'Sinh Tố Xoài')),

(1, 180000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251103'), (SELECT id FROM tblDish WHERE name = 'Sushi Assorted')),
(1, 85000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251103'), (SELECT id FROM tblDish WHERE name = 'Ramen')),

(1, 75000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251104'), (SELECT id FROM tblDish WHERE name = 'Pad Thai')),
(1, 75000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251104'), (SELECT id FROM tblDish WHERE name = 'Tom Yum Soup')),
(1, 25000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251104'), (SELECT id FROM tblDish WHERE name = 'Nước Ép Cam Tươi')),

(1, 120000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251105'), (SELECT id FROM tblDish WHERE name = 'Pizza Margherita')),
(1, 85000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251105'), (SELECT id FROM tblDish WHERE name = 'Caesar Salad')),
(1, 45000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251105'), (SELECT id FROM tblDish WHERE name = 'Tiramisu')),

(1, 50000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251106'), (SELECT id FROM tblDish WHERE name = 'Cơm Tấm Sài Gòn')),
(1, 20000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251106'), (SELECT id FROM tblDish WHERE name = 'Chè Ba Màu')),
(1, 15000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251106'), (SELECT id FROM tblDish WHERE name = 'Cà Phê Đen Đá')),

(1, 250000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251107'), (SELECT id FROM tblDish WHERE name = 'Steak Ribeye')),
(1, 80000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251107'), (SELECT id FROM tblDish WHERE name = 'Greek Salad')),
(1, 25000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251107'), (SELECT id FROM tblDish WHERE name = 'Nước Ép Cam Tươi')),

(1, 95000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251108'), (SELECT id FROM tblDish WHERE name = 'Pasta Carbonara')),
(1, 95000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251108'), (SELECT id FROM tblDish WHERE name = 'Risotto Ai Funghi')),
(1, 25000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251108'), (SELECT id FROM tblDish WHERE name = 'Flan')),

(1, 150000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251109'), (SELECT id FROM tblDish WHERE name = 'Salmon Sashimi')),
(1, 180000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251109'), (SELECT id FROM tblDish WHERE name = 'Sushi Assorted')),
(1, 40000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251109'), (SELECT id FROM tblDish WHERE name = 'Mango Sticky Rice')),

(2, 35000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251110'), (SELECT id FROM tblDish WHERE name = 'Bánh Mì Thịt Nướng')),
(1, 30000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251110'), (SELECT id FROM tblDish WHERE name = 'Trà Sữa')),
(1, 20000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251110'), (SELECT id FROM tblDish WHERE name = 'Cà Phê Sữa Đá')),

(1, 80000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251111'), (SELECT id FROM tblDish WHERE name = 'Green Curry')),
(1, 40000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251111'), (SELECT id FROM tblDish WHERE name = 'Mango Sticky Rice')),
(1, 30000, 0, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251111'), (SELECT id FROM tblDish WHERE name = 'Trà Sữa'));

-- Invoices
INSERT INTO tblInvoice (invoiceNumber, issueDate, paymentMethod, status, total, paidAmount, orderId, cashierStaffId) VALUES
('INV20251101', '2025-11-01 11:40:00', 'CASH', 'PAID', 120000, 120000, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251101'), 1),
('INV20251102', '2025-11-02 18:40:00', 'E_WALLET', 'PAID', 225000, 225000, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251102'), 1),
('INV20251103', '2025-11-03 12:35:00', 'CREDIT_CARD', 'PAID', 265000, 265000, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251103'), 1),
('INV20251104', '2025-11-04 19:25:00', 'CASH', 'PAID', 175000, 175000, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251104'), 1),
('INV20251105', '2025-11-05 18:00:00', 'E_WALLET', 'PAID', 250000, 250000, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251105'), 1),
('INV20251106', '2025-11-06 08:40:00', 'CASH', 'PAID', 85000, 85000, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251106'), 1),
('INV20251107', '2025-11-07 20:40:00', 'CREDIT_CARD', 'PAID', 355000, 355000, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251107'), 1),
('INV20251108', '2025-11-08 14:05:00', 'E_WALLET', 'PAID', 215000, 215000, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251108'), 1),
('INV20251109', '2025-11-09 20:15:00', 'CREDIT_CARD', 'PAID', 370000, 370000, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251109'), 1),
('INV20251110', '2025-11-10 11:10:00', 'CASH', 'PAID', 120000, 120000, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251110'), 1),
('INV20251111', '2025-11-11 14:50:00', 'CASH', 'PAID', 150000, 150000, (SELECT id FROM tblOrder WHERE orderNumber = 'ORD20251111'), 1);

COMMIT;
