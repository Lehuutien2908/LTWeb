package vn.edu.hcmuaf.fit.projectltw.dao;

import vn.edu.hcmuaf.fit.projectltw.db.DBContext;
import vn.edu.hcmuaf.fit.projectltw.model.CartItem;
import vn.edu.hcmuaf.fit.projectltw.model.Order;
import java.sql.*;

public class OrderDAO {

    public void saveOrder(Order order) {
        String sqlOrder = "INSERT INTO orders (order_id, fullname, phone, address, note, total_money) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlDetail = "INSERT INTO order_details (order_id, product_id, price, quantity) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu transaction để đảm bảo lưu cả 2 bảng hoặc không lưu gì

            // 1. Lưu vào bảng orders
            try (PreparedStatement psOrder = conn.prepareStatement(sqlOrder)) {
                psOrder.setString(1, order.getId());
                psOrder.setString(2, order.getFullName());
                psOrder.setString(3, order.getPhone());
                psOrder.setString(4, order.getAddress());
                psOrder.setString(5, order.getNote());
                psOrder.setDouble(6, order.getTotalMoney());
                psOrder.executeUpdate();
            }

            // 2. Lưu vào bảng order_details (Duyệt qua danh sách CartItem trong Order)
            try (PreparedStatement psDetail = conn.prepareStatement(sqlDetail)) {
                for (CartItem item : order.getItems()) {
                    psDetail.setString(1, order.getId());
                    psDetail.setInt(2, item.getProduct().getId());
                    psDetail.setDouble(3, item.getProduct().getPrice());
                    psDetail.setInt(4, item.getQuantity());
                    psDetail.addBatch();
                }
                psDetail.executeBatch();
            }

            conn.commit(); // Hoàn tất lưu dữ liệu
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}