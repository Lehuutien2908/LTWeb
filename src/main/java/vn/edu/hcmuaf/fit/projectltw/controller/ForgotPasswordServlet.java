package vn.edu.hcmuaf.fit.projectltw.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.projectltw.db.DBContext;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "ForgotPasswordServlet", value = "/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // hiển thị giao diện trang quên mật khẩu
        request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // xử lý dữ liệu tiếng Việt và định dạng HTML
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Đlấy email người dùng nhập vào
        String email = request.getParameter("email");

        // thực hiện kiểm tra email trong database MySQL
        try (Connection conn = DBContext.getConnection()) {
            // Để tìm kiếm email có tồn tại trong bảng users không
            String sql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // thông báo giả lập việc gửi link khôi phục mật khẩu
                request.setAttribute("message", "Hướng dẫn đặt lại mật khẩu đã được gửi vào email của bạn!");
            } else {
                // báo lỗi khi email không tồn tại trên hệ thống
                request.setAttribute("error", "Email này không tồn tại trên hệ thống!");
            }
        } catch (Exception e) {
            // in lỗi ra console khi kết nối database thất bại
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống, vui lòng thử lại sau!");
        }

        // quay lại trang cũ hiển thị thông báo kết quả
        request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
    }
}