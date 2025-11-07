package model;

import model.enums.MenuStatus;
import model.enums.MenuType;
import java.sql.Date;
import java.sql.Timestamp;

public class Menu {
    private int id;
    private String name;
    private MenuType type;
    private Date effectiveFrom;
    private Date effectiveTo;
    private MenuStatus status;
    private String description;
    private Timestamp createdAt;

    public Menu() {}

    public Menu(int id, String name, MenuType type, Date effectiveFrom, Date effectiveTo,
                MenuStatus status, String description) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.effectiveFrom = effectiveFrom;
        this.effectiveTo = effectiveTo;
        this.status = status;
        this.description = description;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public MenuType getType() { return type; }
    public void setType(MenuType type) { this.type = type; }

    public Date getEffectiveFrom() { return effectiveFrom; }
    public void setEffectiveFrom(Date effectiveFrom) { this.effectiveFrom = effectiveFrom; }

    public Date getEffectiveTo() { return effectiveTo; }
    public void setEffectiveTo(Date effectiveTo) { this.effectiveTo = effectiveTo; }

    public MenuStatus getStatus() { return status; }
    public void setStatus(MenuStatus status) { this.status = status; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
