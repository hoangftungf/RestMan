package model.vm;

import model.enums.InvoiceStatus;
import model.enums.OrderStatus;
import java.sql.Timestamp;

/**
 * View Model for displaying customer order summary rows
 */
public class OrderDetailVM {
    private int orderId;
    private Timestamp createdAt;
    private InvoiceStatus invoiceStatus;
    private OrderStatus orderStatus;
    private String customerName;
    private String phone;

    public OrderDetailVM() {}

    public OrderDetailVM(int orderId, Timestamp createdAt, InvoiceStatus invoiceStatus,
                         OrderStatus orderStatus, String customerName, String phone) {
        this.orderId = orderId;
        this.createdAt = createdAt;
        this.invoiceStatus = invoiceStatus;
        this.orderStatus = orderStatus;
        this.customerName = customerName;
        this.phone = phone;
    }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public InvoiceStatus getInvoiceStatus() { return invoiceStatus; }
    public void setInvoiceStatus(InvoiceStatus invoiceStatus) { this.invoiceStatus = invoiceStatus; }

    public OrderStatus getOrderStatus() { return orderStatus; }
    public void setOrderStatus(OrderStatus orderStatus) { this.orderStatus = orderStatus; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getDisplayCode() {
        return String.format("ORD-%05d", orderId);
    }
}
