package vn.edu.hcmuaf.fit.projectltw.controller.cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.projectltw.dao.OrderDAO;
import vn.edu.hcmuaf.fit.projectltw.model.Cart;
import vn.edu.hcmuaf.fit.projectltw.model.Order;
import vn.edu.hcmuaf.fit.projectltw.model.User;

import java.io.IOException;

@WebServlet(name = "CheckoutController", value = "/checkout")
public class CheckoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        if (session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
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
        req.setCharacterEncoding("UTF-8");

        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null && cart.getTotalMoney() > 0) {

            Order newOrder = new Order();
            newOrder.setUserId(user.getId());
            newOrder.setFullName(fullname);
            newOrder.setPhone(phone);
            newOrder.setAddress(address);
            newOrder.setTotalMoney(cart.getTotalMoney());
            newOrder.setStatus(0);

            OrderDAO dao = new OrderDAO();
            try {
                String orderId = dao.createOrder(newOrder, cart);

                if (orderId != null) {

                    newOrder.setId(orderId);

                    req.setAttribute("order", newOrder);

                    req.setAttribute("orderItems", cart.getItems().values());

                    session.removeAttribute("cart");

                    req.setAttribute("message", "Đặt hàng thành công!");
                    req.getRequestDispatcher("/views/product/order-success.jsp").forward(req, resp);

                }
                // --------------------------------

                else {
                    req.setAttribute("error", "Có lỗi xảy ra khi lưu đơn hàng.");
                    req.getRequestDispatcher("/views/product/checkout.jsp").forward(req, resp);
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
                req.getRequestDispatcher("/views/product/checkout.jsp").forward(req, resp);
            }

        } else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}