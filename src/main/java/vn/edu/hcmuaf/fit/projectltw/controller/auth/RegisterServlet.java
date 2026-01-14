package vn.edu.hcmuaf.fit.projectltw.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.fit.projectltw.dao.UserDAO;
import vn.edu.hcmuaf.fit.projectltw.service.EmailService; // Service gửi mail
import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");

        // Giữ lại dữ liệu cũ để người dùng không phải nhập lại nếu có lỗi
        request.setAttribute("oldFullname", fullname);
        request.setAttribute("oldEmail", email);

        // BƯỚC 1: Kiểm tra email đã tồn tại trong hệ thống chưa
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email này đã được sử dụng!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        // BƯỚC 2: Tự động tạo mật khẩu ngẫu nhiên 8 số thông qua DAO
        String autoPassword = userDAO.generateRandomPassword();

        // BƯỚC 3: Lưu thông tin người dùng kèm mật khẩu tự sinh vào Database
        boolean success = userDAO.registerUser(fullname, email, autoPassword);

        if (success) {
            // BƯỚC 4: Gửi email thật chứa mật khẩu cho người dùng
            // Sử dụng Thread để việc gửi mail không làm đứng trang web của người dùng
            new Thread(() -> {
                EmailService.sendPasswordEmail(email, fullname, autoPassword);
            }).start();

            // Chuyển hướng về trang Login kèm thông báo kiểm tra hòm thư
            response.sendRedirect(request.getContextPath() + "/login?registerSuccess=true&checkEmail=true");
        } else {
            request.setAttribute("error", "Hệ thống đang bận, vui lòng đăng ký lại sau!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }
}