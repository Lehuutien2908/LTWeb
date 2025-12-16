package vn.edu.hcmuaf.fit.projectltw.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/register", "/forgot-password"})
public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L; // Cần giữ lại

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath(); // Phương thức này sẽ hoạt động sau khi có Servlet API
        String view = "";

        if (path.equals("/login")) {
            view = "/WEB-INF/views/auth/login.jsp";
        } else if (path.equals("/register")) {
            view = "/WEB-INF/views/auth/register.jsp";
        } else if (path.equals("/forgot-password")) {
            view = "/WEB-INF/views/auth/forgot_password.jsp";
        }

        if (!view.isEmpty()) {
            request.getRequestDispatcher(view).forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}