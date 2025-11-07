-- RestMan Database Schema
-- Restaurant Management System

-- Drop tables if exist (in reverse order of dependencies)
DROP TABLE IF EXISTS tblReceiptItem;
DROP TABLE IF EXISTS tblImportReceipt;
DROP TABLE IF EXISTS tblSupplier;
DROP TABLE IF EXISTS tblIngredient;
DROP TABLE IF EXISTS tblComboItem;
DROP TABLE IF EXISTS tblCombo;
DROP TABLE IF EXISTS tblMenuItem;
DROP TABLE IF EXISTS tblDish;
DROP TABLE IF EXISTS tblMenu;
DROP TABLE IF EXISTS tblInvoice;
DROP TABLE IF EXISTS tblOrderItem;
DROP TABLE IF EXISTS tblOrder;
DROP TABLE IF EXISTS tblTable;
DROP TABLE IF EXISTS tblReservation;
DROP TABLE IF EXISTS tblMembershipCard;
DROP TABLE IF EXISTS tblCustomer;
DROP TABLE IF EXISTS tblInventoryStaff;
DROP TABLE IF EXISTS tblSaleStaff;
DROP TABLE IF EXISTS tblManager;
DROP TABLE IF EXISTS tblStaff;
DROP TABLE IF EXISTS tblAccount;

