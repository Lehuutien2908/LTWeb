package vn.edu.hcmuaf.fit.projectltw.model;

import java.io.Serializable;

public class CartItem implements Serializable {
    private Product product;
    private int quantity;    // Số lượng khách chọn mua

    public CartItem() {
    }

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    // Tính thành tiền của riêng item này (Giá x Số lượng)
    public double getTotalPrice() {
        if (product == null) return 0;
        return product.getPrice() * quantity;
    }

    public double getPrice() {
        if (product == null) return 0;
        return product.getPrice();
    }
    // Getter & Setter
    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    @Override
    public String toString() {
        return "CartItem{" + "product=" + product.getName() + ", quantity=" + quantity + '}';
    }
}