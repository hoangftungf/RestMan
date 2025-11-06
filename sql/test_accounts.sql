-- Test Accounts for RestMan System
-- Password: All accounts use plain text passwords for testing
-- In production, passwords should be hashed using BCrypt

USE restMan;

-- Insert test staff account
INSERT INTO tblAccount (fullName, username, password, email, phone, address, gender, dateOfBirth, role, createdAt)
VALUES (
    'Nguyễn Văn A',
    'staff01',
    'password123',
    'staff01@restman.com',
    '0123456789',
    'Hà Nội',
    'MALE',
    '1995-05-15',
    'STAFF',
    NOW()
);

-- Insert test manager account
INSERT INTO tblAccount (fullName, username, password, email, phone, address, gender, dateOfBirth, role, createdAt)
VALUES (
    'Trần Thị B',
    'manager01',
    'password123',
    'manager01@restman.com',
    '0987654321',
    'Hồ Chí Minh',
    'FEMALE',
    '1990-08-20',
    'MANAGER',
    NOW()
);

-- Insert test admin account
INSERT INTO tblAccount (fullName, username, password, email, phone, address, gender, dateOfBirth, role, createdAt)
VALUES (
    'Admin System',
    'admin',
    'admin123',
    'admin@restman.com',
    '0999999999',
    'Hà Nội',
    'MALE',
    '1985-01-01',
    'ADMIN',
    NOW()
);

-- Insert test customer account (for reference)
INSERT INTO tblAccount (fullName, username, password, email, phone, address, gender, dateOfBirth, role, createdAt)
VALUES (
    'Lê Văn C',
    'customer01',
    'password123',
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
    password,
    email,
    role,
    createdAt
FROM tblAccount
ORDER BY id DESC
LIMIT 10;

-- Login credentials for testing:
-- ================================
-- STAFF:
--   Username: staff01
--   Password: password123
--
-- MANAGER:
--   Username: manager01
--   Password: password123
--
-- ADMIN:
--   Username: admin
--   Password: admin123
--
-- CUSTOMER (cannot login to staff system):
--   Username: customer01
--   Password: password123
