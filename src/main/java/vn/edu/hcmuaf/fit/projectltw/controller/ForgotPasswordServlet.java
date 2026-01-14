package vn.edu.hcmuaf.fit.projectltw.controller;

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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");

        // 1. Kiểm tra email có tồn tại trong database project_ltw không
        if (userDAO.isEmailExists(email)) {

            // 2. Tạo mật khẩu mới ngẫu nhiên (6 ký tự chữ và số)
            String newPassword = generateRandomPassword(6);

            // 3. Cập nhật mật khẩu mới này vào TiDB Cloud
            boolean isUpdated = userDAO.updatePassword(email, newPassword);

            if (isUpdated) {
                // 4. Gửi mật khẩu mới qua Email
                // Đảm bảo hàm trong EmailService của bạn đặt tên là sendPasswordEmail
                EmailService.sendPasswordEmail(email, "Khách hàng", newPassword);

                request.setAttribute("message", "Mật khẩu mới đã được gửi thành công vào email: " + email);
            } else {
                request.setAttribute("error", "Lỗi hệ thống: Không thể cập nhật mật khẩu lúc này!");
            }
        } else {
            // Trường hợp không tìm thấy email
            request.setAttribute("error", "Email này không tồn tại trên hệ thống!");
            request.setAttribute("oldEmail", email);
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