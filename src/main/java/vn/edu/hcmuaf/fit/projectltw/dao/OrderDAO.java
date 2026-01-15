package vn.edu.hcmuaf.fit.projectltw.dao;

import vn.edu.hcmuaf.fit.projectltw.db.DBContext;
import vn.edu.hcmuaf.fit.projectltw.model.Cart;
import vn.edu.hcmuaf.fit.projectltw.model.CartItem;
import vn.edu.hcmuaf.fit.projectltw.model.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public String createOrder(Order order, Cart cart) {
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psDetail = null;
        String generatedId = null;

        try {
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false); // Bắt đầu Transaction

            // 1. Tự tạo ID dạng chuỗi (Ví dụ: ORD-1705324555)
            generatedId = "ORD-" + System.currentTimeMillis();
            order.setId(generatedId);

            // 2. INSERT vào bảng ORDERS (Không có cột note)
            String sqlOrder = "INSERT INTO orders (order_id, user_id, fullname, phone, address, total_money, status) VALUES (?, ?, ?, ?, ?, ?, ?)";

            psOrder = conn.prepareStatement(sqlOrder);
            psOrder.setString(1, order.getId());
            psOrder.setInt(2, order.getUserId());
            psOrder.setString(3, order.getFullName());
            psOrder.setString(4, order.getPhone());
            psOrder.setString(5, order.getAddress());
            psOrder.setDouble(6, order.getTotalMoney());
            psOrder.setInt(7, order.getStatus());

            psOrder.executeUpdate();

            // 3. INSERT vào bảng ORDER_DETAILS
            String sqlDetail = "INSERT INTO order_details (order_id, product_id, price, quantity) VALUES (?, ?, ?, ?)";
            psDetail = conn.prepareStatement(sqlDetail);

            for (CartItem item : cart.getItems().values()) {
                psDetail.setString(1, generatedId);     // Dùng ID chuỗi
                psDetail.setInt(2, item.getProduct().getId());
                psDetail.setDouble(3, item.getPrice()); // Nhớ thêm hàm getPrice vào CartItem như bài trước
                psDetail.setInt(4, item.getQuantity());
                psDetail.addBatch();
            }
            psDetail.executeBatch();

            conn.commit(); // Lưu thành công

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback(); // Lỗi thì hoàn tác
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return null;
        } finally {
            try { if(conn!=null) conn.close(); } catch(Exception e){}
        }
        return generatedId;
    }

    public List<Order> getOrders() {
        List<Order> list = new ArrayList<>();

        String query = "SELECT o.order_id, o.user_id, o.fullname, o.phone, o.address, o.total_money, o.status, o.created_at, " +
                "(SELECT SUM(quantity) FROM order_details WHERE order_id = o.order_id) AS total_qty, " +
                "(SELECT GROUP_CONCAT(CONCAT(p.name, ' (x', od.quantity, ')') SEPARATOR ', ') " +
                " FROM order_details od " +
                " JOIN products p ON od.product_id = p.id " +
                " WHERE od.order_id = o.order_id) AS list_names " +

                "FROM orders o " +
                "ORDER BY o.created_at DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setFullName(rs.getString("fullname"));
                order.setPhone(rs.getString("phone"));
                order.setAddress(rs.getString("address"));
                order.setTotalQuantity(rs.getInt("total_qty"));
                order.setTotalMoney(rs.getDouble("total_money"));
                order.setStatus(rs.getInt("status"));
                order.setDate(rs.getTimestamp("created_at"));

                String products = rs.getString("list_names");
                order.setListProductNames(products != null ? products : "Không có thông tin SP");

                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public double getRevenueCurrentMonth() {
        String sql = "SELECT SUM(total_money) FROM orders WHERE status = 3 AND MONTH(created_at) = MONTH(NOW()) AND YEAR(created_at) = YEAR(NOW())";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
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

    public void updateStatus(String orderId, int status) {
        String query = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, status);
            ps.setString(2, orderId);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}