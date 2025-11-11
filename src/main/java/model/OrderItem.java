package model;

import java.math.BigDecimal;

public class OrderItem {
    private int id;
    private int quantity;
    private BigDecimal unitPrice;
    private BigDecimal discount;
    private String note;
    private int orderId;
    private Integer dishId;
    private Integer comboId;
    private String dishName;

    public OrderItem() {}

    public OrderItem(int id, int quantity, BigDecimal unitPrice, BigDecimal discount, String note,
                     int orderId, Integer dishId, Integer comboId) {
        this.id = id;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.discount = discount;
        this.note = note;
        this.orderId = orderId;
        this.dishId = dishId;
        this.comboId = comboId;
    }

    // Calculate line total
    public BigDecimal getLineTotal() {
        BigDecimal subtotal = unitPrice.multiply(new BigDecimal(quantity));
        if (discount != null) {
            subtotal = subtotal.subtract(discount);
        }
        return subtotal;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }

    public BigDecimal getDiscount() { return discount; }
    public void setDiscount(BigDecimal discount) { this.discount = discount; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public Integer getDishId() { return dishId; }
    public void setDishId(Integer dishId) { this.dishId = dishId; }

    public Integer getComboId() { return comboId; }
    public void setComboId(Integer comboId) { this.comboId = comboId; }

    public String getDishName() { return dishName; }
    public void setDishName(String dishName) { this.dishName = dishName; }
}
