package vn.edu.hcmuaf.fit.projectltw.model;

import java.io.Serializable;
import java.util.Objects;

public class Product implements Serializable {
    private int id;
    private String name;
    private double price;
    private String image;
    private String category;
    private boolean isNew;
    private boolean isHot;

    // 1. Constructor không đối số (Bắt buộc cho JavaBeans)
    public Product() {}

    // 2. Constructor đầy đủ đối số (Dùng trong ProductDAO)
    public Product(int id, String name, double price, String image, String category, boolean isNew, boolean isHot) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.category = category;
        this.isNew = isNew;
        this.isHot = isHot;
    }

    // 3. Đầy đủ Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    // Phần này thiếu khiến JSP bị lỗi 500
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public boolean isNew() { return isNew; }
    public void setNew(boolean isNew) { this.isNew = isNew; }

    public boolean isHot() { return isHot; }
    public void setHot(boolean isHot) { this.isHot = isHot; }

    // 4. Override equals và hashCode (Quan trọng để lọc trùng sản phẩm)
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return id == product.id; // Hai sản phẩm giống nhau nếu có cùng ID
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    // 5. toString để dễ dàng debug/in ra console
    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", name='" + name + '\'' + ", price=" + price + '}';
    }
}