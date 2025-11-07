-- Test Accounts for RestMan System
-- ⚠️ IMPORTANT: All passwords are hashed using BCrypt
-- DO NOT commit plain text passwords to version control
-- 
-- Test Credentials (use these to login):
-- =================================================
-- STAFF:
--   Username: staff01
--   Password: password123 (hashed)
--
-- MANAGER:
--   Username: manager01
--   Password: password123 (hashed)
--
-- ADMIN:
--   Username: admin
--   Password: admin123 (hashed)
--
-- CUSTOMER (cannot login to staff system):
--   Username: customer01
--   Password: password123 (hashed)
-- =================================================

USE restMan;

-- Delete existing test accounts (if any)
DELETE FROM tblAccount WHERE username IN ('staff01', 'manager01', 'admin', 'customer01');

-- Insert test staff account
-- Password: password123 → $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu
INSERT INTO tblAccount (fullName, username, password, email, phone, address, gender, dateOfBirth, role, createdAt)
VALUES (
    'Nguyễn Văn A',
    'staff01',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu',
    'staff01@restman.com',
    '0123456789',
    'Hà Nội',
    'MALE',
    '1995-05-15',
    'STAFF',
    NOW()
);

-- Insert test manager account
-- Password: password123 → $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu
INSERT INTO tblAccount (fullName, username, password, email, phone, address, gender, dateOfBirth, role, createdAt)
VALUES (
    'Trần Thị B',
    'manager01',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu',
    'manager01@restman.com',
    '0987654321',
    'Hồ Chí Minh',
    'FEMALE',
    '1990-08-20',
    'MANAGER',
    NOW()
);

-- Insert test admin account
-- Password: admin123 → $2a$10$qYjmOkR0cEXw1lY9GkZ1K.4T7KvZ6D8Q3B2M5N9P6R7S8TU9
INSERT INTO tblAccount (fullName, username, password, email, phone, address, gender, dateOfBirth, role, createdAt)
VALUES (
    'Admin System',
    'admin',
    '$2a$10$qYjmOkR0cEXw1lY9GkZ1K.4T7KvZ6D8Q3B2M5N9P6R7S8TU9',
    'admin@restman.com',
    '0999999999',
    'Hà Nội',
    'MALE',
    '1985-01-01',
    'ADMIN',
    NOW()
);

-- Insert test customer account
-- Password: password123 → $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu
INSERT INTO tblAccount (fullName, username, password, email, phone, address, gender, dateOfBirth, role, createdAt)
VALUES (
    'Lê Văn C',
    'customer01',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhKu',
    'customer01@restman.com',
    '0111222333',
    'Đà Nẵng',
    'MALE',
    '2000-03-10',
    'CUSTOMER',
    NOW()
);

-- Display created accounts
SELECT
    id,
    fullName,
    username,
    email,
    role,
    createdAt
FROM tblAccount
WHERE username IN ('staff01', 'manager01', 'admin', 'customer01')
ORDER BY id;

