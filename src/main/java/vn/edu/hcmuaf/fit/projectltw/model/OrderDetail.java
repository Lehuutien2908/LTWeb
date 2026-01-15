package vn.edu.hcmuaf.fit.projectltw.model;

import java.io.Serializable;

public class OrderDetail implements Serializable {
    private String productName;
    private String productImage;
    private int quantity;
    private double price;

    public OrderDetail() {
    }

    public OrderDetail(String productName, String productImage, int quantity, double price) {
        this.productName = productName;
        this.productImage = productImage;
        this.quantity = quantity;
        this.price = price;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getTotalPrice() {
        return this.price * this.quantity;
    }
}