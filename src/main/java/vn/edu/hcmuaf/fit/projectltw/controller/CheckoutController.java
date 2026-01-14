package vn.edu.hcmuaf.fit.projectltw.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.projectltw.dao.OrderDAO;
import vn.edu.hcmuaf.fit.projectltw.model.Cart;
import vn.edu.hcmuaf.fit.projectltw.model.CartItem;
import vn.edu.hcmuaf.fit.projectltw.model.Order;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "CheckoutController", value = "/checkout")
public class CheckoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getTotalMoney() == 0) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        req.getRequestDispatcher("/WEB-INF/views/product/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Lấy thông tin form
        req.setCharacterEncoding("UTF-8"); // Để không lỗi font tiếng Việt
        String name = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String note = req.getParameter("note");

        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null && cart.getTotalMoney() > 0) {

            // 2. Tạo ID ngẫu nhiên cho đơn hàng
            String orderId = "ORD-" + System.currentTimeMillis();

            // 3. Tạo đối tượng Order
            List<CartItem> orderDetails = new ArrayList<>(cart.getItems().values());

            Order newOrder = new Order(orderId, name, phone, address, note, cart.getTotalMoney(), orderDetails);

            // 4. LƯU VÀO DAO
            OrderDAO dao = new OrderDAO();
            dao.saveOrder(newOrder);

            // 5. IN RA CONSOLE ĐỂ KIỂM TRA
            System.out.println("=== ĐƠN HÀNG MỚI ===");
            System.out.println("Mã đơn: " + newOrder.getId());
            System.out.println("Khách: " + newOrder.getFullName());
            System.out.println("Tổng tiền: " + newOrder.getTotalMoney());
            System.out.println("Số lượng đơn trong hệ thống: " + dao.getAllOrders().size());
            System.out.println("====================");

            // 6. Xóa giỏ hàng và thông báo
            session.removeAttribute("cart");
            session.setAttribute("message", "Đặt hàng thành công! Mã đơn: " + orderId);

            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            resp.sendRedirect("cart");
        }
    }
}