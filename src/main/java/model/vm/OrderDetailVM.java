package model.vm;

import model.enums.InvoiceStatus;
import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * View Model for displaying order with item details
 */
public class OrderDetailVM {
    private int orderId;
    private String orderNumber;
    private Timestamp createdAt;
    private String dishName;
    private int quantity;
    private BigDecimal unitPrice;
    private BigDecimal discount;
    private BigDecimal lineTotal;
    private InvoiceStatus invoiceStatus;

    public OrderDetailVM() {}

    public OrderDetailVM(int orderId, String orderNumber, Timestamp createdAt, String dishName,
                         int quantity, BigDecimal unitPrice, BigDecimal discount,
                         BigDecimal lineTotal, InvoiceStatus invoiceStatus) {
        this.orderId = orderId;
        this.orderNumber = orderNumber;
        this.createdAt = createdAt;
        this.dishName = dishName;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.discount = discount;
        this.lineTotal = lineTotal;
        this.invoiceStatus = invoiceStatus;
    }

    // Getters and Setters
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public String getOrderNumber() { return orderNumber; }
    public void setOrderNumber(String orderNumber) { this.orderNumber = orderNumber; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getDishName() { return dishName; }
    public void setDishName(String dishName) { this.dishName = dishName; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }

    public BigDecimal getDiscount() { return discount; }
    public void setDiscount(BigDecimal discount) { this.discount = discount; }

    public BigDecimal getLineTotal() { return lineTotal; }
    public void setLineTotal(BigDecimal lineTotal) { this.lineTotal = lineTotal; }

    public InvoiceStatus getInvoiceStatus() { return invoiceStatus; }
    public void setInvoiceStatus(InvoiceStatus invoiceStatus) { this.invoiceStatus = invoiceStatus; }
}
