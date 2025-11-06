package model;

import java.math.BigDecimal;
import java.sql.Date;

public class MenuItem {
    private int id;
    private int displayOrder;
    private BigDecimal priceOverride;
    private String note;
    private Date effectiveFrom;
    private Date effectiveTo;
    private int menuId;
    private Integer dishId;
    private Integer comboId;

    public MenuItem() {}

    public MenuItem(int id, int displayOrder, BigDecimal priceOverride, String note,
                    Date effectiveFrom, Date effectiveTo, int menuId, Integer dishId, Integer comboId) {
        this.id = id;
        this.displayOrder = displayOrder;
        this.priceOverride = priceOverride;
        this.note = note;
        this.effectiveFrom = effectiveFrom;
        this.effectiveTo = effectiveTo;
        this.menuId = menuId;
        this.dishId = dishId;
        this.comboId = comboId;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(int displayOrder) { this.displayOrder = displayOrder; }

    public BigDecimal getPriceOverride() { return priceOverride; }
    public void setPriceOverride(BigDecimal priceOverride) { this.priceOverride = priceOverride; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public Date getEffectiveFrom() { return effectiveFrom; }
    public void setEffectiveFrom(Date effectiveFrom) { this.effectiveFrom = effectiveFrom; }

    public Date getEffectiveTo() { return effectiveTo; }
    public void setEffectiveTo(Date effectiveTo) { this.effectiveTo = effectiveTo; }

    public int getMenuId() { return menuId; }
    public void setMenuId(int menuId) { this.menuId = menuId; }

    public Integer getDishId() { return dishId; }
    public void setDishId(Integer dishId) { this.dishId = dishId; }

    public Integer getComboId() { return comboId; }
    public void setComboId(Integer comboId) { this.comboId = comboId; }
}
