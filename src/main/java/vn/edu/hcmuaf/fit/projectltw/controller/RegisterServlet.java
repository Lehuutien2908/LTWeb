package vn.edu.hcmuaf.fit.projectltw.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.fit.projectltw.dao.UserDAO;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO(); // Gọi DAO để xử lý dữ liệu

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Đảm bảo không lỗi font tiếng Việt

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");

        // Giữ lại dữ liệu cũ để người dùng không phải nhập lại
        request.setAttribute("oldFullname", fullname);
        request.setAttribute("oldEmail", email);

        // BƯỚC 1: Kiểm tra mật khẩu xác nhận
        if (!pass.equals(confirmPass)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        // BƯỚC 2: Kiểm tra email đã tồn tại chưa
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email này đã được sử dụng!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        // BƯỚC 3: Thực hiện đăng ký thông qua DAO
        boolean success = userDAO.registerUser(fullname, email, pass);

        if (success) {
            // Đăng ký thành công, chuyển hướng về Login kèm thông báo
            response.sendRedirect(request.getContextPath() + "/login?registerSuccess=true");
        } else {
            request.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }
}