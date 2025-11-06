package model;

import model.enums.OrderChannel;
import model.enums.OrderStatus;
import java.sql.Timestamp;

public class Order {
    private int id;
    private String orderNumber;
    private OrderChannel channel;
    private OrderStatus status;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Integer customerId;
    private Integer saleStaffId;
    private Integer tableId;

    public Order() {}

    public Order(int id, String orderNumber, OrderChannel channel, OrderStatus status,
                 Integer customerId, Integer saleStaffId, Integer tableId) {
        this.id = id;
        this.orderNumber = orderNumber;
        this.channel = channel;
        this.status = status;
        this.customerId = customerId;
        this.saleStaffId = saleStaffId;
        this.tableId = tableId;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getOrderNumber() { return orderNumber; }
    public void setOrderNumber(String orderNumber) { this.orderNumber = orderNumber; }

    public OrderChannel getChannel() { return channel; }
    public void setChannel(OrderChannel channel) { this.channel = channel; }

    public OrderStatus getStatus() { return status; }
    public void setStatus(OrderStatus status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public Integer getCustomerId() { return customerId; }
    public void setCustomerId(Integer customerId) { this.customerId = customerId; }

    public Integer getSaleStaffId() { return saleStaffId; }
    public void setSaleStaffId(Integer saleStaffId) { this.saleStaffId = saleStaffId; }

    public Integer getTableId() { return tableId; }
    public void setTableId(Integer tableId) { this.tableId = tableId; }
}
