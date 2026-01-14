package vn.edu.hcmuaf.fit.projectltw.dao;

import vn.edu.hcmuaf.fit.projectltw.model.Order;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class OrderDAO {
    private static List<Order> orderList = new ArrayList<>();

    // Hàm lưu đơn hàng
    public void saveOrder(Order order) {
        orderList.add(order);
    }

    // Hàm lấy tất cả đơn hàng
    public List<Order> getAllOrders() {
        return orderList;
    }
}