package vn.edu.hcmuaf.fit.projectltw.controller;

import vn.edu.hcmuaf.fit.projectltw.model.Cart;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "RemoveCartController", value = "/remove-cart")
public class RemoveCartController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Lấy ID sản phẩm cần xóa
        String idStr = req.getParameter("pid");

        if (idStr != null) {
            int id = Integer.parseInt(idStr);

            // 2. Lấy giỏ hàng từ Session
            HttpSession session = req.getSession();
            Cart cart = (Cart) session.getAttribute("cart");

            // 3. Nếu có giỏ hàng thì xóa sản phẩm đó đi
            if (cart != null) {
                cart.remove(id); // Giả sử model Cart của cậu có hàm remove(int id)

                // Cập nhật lại session
                session.setAttribute("cart", cart);
            }
        }

        // 4. Quay lại trang giỏ hàng
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}