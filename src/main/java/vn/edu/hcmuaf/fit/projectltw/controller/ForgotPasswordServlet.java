package vn.edu.hcmuaf.fit.projectltw.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.projectltw.dao.UserDAO;
import java.io.IOException;

@WebServlet(name = "ForgotPasswordServlet", value = "/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO(); // Sử dụng UserDAO để xử lý dữ liệu

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");

        // Sử dụng UserDAO để kiểm tra email thay vì viết SQL trực tiếp ở đây
        if (userDAO.isEmailExists(email)) {
            // Nếu email tồn tại, gửi thông báo thành công (Giả lập gửi mail)
            request.setAttribute("message", "Hướng dẫn đặt lại mật khẩu đã được gửi vào email: " + email);
        } else {
            // Nếu không tìm thấy email trong hệ thống
            request.setAttribute("error", "Email này không tồn tại trên hệ thống!");
            request.setAttribute("oldEmail", email);
        }

        request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(request, response);
    }
}