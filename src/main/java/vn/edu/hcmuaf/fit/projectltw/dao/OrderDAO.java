package vn.edu.hcmuaf.fit.projectltw.dao;

import vn.edu.hcmuaf.fit.projectltw.db.DBContext;
import vn.edu.hcmuaf.fit.projectltw.model.CartItem;
import vn.edu.hcmuaf.fit.projectltw.model.Order;
import java.sql.*;

public class OrderDAO {

    public void saveOrder(Order order) {
        String sqlOrder = "INSERT INTO orders (order_id, fullname, phone, address, note, total_money) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlDetail = "INSERT INTO order_details (order_id, product_id, price, quantity) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false); // Bắt đầu giao dịch (Transaction)

            // 1. Lưu thông tin chung của đơn hàng vào bảng 'orders'
            try (PreparedStatement psOrder = conn.prepareStatement(sqlOrder)) {
                psOrder.setString(1, order.getId());
                psOrder.setString(2, order.getFullName());
                psOrder.setString(3, order.getPhone());
                psOrder.setString(4, order.getAddress());
                psOrder.setString(5, order.getNote());
                psOrder.setDouble(6, order.getTotalMoney());
                psOrder.executeUpdate();
            }

            // 2. Lưu chi tiết từng sản phẩm vào bảng 'order_details' dùng Batch
            try (PreparedStatement psDetail = conn.prepareStatement(sqlDetail)) {
                for (CartItem item : order.getItems()) {
                    psDetail.setString(1, order.getId());
                    psDetail.setInt(2, item.getProduct().getId());
                    psDetail.setDouble(3, item.getProduct().getPrice());
                    psDetail.setInt(4, item.getQuantity());
                    psDetail.addBatch(); // Gom nhóm các câu lệnh
                }
                psDetail.executeBatch(); // Thực thi một lần duy nhất
            }

            conn.commit(); // Xác nhận lưu mọi thứ vào database
            System.out.println("Lưu đơn hàng " + order.getId() + " thành công!");

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Hủy bỏ nếu có bất kỳ lỗi nào xảy ra
                    System.out.println("Lỗi! Đã Rollback dữ liệu đơn hàng.");
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close(); // Đảm bảo đóng kết nối để giải phóng tài nguyên
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_money) FROM orders";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getDouble(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countNewOrders() {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = 0";
        try (Connection conn = DBContext.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}