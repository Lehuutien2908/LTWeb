package vn.edu.hcmuaf.fit.projectltw.model;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class Cart implements Serializable {
    // Key: ID của Product (int), Value: CartItem
    private Map<Integer, CartItem> items = new HashMap<>();

    // 1. Thêm sản phẩm vào giỏ
    public void add(Product p) {
        if (p == null) return;

        if (items.containsKey(p.getId())) {
            // Nếu sản phẩm đã có -> Tăng số lượng lên 1
            CartItem item = items.get(p.getId());
            item.setQuantity(item.getQuantity() + 1);
        } else {
            // Nếu chưa có -> Thêm mới với số lượng 1
            items.put(p.getId(), new CartItem(p, 1));
        }
    }
    public void add(Product p, int quantity) {
        if (p == null) return;

        if (items.containsKey(p.getId())) {
            CartItem item = items.get(p.getId());
            item.setQuantity(item.getQuantity() + quantity);
        } else {
            items.put(p.getId(), new CartItem(p, quantity));
        }
    }

    // 2. Xóa sản phẩm khỏi giỏ
    public void remove(int id) {
        items.remove(id);
    }

    // 3. Cập nhật số lượng
    public void update(int id, int quantity) {
        if (items.containsKey(id)) {
            CartItem item = items.get(id);
            if (quantity < 1) {
                item.setQuantity(1);
            } else {
                item.setQuantity(quantity);
            }
        }
    }

    // 4. Tính tổng tiền cả giỏ hàng
    public double getTotalMoney() {
        double total = 0;
        for (CartItem item : items.values()) {
            total += item.getTotalPrice();
        }
        return total;
    }

    // 5. Lấy tổng số lượng sản phẩm
    public int getTotalQuantity() {
        int total = 0;
        for (CartItem item : items.values()) {
            total += item.getQuantity();
        }
        return total;
    }

    // Lấy danh sách item ra để duyệt
    public Map<Integer, CartItem> getItems() {
        return items;
    }

}