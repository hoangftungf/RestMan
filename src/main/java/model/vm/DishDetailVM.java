package model.vm;

import java.math.BigDecimal;

/**
 * View Model for displaying detailed dish information
 */
public class DishDetailVM {
    private int dishId;
    private String name;
    private String category;
    private String description;
    private BigDecimal price;
    private String imageUrl;
    private String[] ingredients;

    public DishDetailVM() {}

    public DishDetailVM(int dishId, String name, String category, String description,
                        BigDecimal price, String imageUrl) {
        this.dishId = dishId;
        this.name = name;
        this.category = category;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
    }

    // Getters and Setters
    public int getDishId() { return dishId; }
    public void setDishId(int dishId) { this.dishId = dishId; }

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

    public String[] getIngredients() { return ingredients; }
    public void setIngredients(String[] ingredients) { this.ingredients = ingredients; }

    // Format price for display (with currency)
    public String getFormattedPrice() {
        return String.format("%,.0f đ", price);
    }
}
