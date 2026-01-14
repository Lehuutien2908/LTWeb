package vn.edu.hcmuaf.fit.projectltw.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.projectltw.dao.UserDAO;
import vn.edu.hcmuaf.fit.projectltw.service.EmailService; // Đảm bảo đã import đúng

import java.io.IOException;
import java.util.Random;

@WebServlet(name = "ForgotPasswordServlet", value = "/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển hướng người dùng đến trang nhập email
        request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        if (userDAO.isEmailExists(email)) {
            // 1. Tạo mật khẩu mới
            String newPassword = java.util.UUID.randomUUID().toString().substring(0, 8);

            // 2. Cập nhật vào Database Cloud
            if (userDAO.updatePassword(email, newPassword)) {
                // 3. Gửi mail bảo mật qua file properties
                EmailService.sendPasswordEmail(email, "Khách hàng", newPassword);
                request.setAttribute("message", "Thành công! Kiểm tra email để nhận mật khẩu mới.");
            } else {
                request.setAttribute("error", "Lỗi hệ thống khi cập nhật mật khẩu.");
            }
        } else {
            request.setAttribute("error", "Email không tồn tại trong hệ thống.");
        }
        request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
    }

    // Hàm phụ trợ tạo mật khẩu ngẫu nhiên
    private String generateRandomPassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }
}