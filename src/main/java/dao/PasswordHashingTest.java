package dao;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Test class to verify BCrypt password hashing functionality
 * Run this to test BCrypt implementation before deploying
 */
public class PasswordHashingTest {
    
    public static void main(String[] args) {
        System.out.println("=== BCrypt Password Hashing Test ===\n");
        
        // Test 1: Basic hash and verify
        System.out.println("Test 1: Basic hash and verify");
        testBasicHashAndVerify();
        
        // Test 2: Same password, different hashes
        System.out.println("\nTest 2: Same password, different hashes");
        testDifferentHashesSamePassword();
        
        // Test 3: Wrong password detection
        System.out.println("\nTest 3: Wrong password detection");
        testWrongPasswordDetection();
        
        // Test 4: Hash length verification
        System.out.println("\nTest 4: Hash length verification");
        testHashLength();
        
        // Test 5: Performance test
        System.out.println("\nTest 5: Performance test");
        testPerformance();
        
        System.out.println("\n=== All tests completed ===");
    }
    
    private static void testBasicHashAndVerify() {
        String plainPassword = "MySecurePassword123!";
        
        // Hash password
        String hashedPassword = AccountDAO.hashPassword(plainPassword);
        System.out.println("Plain password:   " + plainPassword);
        System.out.println("Hashed password:  " + hashedPassword);
        
        // Verify correct password
        boolean isCorrect = BCrypt.checkpw(plainPassword, hashedPassword);
        System.out.println("Password matches: " + isCorrect);
        
        if (isCorrect) {
            System.out.println("✓ Test 1 PASSED");
        } else {
            System.out.println("✗ Test 1 FAILED");
        }
    }
    
    private static void testDifferentHashesSamePassword() {
        String password = "test123";
        
        // Create multiple hashes of same password
        String hash1 = AccountDAO.hashPassword(password);
        String hash2 = AccountDAO.hashPassword(password);
        String hash3 = AccountDAO.hashPassword(password);
        
        System.out.println("Same password hashed 3 times:");
        System.out.println("Hash 1: " + hash1);
        System.out.println("Hash 2: " + hash2);
        System.out.println("Hash 3: " + hash3);
        
        // Verify all hashes are different
        boolean allDifferent = !hash1.equals(hash2) && !hash2.equals(hash3) && !hash1.equals(hash3);
        System.out.println("All hashes are different: " + allDifferent);
        
        // But all verify correctly with same password
        boolean verify1 = BCrypt.checkpw(password, hash1);
        boolean verify2 = BCrypt.checkpw(password, hash2);
        boolean verify3 = BCrypt.checkpw(password, hash3);
        
        System.out.println("All verify correctly: " + (verify1 && verify2 && verify3));
        
        if (allDifferent && verify1 && verify2 && verify3) {
            System.out.println("✓ Test 2 PASSED");
        } else {
            System.out.println("✗ Test 2 FAILED");
        }
    }
    
    private static void testWrongPasswordDetection() {
        String correctPassword = "CorrectPassword123";
        String wrongPassword = "WrongPassword456";
        
        String hashedPassword = AccountDAO.hashPassword(correctPassword);
        
        // Test correct password
        boolean correctVerify = BCrypt.checkpw(correctPassword, hashedPassword);
        System.out.println("Correct password verifies:  " + correctVerify);
        
        // Test wrong password
        boolean wrongVerify = BCrypt.checkpw(wrongPassword, hashedPassword);
        System.out.println("Wrong password verifies:    " + wrongVerify);
        
        if (correctVerify && !wrongVerify) {
            System.out.println("✓ Test 3 PASSED");
        } else {
            System.out.println("✗ Test 3 FAILED");
        }
    }
    
    private static void testHashLength() {
        String password = "TestPassword123";
        String hashedPassword = AccountDAO.hashPassword(password);
        
        int length = hashedPassword.length();
        System.out.println("Hashed password length: " + length);
        System.out.println("Expected length: 60");
        
        if (length == 60) {
            System.out.println("✓ Test 4 PASSED");
        } else {
            System.out.println("✗ Test 4 FAILED - Hash length should be exactly 60");
        }
    }
    
    private static void testPerformance() {
        String password = "PerformanceTest123";
        
        // Test hashing performance
        long startHash = System.currentTimeMillis();
        String hash = AccountDAO.hashPassword(password);
        long endHash = System.currentTimeMillis();
        long hashTime = endHash - startHash;
        
        System.out.println("Hash time: " + hashTime + "ms");
        
        // Test verification performance
        long startVerify = System.currentTimeMillis();
        BCrypt.checkpw(password, hash);
        long endVerify = System.currentTimeMillis();
        long verifyTime = endVerify - startVerify;
        
        System.out.println("Verification time: " + verifyTime + "ms");
        
        // BCrypt should take 100-500ms (intentionally slow for security)
        if (hashTime > 50 && verifyTime > 50) {
            System.out.println("✓ Test 5 PASSED - Performance is in expected range");
        } else {
            System.out.println("⚠ Test 5 WARNING - Performance seems unusually fast");
        }
    }
}
