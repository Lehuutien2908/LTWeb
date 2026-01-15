package vn.edu.hcmuaf.fit.projectltw.controller.search;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.fit.projectltw.dao.ProductDAO;
import vn.edu.hcmuaf.fit.projectltw.model.Product;
import java.io.IOException;

@WebServlet(name = "ProductDetailController", value = "/product-detail")
public class ProductDetailController extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        try {
            int id = Integer.parseInt(idStr);
            Product p = productDAO.getProductById(id);

            if (p != null) {
                // Đặt là "product" để khớp với ${product.name} trong file bạn đã gửi
                request.setAttribute("product", p);
                request.getRequestDispatcher("/views/product/product-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
