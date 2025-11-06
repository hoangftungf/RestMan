package model;

import model.enums.MembershipTier;
import java.sql.Timestamp;

public class MembershipCard {
    private int id;
    private String cardNumber;
    private MembershipTier tier;
    private int points;
    private Timestamp issuedAt;
    private Timestamp expiredAt;
    private String status;
    private int customerId;
    private Integer issuedByStaffId;

    public MembershipCard() {}

    public MembershipCard(int id, String cardNumber, MembershipTier tier, int points,
                          Timestamp issuedAt, Timestamp expiredAt, String status, int customerId,
                          Integer issuedByStaffId) {
        this.id = id;
        this.cardNumber = cardNumber;
        this.tier = tier;
        this.points = points;
        this.issuedAt = issuedAt;
        this.expiredAt = expiredAt;
        this.status = status;
        this.customerId = customerId;
        this.issuedByStaffId = issuedByStaffId;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCardNumber() { return cardNumber; }
    public void setCardNumber(String cardNumber) { this.cardNumber = cardNumber; }

    public MembershipTier getTier() { return tier; }
    public void setTier(MembershipTier tier) { this.tier = tier; }

    public int getPoints() { return points; }
    public void setPoints(int points) { this.points = points; }

    public Timestamp getIssuedAt() { return issuedAt; }
    public void setIssuedAt(Timestamp issuedAt) { this.issuedAt = issuedAt; }

    public Timestamp getExpiredAt() { return expiredAt; }
    public void setExpiredAt(Timestamp expiredAt) { this.expiredAt = expiredAt; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public Integer getIssuedByStaffId() { return issuedByStaffId; }
    public void setIssuedByStaffId(Integer issuedByStaffId) { this.issuedByStaffId = issuedByStaffId; }
}
