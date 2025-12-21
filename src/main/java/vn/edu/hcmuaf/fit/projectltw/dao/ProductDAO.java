package vn.edu.hcmuaf.fit.projectltw.dao;

import vn.edu.hcmuaf.fit.projectltw.model.Product;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {


    public List<Product> getNewProducts() {
        List<Product> list = new ArrayList<>();

        // Sử dụng chính xác 12 ảnh đầu tiên trong danh sách 19 ảnh
        list.add(new Product(1, "HUAWEI Mate XT Ultimate Design", 89990000, "HUAWEI-Mate-XT-design.jpg", "Phone", true, true));
        list.add(new Product(2, "Honor Magic7 RSR Porsche Design", 45000000, "honor magic7 rsr.jpg", "Phone", true, true));
        list.add(new Product(3, "Xiaomi 17 Ultra Premium", 32990000, "xiaomi 17 ultra.jpg", "Phone", true, true));
        list.add(new Product(4, "OPPO Find X9 Pro 5G", 26500000, "oppo find x9 pro.jpg", "Phone", true, false));
        list.add(new Product(5, "Vivo X200 Ultra 5G", 28900000, "vivo x200 ultra.jpg", "Phone", true, true));
        list.add(new Product(6, "Xiaomi 17 Pro Max - Series", 35000000, "Xiaomi-17 pro max -series.jpg", "Phone", true, true));
        list.add(new Product(7, "OnePlus 13 Snapdragon 8 Elite", 19500000, "oneplus 13.webp", "Phone", true, false));
        list.add(new Product(8, "Vivo X300 Webp Special Edition", 22000000, "vivo X300.webp", "Phone", true, false));
        list.add(new Product(9, "Xiaomi 17 Standard Edition", 21500000, "xiaomi 17.jpg", "Phone", true, false));
        list.add(new Product(10, "OPPO Find X8 Series", 23000000, "oppo find x8 series.jpeg", "Phone", true, false));
        list.add(new Product(11, "Vivo X200 Pro Edition", 25500000, "vivo x200.webp", "Phone", true, false));
        list.add(new Product(12, "Xiaomi 15 Ultra Part 2", 30500000, "xiaomi 15 ultra part 2.png", "Phone", true, false));

        return list;
    }


    public List<Product> getHotProducts() {
        List<Product> list = new ArrayList<>();

        // 7 Sản phẩm khác biệt từ danh sách 19 ảnh
        list.add(new Product(13, "OPPO Find X9 Global Launch", 27000000, "OPPO_Find_X9_Series_Global_Launch-header.webp", "Phone", false, true));
        list.add(new Product(14, "Xiaomi 14 Ultra Global", 18900000, "xiaomi-14-ultra.jpg", "Phone", false, true));
        list.add(new Product(15, "OPPO Find X7 Ultra Premium", 16800000, "oppo find x7 ultra.jpg", "Phone", false, true));
        list.add(new Product(16, "Xiaomi 15 Pro Series Edition", 14500000, "xiaomi 15 series.png", "Phone", false, true));
        list.add(new Product(17, "Xiaomi 15 Compact Edition", 13500000, "xiaomi 15.jpg", "Phone", false, true));
        list.add(new Product(18, "Oppo X7 Ultra Edition", 17200000, "oppo x7 ultra.jpg", "Phone", false, true));
        list.add(new Product(19, "Xiaomi 14 Global Featured", 15900000, "Xiaomi-14-global-featured-1420x799.webp", "Phone", false, true));

        // Thêm đúng 5 sản phẩm trùng lặp (ID 1 đến 5) để đủ 12 sản phẩm
        list.add(new Product(1, "HUAWEI Mate XT Ultimate Design", 89990000, "HUAWEI-Mate-XT-design.jpg", "Phone", true, true));
        list.add(new Product(2, "Honor Magic7 RSR Porsche Design", 45000000, "honor magic7 rsr.jpg", "Phone", true, true));
        list.add(new Product(3, "Xiaomi 17 Ultra Premium", 32990000, "xiaomi 17 ultra.jpg", "Phone", true, true));
        list.add(new Product(4, "OPPO Find X9 Pro 5G", 26500000, "oppo find x9 pro.jpg", "Phone", true, false));
        list.add(new Product(5, "Vivo X200 Ultra 5G", 28900000, "vivo x200 ultra.jpg", "Phone", true, true));

        return list;
    }

    public List<Product> getAllProducts() {
        List<Product> all = new ArrayList<>(getNewProducts());
        for (Product p : getHotProducts()) {
            if (!all.contains(p)) {
                all.add(p);
            }
        }
        return all;
    }
    public List<Product> getSaleProducts() {
        List<Product> hot = getHotProducts();
        // Lấy tối đa 5 sản phẩm từ danh sách Hot để làm hàng giảm giá
        return hot.subList(0, Math.min(hot.size(), 5));
    }
}