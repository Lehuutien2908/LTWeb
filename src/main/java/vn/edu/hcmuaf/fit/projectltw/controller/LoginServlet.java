package vn.edu.hcmuaf.fit.projectltw.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.projectltw.db.DBContext;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Để hiển thị giao diện trang đăng nhập
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Để xử lý tiếng Việt cho dữ liệu từ form
        request.setCharacterEncoding("UTF-8");

        // Để lấy dữ liệu email và password từ JSP (name="email")
        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        // Để thực hiện kết nối và truy vấn Database
        try (Connection conn = DBContext.getConnection()) {
            // Để kiểm tra tài khoản có tồn tại và đúng mật khẩu không
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Để lưu tên người dùng vào Session khi thành công
                HttpSession session = request.getSession();
                session.setAttribute("user", rs.getString("fullname"));

                // Để chuyển hướng về trang chủ
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                // Để giữ lại email cũ và báo lỗi nếu thông tin sai
                request.setAttribute("oldEmail", email);
                request.setAttribute("error", "Email hoặc mật khẩu không chính xác!");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Để xem lỗi cụ thể trong console IntelliJ
            e.printStackTrace();
        }
    }
}