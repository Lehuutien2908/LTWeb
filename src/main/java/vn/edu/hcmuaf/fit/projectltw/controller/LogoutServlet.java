package vn.edu.hcmuaf.fit.projectltw.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", value = "/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Để truy cập vào phiên làm việc hiện tại
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Để xóa bỏ toàn bộ dữ liệu trong Session (bao gồm cả biến "user")
            session.invalidate();
        }

        // Để chuyển hướng người dùng về trang chủ sau khi thoát thành công
        response.sendRedirect(request.getContextPath() + "/home");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Để đồng bộ nếu người dùng gọi thoát bằng phương thức POST
        doGet(request, response);
    }
}