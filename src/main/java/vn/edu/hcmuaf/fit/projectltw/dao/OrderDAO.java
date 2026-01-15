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
        PreparedStatement psUpdateStock = null;
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
            String sqlUpdateStock = "UPDATE products SET stock = stock - ? WHERE id = ?";
            psDetail = conn.prepareStatement(sqlDetail);
            psUpdateStock = conn.prepareStatement(sqlUpdateStock);

            for (CartItem item : cart.getItems().values()) {
                psDetail.setString(1, generatedId);     // Dùng ID chuỗi
                psDetail.setInt(2, item.getProduct().getId());
                psDetail.setDouble(3, item.getPrice()); // Nhớ thêm hàm getPrice vào CartItem như bài trước
                psDetail.setInt(4, item.getQuantity());
                psDetail.addBatch();

                psUpdateStock.setInt(1, item.getQuantity());
                psUpdateStock.setInt(2, item.getProduct().getId());
                psUpdateStock.addBatch();
            }
            psDetail.executeBatch();
            psUpdateStock.executeBatch();

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
            try {
                if (psDetail != null) psDetail.close();
            } catch (Exception e) {
            }
            try {
                if (psOrder != null) psOrder.close();
            } catch (Exception e) {
            }
            try {
                if (psUpdateStock != null) psUpdateStock.close();
            } catch (Exception e) {
            }
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
            }
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
        String sql = "SELECT SUM(total_money) FROM orders WHERE status = 2 AND MONTH(created_at) = MONTH(NOW()) AND YEAR(created_at) = YEAR(NOW())";

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

    public void updateStatus(String orderId, int newStatus) {
        Connection conn = null;
        PreparedStatement psGetCurrentStatus = null;
        PreparedStatement psGetDetails = null;
        PreparedStatement psUpdateStock = null;
        PreparedStatement psUpdateStatus = null;
        ResultSet rs = null;
        ResultSet rsDetails = null;

        try {
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false);

            String sqlGetCurrentStatus = "SELECT status FROM orders WHERE order_id = ?";
            psGetCurrentStatus = conn.prepareStatement(sqlGetCurrentStatus);
            psGetCurrentStatus.setString(1, orderId);
            rs = psGetCurrentStatus.executeQuery();

            int currentStatus = -1;
            if (rs.next()) {
                currentStatus = rs.getInt("status");
            }

            // Biến này để quyết định cộng hay trừ: 1 là cộng, -1 là trừ, 0 là không làm gì
            int operation = 0;

            // Case 1: Đang bình thường -> Chuyển sang HỦY (3) => CỘNG KHO (Trả hàng)
            if (currentStatus != 3 && newStatus == 3) {
                operation = 1;
            }
            // Case 2: Đang hủy (status = 3) -> Chuyển sang KHÁC => TRỪ KHO (Lấy lại hàng để bán)
            else if (currentStatus == 3 && newStatus != 3) {
                operation = -1;
            }

            if (operation != 0) {
                String sqlGetDetails = "SELECT product_id, quantity FROM order_details WHERE order_id = ?";
                psGetDetails = conn.prepareStatement(sqlGetDetails);
                psGetDetails.setString(1, orderId);
                rsDetails = psGetDetails.executeQuery();

                String sqlUpdateStock = "UPDATE products SET stock = stock + ? WHERE id = ?";
                psUpdateStock = conn.prepareStatement(sqlUpdateStock);

                while (rsDetails.next()) {
                    int productId = rsDetails.getInt("product_id");
                    int quantity = rsDetails.getInt("quantity");

                    int changeAmount = quantity * operation;

                    psUpdateStock.setInt(1, changeAmount);
                    psUpdateStock.setInt(2, productId);
                    psUpdateStock.addBatch();
                }
                psUpdateStock.executeBatch();
            }

            String sqlUpdateStatus = "UPDATE orders SET status = ? WHERE order_id = ?";
            psUpdateStatus = conn.prepareStatement(sqlUpdateStatus);
            psUpdateStatus.setInt(1, newStatus);
            psUpdateStatus.setString(2, orderId);
            psUpdateStatus.executeUpdate();

            conn.commit();

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (rs != null) rs.close();
            } catch (Exception e) {
            }
            try {
                if (rsDetails != null) rsDetails.close();
            } catch (Exception e) {
            }
            try {
                if (psGetCurrentStatus != null) psGetCurrentStatus.close();
            } catch (Exception e) {
            }
            try {
                if (psGetDetails != null) psGetDetails.close();
            } catch (Exception e) {
            }
            try {
                if (psUpdateStock != null) psUpdateStock.close();
            } catch (Exception e) {
            }
            try {
                if (psUpdateStatus != null) psUpdateStatus.close();
            } catch (Exception e) {
            }
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
            }
        }
    }

    public List<Order> searchOrders(String keyword) {
        List<Order> list = new ArrayList<>();

        String query = "SELECT o.order_id, o.user_id, o.fullname, o.phone, o.address, o.total_money, o.status, o.created_at, " +
                "(SELECT SUM(quantity) FROM order_details WHERE order_id = o.order_id) AS total_qty, " +
                "(SELECT GROUP_CONCAT(CONCAT(p.name, ' (x', od.quantity, ')') SEPARATOR ', ') " +
                " FROM order_details od " +
                " JOIN products p ON od.product_id = p.id " +
                " WHERE od.order_id = o.order_id) AS list_names " +
                "FROM orders o " +
                "WHERE o.order_id LIKE ? OR o.fullname LIKE ? " +
                "ORDER BY o.created_at DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);

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
}