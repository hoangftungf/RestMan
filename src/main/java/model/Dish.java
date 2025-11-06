package model;

import model.enums.DishStatus;
import java.math.BigDecimal;
import java.sql.Timestamp;

public class Dish {
    private int id;
    private String name;
    private String category;
    private String description;
    private BigDecimal price;
    private String imageUrl;
    private DishStatus status;
    private Timestamp createdAt;

    public Dish() {}

    public Dish(int id, String name, String category, String description, BigDecimal price,
                String imageUrl, DishStatus status) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
        this.status = status;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public DishStatus getStatus() { return status; }
    public void setStatus(DishStatus status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
