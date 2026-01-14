package vn.edu.hcmuaf.fit.projectltw.controller;

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
            // Lấy ID và Số lượng từ Form
            String idStr = req.getParameter("id");
            String quantityStr = req.getParameter("quantity");

            if (idStr == null || quantityStr == null) {
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }

            int id = Integer.parseInt(idStr);
            int quantity = Integer.parseInt(quantityStr);

            // Gọi DAO
            ProductDAO dao = new ProductDAO();
            Product product = dao.getProductById(id);

            if (product != null) {
                HttpSession session = req.getSession();
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null) {
                    cart = new Cart();
                }
                cart.add(product, quantity);

                session.setAttribute("cart", cart);
                session.setAttribute("message", "Đã thêm sản phẩm vào giỏ hàng thành công!");
            }

            // --- XỬ LÝ CHUYỂN HƯỚNG DỰA TRÊN URL ---
            String path = req.getServletPath(); // Lấy đường dẫn hiện tại (/buy-now hoặc /add-to-cart)

            if (path.equals("/buy-now")) {
                // Nếu là Mua ngay
                resp.sendRedirect(req.getContextPath() + "/cart");
            } else {
                // Nếu là Thêm vào giỏ
                String referer = req.getHeader("referer");
                resp.sendRedirect(referer);
            }

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}