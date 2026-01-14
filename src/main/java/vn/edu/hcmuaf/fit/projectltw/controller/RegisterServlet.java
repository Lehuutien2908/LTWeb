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

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Để hiển thị giao diện trang đăng ký
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Để nhận dữ liệu tiếng Việt từ form
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Để lấy dữ liệu từ các ô nhập liệu (đã bỏ phần phone)
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");

        // Để giữ lại dữ liệu cũ khi trang bị tải lại do lỗi
        request.setAttribute("oldFullname", fullname);
        request.setAttribute("oldEmail", email);

        // Để kiểm tra mật khẩu xác nhận có khớp không
        if (!pass.equals(confirmPass)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        // Để thực hiện lưu người dùng vào Database MySQL
        try (Connection conn = DBContext.getConnection()) {
            // Để chuẩn bị câu lệnh SQL (chỉ nạp 3 tham số: fullname, email, password)
            String sql = "INSERT INTO users (fullname, email, password) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, pass);

            // Để thực thi lệnh lưu dữ liệu
            int result = ps.executeUpdate();

            if (result > 0) {
                // Để chuyển hướng sang trang đăng nhập kèm thông báo thành công
                response.sendRedirect(request.getContextPath() + "/login?success=true");
            } else {
                request.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại!");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Để in lỗi ra console và báo lỗi nếu email đã tồn tại
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: Email này đã được sử dụng!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }
}