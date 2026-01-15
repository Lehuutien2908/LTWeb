package vn.edu.hcmuaf.fit.projectltw.controller.cart;

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

@WebServlet(name = "CheckoutController", value = "/checkout")
public class CheckoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // KIỂM TRA 1: Chặn xem trang checkout nếu chưa đăng nhập
        if (session.getAttribute("user") == null) {
            req.setAttribute("error", "Bạn vui lòng đăng nhập để tiến hành thanh toán!");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getTotalMoney() == 0) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        req.getRequestDispatcher("/views/product/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        // KIỂM TRA 2: Chặn thực thi đơn hàng nếu chưa đăng nhập (Cửa hậu)
        if (session.getAttribute("user") == null) {
            req.setAttribute("error", "Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại!");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String note = req.getParameter("note");

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null && cart.getTotalMoney() > 0) {
            String orderId = "ORD-" + System.currentTimeMillis();
            List<CartItem> orderDetails = new ArrayList<>(cart.getItems().values());
            Order newOrder = new Order(orderId, name, phone, address, note, cart.getTotalMoney(), orderDetails);

            // Lưu đơn hàng vào Database
            OrderDAO dao = new OrderDAO();
            dao.saveOrder(newOrder);

            // Xóa giỏ và thông báo
            session.removeAttribute("cart");
            session.setAttribute("message", "Đặt hàng thành công! Mã đơn của bạn là: " + orderId);

            req.setAttribute("order", newOrder);
            req.getRequestDispatcher("/views/product/order-success.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}