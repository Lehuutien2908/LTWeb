package vn.edu.hcmuaf.fit.projectltw.dao;

import vn.edu.hcmuaf.fit.projectltw.db.DBContext;
import vn.edu.hcmuaf.fit.projectltw.model.User;
import java.sql.*;

public class UserDAO {

    // 1. ĐĂNG NHẬP (Đã bổ sung lấy Phone và Address)
    public User checkLogin(String email, String pass) {
        // Nên lấy đầy đủ thông tin để lưu vào Session
        String sql = "SELECT id, fullname, email, phone, address, role FROM users WHERE email = ? AND password = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, pass); // Lưu ý: Nếu dùng MD5/BCrypt thì phải mã hóa pass trước khi so sánh
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));     // Bổ sung
                user.setAddress(rs.getString("address")); // Bổ sung
                user.setRole(rs.getInt("role"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 2. TÌM USER THEO ID (Dùng cho trang Profile để lấy dữ liệu mới nhất)
    // Phương thức này CẦN THIẾT cho ProfileController
    public User findById(int id) {
        String sql = "SELECT id, fullname, email, phone, address, role FROM users WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getInt("role"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 3. CẬP NHẬT THÔNG TIN CÁ NHÂN (Phone, Address, Fullname...)
    // Phương thức này CẦN THIẾT cho chức năng Lưu ở ProfileController
    public boolean updateProfile(int userId, String phone, String address) {
        String sql = "UPDATE users SET phone = ?, address = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phone);
            ps.setString(2, address);
            ps.setInt(3, userId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 4. KIỂM TRA EMAIL TỒN TẠI
    public boolean isEmailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 5. ĐĂNG KÝ USER MỚI
    public boolean registerUser(String fullname, String email, String pass) {
        String sql = "INSERT INTO users (fullname, email, password, role) VALUES (?, ?, ?, 0)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, pass);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 6. ĐỔI MẬT KHẨU
    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 7. THỐNG KÊ USER (Cho Admin)
    public int countTotalUsers() {
        String sql = "SELECT COUNT(*) FROM users WHERE role = 0";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}