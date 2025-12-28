package vn.edu.hcmuaf.fit.projectltw.controller;

/* CÁC DÒNG IMPORT DƯỚI ĐÂY SẼ XÓA LỖI "CANNOT RESOLVE" */
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lỗi getRequestDispatcher sẽ hết khi có import HttpServletRequest
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lỗi getParameter sẽ hết khi bạn import đúng HttpServletRequest
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // Logic kiểm tra đăng nhập
        if ("admin".equals(user) && "123".equals(pass)) {
            // Lỗi getSession yêu cầu import jakarta.servlet.http.HttpSession
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Lỗi sendRedirect và getContextPath yêu cầu HttpServletResponse
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
}