-- Create tblAccount
CREATE TABLE tblAccount (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullName VARCHAR(255) NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    address TEXT,
    gender ENUM('MALE', 'FEMALE', 'OTHER'),
    dateOfBirth DATE,
    role ENUM('CUSTOMER', 'STAFF', 'MANAGER', 'ADMIN') NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblStaff
CREATE TABLE tblStaff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    accountId INT UNIQUE NOT NULL,
    employeeCode VARCHAR(50) UNIQUE,
    department VARCHAR(100),
    position VARCHAR(100),
    hireDate DATE,
    salary DECIMAL(15,2),
    status ENUM('ACTIVE', 'INACTIVE', 'ON_LEAVE') DEFAULT 'ACTIVE',
    FOREIGN KEY (accountId) REFERENCES tblAccount(id) ON DELETE CASCADE,
    INDEX idx_employee_code (employeeCode)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblManager
CREATE TABLE tblManager (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staffId INT UNIQUE NOT NULL,
    managerLevel ENUM('SENIOR', 'JUNIOR', 'GENERAL') DEFAULT 'JUNIOR',
    FOREIGN KEY (staffId) REFERENCES tblStaff(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblSaleStaff
CREATE TABLE tblSaleStaff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staffId INT UNIQUE NOT NULL,
    commissionRate DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (staffId) REFERENCES tblStaff(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblInventoryStaff
CREATE TABLE tblInventoryStaff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staffId INT UNIQUE NOT NULL,
    warehouseSection VARCHAR(100),
    FOREIGN KEY (staffId) REFERENCES tblStaff(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblCustomer
CREATE TABLE tblCustomer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    accountId INT UNIQUE,
    fullName VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(255),
    address TEXT,
    dateOfBirth DATE,
    gender ENUM('MALE', 'FEMALE', 'OTHER'),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (accountId) REFERENCES tblAccount(id) ON DELETE SET NULL,
    INDEX idx_phone (phone),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblMembershipCard
CREATE TABLE tblMembershipCard (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cardNumber VARCHAR(50) UNIQUE NOT NULL,
    tier ENUM('BRONZE', 'SILVER', 'GOLD', 'VIP') DEFAULT 'BRONZE',
    points INT DEFAULT 0,
    issuedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expiredAt TIMESTAMP,
    status ENUM('ACTIVE', 'INACTIVE', 'EXPIRED') DEFAULT 'ACTIVE',
    customerId INT UNIQUE NOT NULL,
    issuedByStaffId INT,
    FOREIGN KEY (customerId) REFERENCES tblCustomer(id) ON DELETE CASCADE,
    FOREIGN KEY (issuedByStaffId) REFERENCES tblStaff(id) ON DELETE SET NULL,
    INDEX idx_card_number (cardNumber),
    INDEX idx_tier (tier)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblReservation
CREATE TABLE tblReservation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reservationNumber VARCHAR(50) UNIQUE,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    date DATE NOT NULL,
    time TIME NOT NULL,
    numberOfGuests INT NOT NULL,
    phone VARCHAR(20) NOT NULL,
    note TEXT,
    status ENUM('PENDING', 'CONFIRMED', 'CANCELLED', 'COMPLETED') DEFAULT 'PENDING',
    customerId INT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customerId) REFERENCES tblCustomer(id) ON DELETE SET NULL,
    INDEX idx_reservation_number (reservationNumber),
    INDEX idx_date (date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblTable
CREATE TABLE tblTable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tableNumber VARCHAR(20) UNIQUE NOT NULL,
    capacity INT NOT NULL,
    location VARCHAR(100),
    status ENUM('AVAILABLE', 'OCCUPIED', 'RESERVED', 'MAINTENANCE') DEFAULT 'AVAILABLE',
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblOrder
CREATE TABLE tblOrder (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orderNumber VARCHAR(50) UNIQUE,
    channel ENUM('ONLINE', 'IN_STORE', 'PHONE') DEFAULT 'IN_STORE',
    status ENUM('PENDING', 'CONFIRMED', 'PREPARING', 'COMPLETED', 'CANCELLED') DEFAULT 'PENDING',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    customerId INT,
    saleStaffId INT,
    tableId INT,
    FOREIGN KEY (customerId) REFERENCES tblCustomer(id) ON DELETE SET NULL,
    FOREIGN KEY (saleStaffId) REFERENCES tblStaff(id) ON DELETE SET NULL,
    FOREIGN KEY (tableId) REFERENCES tblTable(id) ON DELETE SET NULL,
    INDEX idx_order_number (orderNumber),
    INDEX idx_status (status),
    INDEX idx_created_at (createdAt)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblMenu
CREATE TABLE tblMenu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type ENUM('BREAKFAST', 'LUNCH', 'DINNER', 'DRINKS', 'DESSERT', 'SPECIAL') DEFAULT 'LUNCH',
    effectiveFrom DATE,
    effectiveTo DATE,
    status ENUM('ACTIVE', 'INACTIVE', 'DRAFT') DEFAULT 'ACTIVE',
    description TEXT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_status (status),
    INDEX idx_type (type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblDish
CREATE TABLE tblDish (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    imageUrl VARCHAR(500),
    status ENUM('ACTIVE', 'INACTIVE', 'OUT_OF_STOCK') DEFAULT 'ACTIVE',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_name (name),
    INDEX idx_category (category),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblCombo
CREATE TABLE tblCombo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblMenuItem
CREATE TABLE tblMenuItem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    displayOrder INT DEFAULT 0,
    priceOverride DECIMAL(10,2),
    note TEXT,
    effectiveFrom DATE,
    effectiveTo DATE,
    menuId INT NOT NULL,
    dishId INT,
    comboId INT,
    FOREIGN KEY (menuId) REFERENCES tblMenu(id) ON DELETE CASCADE,
    FOREIGN KEY (dishId) REFERENCES tblDish(id) ON DELETE CASCADE,
    FOREIGN KEY (comboId) REFERENCES tblCombo(id) ON DELETE CASCADE,
    CHECK ((dishId IS NOT NULL AND comboId IS NULL) OR (dishId IS NULL AND comboId IS NOT NULL)),
    INDEX idx_menu_id (menuId),
    INDEX idx_display_order (displayOrder)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblComboItem
CREATE TABLE tblComboItem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL DEFAULT 1,
    comboId INT NOT NULL,
    dishId INT NOT NULL,
    FOREIGN KEY (comboId) REFERENCES tblCombo(id) ON DELETE CASCADE,
    FOREIGN KEY (dishId) REFERENCES tblDish(id) ON DELETE CASCADE,
    INDEX idx_combo_id (comboId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblOrderItem
CREATE TABLE tblOrderItem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL DEFAULT 1,
    unitPrice DECIMAL(10,2) NOT NULL,
    discount DECIMAL(10,2) DEFAULT 0.00,
    note TEXT,
    orderId INT NOT NULL,
    dishId INT,
    comboId INT,
    FOREIGN KEY (orderId) REFERENCES tblOrder(id) ON DELETE CASCADE,
    FOREIGN KEY (dishId) REFERENCES tblDish(id) ON DELETE SET NULL,
    FOREIGN KEY (comboId) REFERENCES tblCombo(id) ON DELETE SET NULL,
    CHECK ((dishId IS NOT NULL AND comboId IS NULL) OR (dishId IS NULL AND comboId IS NOT NULL)),
    INDEX idx_order_id (orderId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblInvoice
CREATE TABLE tblInvoice (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoiceNumber VARCHAR(50) UNIQUE,
    issueDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    paymentMethod ENUM('CASH', 'CREDIT_CARD', 'DEBIT_CARD', 'E_WALLET', 'BANK_TRANSFER') NOT NULL,
    status ENUM('PENDING', 'PAID', 'PARTIALLY_PAID', 'CANCELLED') DEFAULT 'PENDING',
    total DECIMAL(15,2) NOT NULL,
    paidAmount DECIMAL(15,2) DEFAULT 0.00,
    orderId INT UNIQUE NOT NULL,
    cashierStaffId INT,
    FOREIGN KEY (orderId) REFERENCES tblOrder(id) ON DELETE CASCADE,
    FOREIGN KEY (cashierStaffId) REFERENCES tblStaff(id) ON DELETE SET NULL,
    INDEX idx_invoice_number (invoiceNumber),
    INDEX idx_status (status),
    INDEX idx_issue_date (issueDate)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblIngredient
CREATE TABLE tblIngredient (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    unit VARCHAR(50),
    price DECIMAL(10,2),
    stockQuantity DECIMAL(10,2) DEFAULT 0,
    minStockLevel DECIMAL(10,2) DEFAULT 0,
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblSupplier
CREATE TABLE tblSupplier (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contactPerson VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255),
    address TEXT,
    description TEXT,
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblImportReceipt
CREATE TABLE tblImportReceipt (
    id INT AUTO_INCREMENT PRIMARY KEY,
    receiptNumber VARCHAR(50) UNIQUE,
    importDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    supplierId INT NOT NULL,
    inventoryStaffId INT,
    status ENUM('PENDING', 'APPROVED', 'RECEIVED', 'CANCELLED') DEFAULT 'PENDING',
    note TEXT,
    FOREIGN KEY (supplierId) REFERENCES tblSupplier(id) ON DELETE RESTRICT,
    FOREIGN KEY (inventoryStaffId) REFERENCES tblStaff(id) ON DELETE SET NULL,
    INDEX idx_receipt_number (receiptNumber),
    INDEX idx_import_date (importDate)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create tblReceiptItem
CREATE TABLE tblReceiptItem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity DECIMAL(10,2) NOT NULL,
    unitPrice DECIMAL(10,2) NOT NULL,
    note TEXT,
    importReceiptId INT NOT NULL,
    ingredientId INT NOT NULL,
    FOREIGN KEY (importReceiptId) REFERENCES tblImportReceipt(id) ON DELETE CASCADE,
    FOREIGN KEY (ingredientId) REFERENCES tblIngredient(id) ON DELETE RESTRICT,
    INDEX idx_import_receipt_id (importReceiptId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
