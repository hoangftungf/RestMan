package model;

import model.enums.OrderStatus;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class Order {
    private int id;
    private String name;
    private String email;
    private String phone;
    private Integer numberOfGuests;
    private String note;
    private OrderStatus status;
    private BigDecimal subTotal;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Integer tableId;
    private Integer accountId;

    public Order() {}

    public Order(int id, String name, String email, String phone, Integer numberOfGuests,
                 String note, OrderStatus status, BigDecimal subTotal,
                 Integer tableId, Integer accountId) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.numberOfGuests = numberOfGuests;
        this.note = note;
        this.status = status;
        this.subTotal = subTotal;
        this.tableId = tableId;
        this.accountId = accountId;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public Integer getNumberOfGuests() { return numberOfGuests; }
    public void setNumberOfGuests(Integer numberOfGuests) { this.numberOfGuests = numberOfGuests; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public OrderStatus getStatus() { return status; }
    public void setStatus(OrderStatus status) { this.status = status; }

    public BigDecimal getSubTotal() { return subTotal; }
    public void setSubTotal(BigDecimal subTotal) { this.subTotal = subTotal; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public Integer getTableId() { return tableId; }
    public void setTableId(Integer tableId) { this.tableId = tableId; }

    public Integer getAccountId() { return accountId; }
    public void setAccountId(Integer accountId) { this.accountId = accountId; }
}
