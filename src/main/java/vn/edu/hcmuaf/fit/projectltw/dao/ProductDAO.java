package vn.edu.hcmuaf.fit.projectltw.dao;

import vn.edu.hcmuaf.fit.projectltw.model.Product;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();

        // Dữ liệu điện thoại di động dựa trên danh sách ảnh của bạn
        // Tham số: ID, Tên, Giá, Tên file ảnh, Loại, IsNew, IsHot
        list.add(new Product(1, "OPPO Find X8", 18490000, "OPPO Find X8.jpg", "Phone", true, true));
        list.add(new Product(2, "OPPO Find X7 Ultra", 16900000, "oppo x7 ulta.jpg", "Phone", false, true));
        list.add(new Product(3, "OPPO Find X6 Pro", 12500000, "oppo x6 pro.jpg", "Phone", false, false));
        list.add(new Product(4, "Vivo X200 Pro", 19990000, "vivo x200 pro.jpg", "Phone", true, true));
        list.add(new Product(5, "Vivo X200", 15900000, "vivo x200.webp", "Phone", true, false));
        list.add(new Product(6, "Vivo X100 Pro", 13800000, "vivo-x100-pro.png", "Phone", false, true));

        return list;
    }
}