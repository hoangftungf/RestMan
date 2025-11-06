package model;

import model.enums.InvoiceStatus;
import model.enums.PaymentMethod;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class Invoice {
    private int id;
    private String invoiceNumber;
    private Timestamp issueDate;
    private PaymentMethod paymentMethod;
    private InvoiceStatus status;
    private BigDecimal total;
    private BigDecimal paidAmount;
    private int orderId;
    private Integer cashierStaffId;

    public Invoice() {}

    public Invoice(int id, String invoiceNumber, Timestamp issueDate, PaymentMethod paymentMethod,
                   InvoiceStatus status, BigDecimal total, BigDecimal paidAmount, int orderId,
                   Integer cashierStaffId) {
        this.id = id;
        this.invoiceNumber = invoiceNumber;
        this.issueDate = issueDate;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.total = total;
        this.paidAmount = paidAmount;
        this.orderId = orderId;
        this.cashierStaffId = cashierStaffId;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getInvoiceNumber() { return invoiceNumber; }
    public void setInvoiceNumber(String invoiceNumber) { this.invoiceNumber = invoiceNumber; }

    public Timestamp getIssueDate() { return issueDate; }
    public void setIssueDate(Timestamp issueDate) { this.issueDate = issueDate; }

    public PaymentMethod getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(PaymentMethod paymentMethod) { this.paymentMethod = paymentMethod; }

    public InvoiceStatus getStatus() { return status; }
    public void setStatus(InvoiceStatus status) { this.status = status; }

    public BigDecimal getTotal() { return total; }
    public void setTotal(BigDecimal total) { this.total = total; }

    public BigDecimal getPaidAmount() { return paidAmount; }
    public void setPaidAmount(BigDecimal paidAmount) { this.paidAmount = paidAmount; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public Integer getCashierStaffId() { return cashierStaffId; }
    public void setCashierStaffId(Integer cashierStaffId) { this.cashierStaffId = cashierStaffId; }
}
