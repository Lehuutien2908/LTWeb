package vn.edu.hcmuaf.fit.projectltw.controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.fit.projectltw.model.User;
import vn.edu.hcmuaf.fit.projectltw.model.Order; // Import model Order
import vn.edu.hcmuaf.fit.projectltw.dao.UserDAO; // Import UserDAO
import vn.edu.hcmuaf.fit.projectltw.dao.OrderDAO; // Import OrderDAO

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProfileController", value = "/profile")
public class ProfileController extends HttpServlet {

    // Khởi tạo các DAO
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

        // 2. Lấy thông tin User mới nhất từ DB (để đảm bảo Số điện thoại là mới nhất)
        // Giả sử UserDAO có hàm getUserById
        User currentUser = userDAO.getUserById(sessionUser.getId());

        // Cập nhật lại user vào session nếu cần thiết (để đồng bộ)
        if (currentUser != null) {
            session.setAttribute("user", currentUser);
        } else {
            currentUser = sessionUser; // Fallback nếu lỗi DB
        }

        // 3. Lấy Lịch sử mua hàng từ DB
        List<Order> purchaseHistory = orderDAO.getOrdersByUserId(currentUser.getId());

        // 4. Đẩy dữ liệu sang file JSP
        request.setAttribute("purchaseHistory", purchaseHistory);
        // User đã có trong session, nhưng có thể set lại attribute nếu muốn rõ ràng
        request.setAttribute("userInfo", currentUser);

        request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
    }

    // --- BỔ SUNG: Nếu bạn muốn chức năng CẬP NHẬT số điện thoại (Lưu vào DB) ---
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            String newPhone = request.getParameter("phone");

            // Gọi DAO để update số điện thoại
            boolean isUpdated = userDAO.updatePhone(user.getId(), newPhone);

            if (isUpdated) {
                // Cập nhật lại session
                user.setPhone(newPhone);
                session.setAttribute("user", user);
                request.setAttribute("message", "Cập nhật thành công!");
            } else {
                request.setAttribute("error", "Cập nhật thất bại!");
            }
        }
        // Load lại trang profile để hiển thị
        doGet(request, response);
    }
}