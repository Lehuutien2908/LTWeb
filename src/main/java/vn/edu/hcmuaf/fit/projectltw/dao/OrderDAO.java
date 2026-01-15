package vn.edu.hcmuaf.fit.projectltw.dao;

import vn.edu.hcmuaf.fit.projectltw.db.DBContext;
import vn.edu.hcmuaf.fit.projectltw.model.Cart;
import vn.edu.hcmuaf.fit.projectltw.model.CartItem;
import vn.edu.hcmuaf.fit.projectltw.model.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // --- 1. TẠO ĐƠN HÀNG (Có Transaction) ---
    public String createOrder(Order order, Cart cart) {
        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psDetail = null;
        String generatedId = null;

        try {
            // Đảm bảo DBContext có phương thức static getConnection()
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            // Tạo ID dạng chuỗi (Ví dụ: ORD-1705324555)
            generatedId = "ORD-" + System.currentTimeMillis();
            order.setId(generatedId);

            // INSERT vào bảng ORDERS
            String sqlOrder = "INSERT INTO orders (order_id, user_id, fullname, phone, address, total_money, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";

            psOrder = conn.prepareStatement(sqlOrder);
            psOrder.setString(1, order.getId());
            psOrder.setInt(2, order.getUserId());
            psOrder.setString(3, order.getFullName());
            psOrder.setString(4, order.getPhone());
            psOrder.setString(5, order.getAddress());
            psOrder.setDouble(6, order.getTotalMoney());
            psOrder.setInt(7, order.getStatus()); // Thường mặc định là 0 (Chờ xử lý)

            psOrder.executeUpdate();

            // INSERT vào bảng ORDER_DETAILS
            String sqlDetail = "INSERT INTO order_details (order_id, product_id, price, quantity) VALUES (?, ?, ?, ?)";
            psDetail = conn.prepareStatement(sqlDetail);

            for (CartItem item : cart.getItems().values()) {
                psDetail.setString(1, generatedId);
                psDetail.setInt(2, item.getProduct().getId());
                psDetail.setDouble(3, item.getPrice());
                psDetail.setInt(4, item.getQuantity());
                psDetail.addBatch(); // Thêm vào lô xử lý
            }
            psDetail.executeBatch();

            conn.commit(); // Lưu thành công tất cả

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return null; // Trả về null báo hiệu thất bại
        } finally {
            // Đóng kết nối thủ công vì không dùng try-with-resources ở trên
            try { if(psOrder != null) psOrder.close(); } catch(Exception e){}
            try { if(psDetail != null) psDetail.close(); } catch(Exception e){}
            try { if(conn != null) conn.close(); } catch(Exception e){}
        }
        return generatedId;
    }

    // --- 2. LẤY TẤT CẢ ĐƠN HÀNG (Dành cho Admin) ---
    public List<Order> getOrders() {
        return executeGetOrdersQuery("SELECT o.*, " +
                "(SELECT SUM(quantity) FROM order_details WHERE order_id = o.order_id) AS total_qty, " +
                "(SELECT GROUP_CONCAT(CONCAT(p.name, ' (x', od.quantity, ')') SEPARATOR ', ') " +
                " FROM order_details od JOIN products p ON od.product_id = p.id " +
                " WHERE od.order_id = o.order_id) AS list_names " +
                "FROM orders o ORDER BY o.created_at DESC", null);
    }

    // --- 3. LẤY ĐƠN HÀNG THEO USER ID
    public List<Order> getOrdersByUserId(int userId) {
        String sql = "SELECT o.*, " +
                "(SELECT SUM(quantity) FROM order_details WHERE order_id = o.order_id) AS total_qty, " +
                "(SELECT GROUP_CONCAT(CONCAT(p.name, ' (x', od.quantity, ')') SEPARATOR ', ') " +
                " FROM order_details od JOIN products p ON od.product_id = p.id " +
                " WHERE od.order_id = o.order_id) AS list_names " +
                "FROM orders o " +
                "WHERE o.user_id = ? " +  // Lọc theo User ID
                "ORDER BY o.created_at DESC";

        return executeGetOrdersQuery(sql, userId);
    }

    // Hàm phụ trợ để tránh lặp code khi lấy danh sách đơn hàng
    private List<Order> executeGetOrdersQuery(String query, Integer userIdParam) {
        List<Order> list = new ArrayList<>();
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            if (userIdParam != null) {
                ps.setInt(1, userIdParam);
            }

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
                order.setListProductNames(products != null ? products : "");

                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // --- 4. THỐNG KÊ DOANH THU THÁNG HIỆN TẠI ---
    public double getRevenueCurrentMonth() {
        // Giả sử status = 3 là Giao thành công
        String sql = "SELECT SUM(total_money) FROM orders WHERE status = 3 AND MONTH(created_at) = MONTH(NOW()) AND YEAR(created_at) = YEAR(NOW())";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // --- 5. ĐẾM ĐƠN HÀNG MỚI ---
    public int countNewOrders() {
        // Giả sử status = 0 là Chờ xử lý
        String sql = "SELECT COUNT(*) FROM orders WHERE status = 0";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // --- 6. CẬP NHẬT TRẠNG THÁI ---
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