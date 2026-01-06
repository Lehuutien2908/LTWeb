package vn.edu.hcmuaf.fit.projectltw.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Trả về giao diện đăng ký khi người dùng truy cập link
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String pass = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");

        // Logic kiểm tra cơ bản
        if (fullname == null || fullname.trim().isEmpty()) {
            request.setAttribute("error", "Họ tên không được để trống!");
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        if (!pass.equals(confirmPass)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            // Giữ lại các giá trị cũ đã nhập (trừ mật khẩu) để người dùng không phải nhập lại
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        // GIẢ LẬP: Lưu người dùng thành công (Chờ Database từ đồng nghiệp)
        System.out.println("Đăng ký thành công: " + email);

        // Chuyển hướng sang trang Login với tham số báo hiệu thành công
        response.sendRedirect(request.getContextPath() + "/login?success=true");
    }
}