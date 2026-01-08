package vn.edu.hcmuaf.fit.projectltw.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ForgotPasswordServlet", value = "/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Thiết lập tiếng Việt cho phản hồi
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // QUAN TRỌNG: Thiết lập tiếng Việt để đọc dữ liệu từ Form không bị lỗi
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email"); //

        // Logic giả lập khi chưa có database
        if (email != null && email.endsWith("@gmail.com")) {
            request.setAttribute("message", "Hướng dẫn đặt lại mật khẩu đã được gửi vào email của bạn!");
        } else {
            request.setAttribute("error", "Email này không tồn tại trên hệ thống!");
        }

        request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
    }
}