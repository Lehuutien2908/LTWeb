package vn.edu.hcmuaf.fit.projectltw.model;

import java.io.Serializable;

public class Product implements Serializable {
    private int id;
    private String name;
    private double price;
    private String image;
    private String category;
    private boolean isNew;
    private boolean isHot;

    public Product() {}

    public Product(int id, String name, double price, String image, String category, boolean isNew, boolean isHot) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.category = category;
        this.isNew = isNew;
        this.isHot = isHot;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public boolean isNew() { return isNew; }
    public boolean isHot() { return isHot; }
}
