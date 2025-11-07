-- ================================================================
-- RestMan - Add 36 Dishes to Menu
-- Restaurant Management System - Dishes Data
-- ================================================================

-- ================================================================
-- DISHES (36 Total)
-- ================================================================

-- Vietnamese Dishes
INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Phở Bò', 'Vietnamese', 'Traditional beef pho with rice noodles', 55000, 'ACTIVE', '/images/pho-bo.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Bún Chả Hà Nội', 'Vietnamese', 'Hanoi style grilled pork with vermicelli', 60000, 'ACTIVE', '/images/bun-cha.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Cơm Tấm Sài Gòn', 'Vietnamese', 'Broken rice with pork chop', 50000, 'ACTIVE', '/images/com-tam.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Bánh Mì Thịt Nướng', 'Vietnamese', 'Vietnamese banh mi sandwich', 35000, 'ACTIVE', '/images/banh-mi.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Gỏi Cuốn', 'Vietnamese', 'Fresh spring rolls', 45000, 'ACTIVE', '/images/goi-cuon.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Hủ Tiếu Nam Vang', 'Vietnamese', 'Cambodian-style clear noodle soup', 65000, 'ACTIVE', '/images/hu-tieu.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Mì Xào Lạc', 'Vietnamese', 'Noodles with peanut sauce', 55000, 'ACTIVE', '/images/mi-xao.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Chả Cá Hà Nội', 'Vietnamese', 'Turmeric fish cake with turmeric and dill', 70000, 'ACTIVE', '/images/cha-ca.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Nem Cua Bể', 'Vietnamese', 'Crab and shrimp spring roll', 50000, 'ACTIVE', '/images/nem-cua.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Cơm Chiên Tôm', 'Vietnamese', 'Shrimp fried rice', 65000, 'ACTIVE', '/images/com-chien-tom.jpg');

-- International Dishes - Western
INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Steak Ribeye', 'Western', 'Prime ribeye steak 300g', 250000, 'ACTIVE', '/images/ribeye.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Beef Burger', 'Western', 'Classic beef burger with fries', 95000, 'ACTIVE', '/images/burger.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Grilled Chicken', 'Western', 'Herb marinated grilled chicken breast', 110000, 'ACTIVE', '/images/grilled-chicken.jpg');

-- Italian Dishes
INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Pasta Carbonara', 'Italian', 'Classic spaghetti carbonara', 95000, 'ACTIVE', '/images/carbonara.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Pasta Bolognese', 'Italian', 'Spaghetti with meat sauce', 85000, 'ACTIVE', '/images/bolognese.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Risotto Ai Funghi', 'Italian', 'Mushroom risotto', 95000, 'ACTIVE', '/images/risotto.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Pizza Margherita', 'Italian', 'Classic pizza with tomato, mozzarella, basil', 120000, 'ACTIVE', '/images/margherita.jpg');

-- Japanese Dishes
INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Salmon Sashimi', 'Japanese', 'Fresh salmon sashimi platter', 150000, 'ACTIVE', '/images/salmon.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Sushi Assorted', 'Japanese', 'Mixed sushi platter', 180000, 'ACTIVE', '/images/sushi-mix.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Ramen', 'Japanese', 'Japanese noodle soup with pork', 85000, 'ACTIVE', '/images/ramen.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Tonkatsu', 'Japanese', 'Breaded pork cutlet', 105000, 'ACTIVE', '/images/tonkatsu.jpg');

-- Thai Dishes
INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Pad Thai', 'Thai', 'Traditional Thai stir-fried noodles', 75000, 'ACTIVE', '/images/pad-thai.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Green Curry', 'Thai', 'Spicy green curry with chicken', 80000, 'ACTIVE', '/images/green-curry.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Tom Yum Soup', 'Thai', 'Spicy sour soup with shrimp', 75000, 'ACTIVE', '/images/tom-yum.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Mango Sticky Rice', 'Thai', 'Sweet mango with sticky rice', 40000, 'ACTIVE', '/images/mango-sticky.jpg');

-- Salads
INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Caesar Salad', 'Salad', 'Fresh caesar salad with grilled chicken', 85000, 'ACTIVE', '/images/caesar.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Greek Salad', 'Salad', 'Fresh salad with feta cheese and olives', 80000, 'ACTIVE', '/images/greek-salad.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Niçoise Salad', 'Salad', 'Tuna salad with hard boiled eggs', 95000, 'ACTIVE', '/images/nicoise.jpg');

-- Beverages
INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Cà Phê Đen Đá', 'Beverage', 'Vietnamese iced black coffee', 15000, 'ACTIVE', '/images/coffee.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Cà Phê Sữa Đá', 'Beverage', 'Vietnamese iced coffee with milk', 20000, 'ACTIVE', '/images/coffee-milk.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Trà Sữa', 'Beverage', 'Boba tea milk tea', 30000, 'ACTIVE', '/images/bubble-tea.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Nước Ép Cam Tươi', 'Beverage', 'Fresh orange juice', 25000, 'ACTIVE', '/images/oj.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Sinh Tố Xoài', 'Beverage', 'Mango smoothie', 35000, 'ACTIVE', '/images/mango-smoothie.jpg');

-- Desserts
INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Chè Ba Màu', 'Dessert', 'Three color Vietnamese dessert', 20000, 'ACTIVE', '/images/che.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Tiramisu', 'Dessert', 'Italian tiramisu cake', 45000, 'ACTIVE', '/images/tiramisu.jpg');

INSERT INTO tblDish (name, category, description, price, status, imageUrl)
VALUES ('Flan', 'Dessert', 'Vietnamese caramel custard', 25000, 'ACTIVE', '/images/flan.jpg');

-- ================================================================
-- Verification
-- ================================================================
SELECT COUNT(*) as total_dishes FROM tblDish;
COMMIT;
