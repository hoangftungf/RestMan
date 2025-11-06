package model;

import model.enums.Gender;
import java.sql.Date;
import java.sql.Timestamp;

public class Customer {
    private int id;
    private Integer accountId;
    private String fullName;
    private String phone;
    private String email;
    private String address;
    private Date dateOfBirth;
    private Gender gender;
    private Timestamp createdAt;

    public Customer() {}

    public Customer(int id, Integer accountId, String fullName, String phone, String email,
                    String address, Date dateOfBirth, Gender gender) {
        this.id = id;
        this.accountId = accountId;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Integer getAccountId() { return accountId; }
    public void setAccountId(Integer accountId) { this.accountId = accountId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public Date getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public Gender getGender() { return gender; }
    public void setGender(Gender gender) { this.gender = gender; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
