package vn.edu.hcmuaf.fit.projectltw.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.fit.projectltw.dao.UserDAO;
import vn.edu.hcmuaf.fit.projectltw.service.EmailService;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        request.setAttribute("oldFullname", fullname);
        request.setAttribute("oldEmail", email);

        if (password == null || password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp !");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email này đã được sử dụng !");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        boolean success = userDAO.registerUser(fullname, email, password);

        if (success) {
            new Thread(() -> {
                EmailService.sendWelcomeEmail(email, fullname);
            }).start();

            response.sendRedirect(request.getContextPath() + "/login?success=true");
        } else {
            request.setAttribute("error", "Hệ thống đang bận, vui lòng đăng ký lại sau!");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
        }
    }
}