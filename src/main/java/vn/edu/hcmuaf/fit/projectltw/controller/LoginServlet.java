package vn.edu.hcmuaf.fit.projectltw.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.fit.projectltw.dao.UserDAO;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO(); // Gọi DAO để xử lý dữ liệu

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        // Sử dụng DAO để kiểm tra
        String fullName = userDAO.checkLogin(email, pass);

        if (fullName != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", fullName);
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("oldEmail", email);
            request.setAttribute("error", "Email hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
}