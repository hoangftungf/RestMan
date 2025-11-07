package model.vm;

import java.math.BigDecimal;

/**
 * View Model for displaying dish in search results (card view)
 */
public class DishCardVM {
    private int dishId;
    private String name;
    private String category;
    private BigDecimal price;
    private String imageUrl;
    private String description;

    public DishCardVM() {}

    public DishCardVM(int dishId, String name, String category, BigDecimal price,
                      String imageUrl, String description) {
        this.dishId = dishId;
        this.name = name;
        this.category = category;
        this.price = price;
        this.imageUrl = imageUrl;
        this.description = description;
    }

    // Getters and Setters
    public int getDishId() { return dishId; }
    public void setDishId(int dishId) { this.dishId = dishId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    // Format price for display (with currency)
    public String getFormattedPrice() {
        return String.format("%,.0f đ", price);
    }
}
