package vn.edu.hcmuaf.fit.projectltw.controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.fit.projectltw.model.User;
import vn.edu.hcmuaf.fit.projectltw.model.Order;
import vn.edu.hcmuaf.fit.projectltw.dao.UserDAO;
import vn.edu.hcmuaf.fit.projectltw.dao.OrderDAO;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProfileController", value = "/profile")
public class ProfileController extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User sessionUser = (User) session.getAttribute("user");

        // 1. Kiểm tra đăng nhập
        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Lấy thông tin User mới nhất từ DB
        // SỬA: Dùng đúng tên hàm findById trong UserDAO
        User currentUser = userDAO.findById(sessionUser.getId());

        // Fallback nếu lỗi DB
        if (currentUser == null) {
            currentUser = sessionUser;
        } else {
            // Cập nhật lại session để đồng bộ dữ liệu mới nhất
            session.setAttribute("user", currentUser);
        }

        // 3. Lấy Lịch sử mua hàng
        List<Order> purchaseHistory = orderDAO.getOrdersByUserId(currentUser.getId());

        // 4. Đẩy dữ liệu sang JSP
        request.setAttribute("orderHistory", purchaseHistory);

        request.setAttribute("user", currentUser);

        request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            String newPhone = request.getParameter("phone");
            String newAddress = request.getParameter("address");

            // SỬA: Gọi hàm updateProfile (nhận 3 tham số) thay vì updatePhone
            boolean isUpdated = userDAO.updateProfile(user.getId(), newPhone, newAddress);

            if (isUpdated) {
                user.setPhone(newPhone);
                user.setAddress(newAddress);
                session.setAttribute("user", user);

                request.setAttribute("message", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("error", "Cập nhật thất bại! Vui lòng thử lại.");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Load lại trang profile để hiển thị thông báo và dữ liệu mới
        doGet(request, response);
    }
}