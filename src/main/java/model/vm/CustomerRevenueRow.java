package model.vm;

import model.enums.MembershipTier;
import java.math.BigDecimal;

/**
 * View Model for customer revenue report row
 */
public class CustomerRevenueRow {
    private int customerId;
    private String fullName;
    private String phone;
    private String email;
    private MembershipTier tier;
    private int orderCount;
    private int invoiceCount;
    private BigDecimal totalRevenue;

    public CustomerRevenueRow() {}

    public CustomerRevenueRow(int customerId, String fullName, String phone, String email,
                              MembershipTier tier, int orderCount, int invoiceCount,
                              BigDecimal totalRevenue) {
        this.customerId = customerId;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.tier = tier;
        this.orderCount = orderCount;
        this.invoiceCount = invoiceCount;
        this.totalRevenue = totalRevenue;
    }

    // Getters and Setters
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public MembershipTier getTier() { return tier; }
    public void setTier(MembershipTier tier) { this.tier = tier; }

    public int getOrderCount() { return orderCount; }
    public void setOrderCount(int orderCount) { this.orderCount = orderCount; }

    public int getInvoiceCount() { return invoiceCount; }
    public void setInvoiceCount(int invoiceCount) { this.invoiceCount = invoiceCount; }

    public BigDecimal getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(BigDecimal totalRevenue) { this.totalRevenue = totalRevenue; }

    // Format revenue for display
    public String getFormattedRevenue() {
        return String.format("%,.0f đ", totalRevenue);
    }

    public String getTierDisplay() {
        return tier != null ? tier.name() : "N/A";
    }
}
