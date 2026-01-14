package vn.edu.hcmuaf.fit.projectltw.dao;

import vn.edu.hcmuaf.fit.projectltw.db.DBContext;
import java.sql.*;

public class UserDAO {
    // Hàm kiểm tra đăng nhập và trả về họ tên người dùng
    public String checkLogin(String email, String pass) {
        String sql = "SELECT fullname FROM users WHERE email = ? AND password = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("fullname"); // Trả về tên để lưu vào Session
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //  Hàm kiểm tra Email đã tồn tại chưa
    public boolean isEmailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // Trả về true nếu tìm thấy email
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    //  Hàm thực hiện đăng ký người dùng mới
    public boolean registerUser(String fullname, String email, String pass) {
        String sql = "INSERT INTO users (fullname, email, password) VALUES (?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, pass);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public String generateRandomPassword() {
        String digits = "0123456789";
        StringBuilder sb = new StringBuilder();
        java.util.Random rd = new java.util.Random();
        for (int i = 0; i < 8; i++) {
            sb.append(digits.charAt(rd.nextInt(digits.length())));
        }
        return sb.toString();
    }

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
}
