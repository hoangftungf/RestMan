package model;

import model.enums.MembershipTier;
import java.sql.Date;

public class MembershipCard {
    private int id;
    private String cardNumber;
    private MembershipTier tier;
    private int point;
    private Date createdAt;
    private Date expiredAt;
    private String status;
    private int customerId;
    private Integer staffId;

    public MembershipCard() {}

    public MembershipCard(int id, String cardNumber, MembershipTier tier, int point,
                          Date createdAt, Date expiredAt, String status, int customerId,
                          Integer staffId) {
        this.id = id;
        this.cardNumber = cardNumber;
        this.tier = tier;
        this.point = point;
        this.createdAt = createdAt;
        this.expiredAt = expiredAt;
        this.status = status;
        this.customerId = customerId;
        this.staffId = staffId;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCardNumber() { return cardNumber; }
    public void setCardNumber(String cardNumber) { this.cardNumber = cardNumber; }

    public MembershipTier getTier() { return tier; }
    public void setTier(MembershipTier tier) { this.tier = tier; }

    public int getPoint() { return point; }
    public void setPoint(int point) { this.point = point; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getExpiredAt() { return expiredAt; }
    public void setExpiredAt(Date expiredAt) { this.expiredAt = expiredAt; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public Integer getStaffId() { return staffId; }
    public void setStaffId(Integer staffId) { this.staffId = staffId; }
}
