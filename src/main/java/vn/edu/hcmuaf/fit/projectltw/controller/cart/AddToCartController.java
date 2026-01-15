package vn.edu.hcmuaf.fit.projectltw.controller.cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.projectltw.dao.ProductDAO;
import vn.edu.hcmuaf.fit.projectltw.model.Cart;
import vn.edu.hcmuaf.fit.projectltw.model.Product;
import java.io.IOException;

// 1. KHAI BÁO 2 ĐƯỜNG DẪN Ở ĐÂY
@WebServlet(name = "AddToCartController", urlPatterns = {"/buy-now", "/add-to-cart"})
public class AddToCartController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. Lấy tham số từ form
            String idStr = req.getParameter("id");
            String quantityStr = req.getParameter("quantity");
            String action = req.getParameter("action");

            if (idStr == null || quantityStr == null) {
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }

            int id = Integer.parseInt(idStr);
            int quantity = Integer.parseInt(quantityStr);

            ProductDAO dao = new ProductDAO();
            Product product = dao.getProductById(id);

            if (product != null) {
                HttpSession session = req.getSession();
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null) {
                    cart = new Cart();
                }
                if ("update".equals(action)) {
                    cart.update(id, quantity);
                } else {
                    cart.add(product, quantity);
                }

                session.setAttribute("cart", cart);

                if (!"update".equals(action)) {
                    session.setAttribute("message", "Đã thêm sản phẩm vào giỏ hàng thành công!");
                }
            }

            String path = req.getServletPath();


            if (path.equals("/buy-now") || "update".equals(action)) {

                resp.sendRedirect(req.getContextPath() + "/views/product/cart.jsp");
            } else {

                String referer = req.getHeader("referer");
                resp.sendRedirect(referer);
            }

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}