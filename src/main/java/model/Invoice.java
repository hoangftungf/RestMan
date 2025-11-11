package model;

import model.enums.InvoiceStatus;
import model.enums.PaymentMethod;
import java.math.BigDecimal;

public class Invoice {
    private int id;
    private PaymentMethod paymentMethod;
    private InvoiceStatus status;
    private BigDecimal total;
    private int orderId;
    private Integer accountId;

    public Invoice() {}

    public Invoice(int id, PaymentMethod paymentMethod, InvoiceStatus status,
                   BigDecimal total, int orderId, Integer accountId) {
        this.id = id;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.total = total;
        this.orderId = orderId;
        this.accountId = accountId;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public PaymentMethod getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(PaymentMethod paymentMethod) { this.paymentMethod = paymentMethod; }

    public InvoiceStatus getStatus() { return status; }
    public void setStatus(InvoiceStatus status) { this.status = status; }

    public BigDecimal getTotal() { return total; }
    public void setTotal(BigDecimal total) { this.total = total; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public Integer getAccountId() { return accountId; }
    public void setAccountId(Integer accountId) { this.accountId = accountId; }
}
