package vn.edu.hcmuaf.fit.projectltw.controller.product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.projectltw.dao.ProductDAO;
import vn.edu.hcmuaf.fit.projectltw.model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductController", value = "/products")
public class ProductController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();

        // 1. Lấy tham số category từ URL
        String category = req.getParameter("category");
        List<Product> list;

        // 2. Kiểm tra lọc
        if (category == null || category.isEmpty() || category.equals("all")) {
            list = dao.getAllProducts(); // Không chọn gì thì lấy hết
            req.setAttribute("currentCategory", "Tất cả sản phẩm");
        } else {
            list = dao.getProductsByCategory(category); // Có chọn thì lọc
            req.setAttribute("currentCategory", category);
        }

        // 3. Đẩy dữ liệu sang JSP
        req.setAttribute("productList", list);
        req.setAttribute("activeCategory", category);

        req.getRequestDispatcher("/views/product/product-list.jsp").forward(req, resp);
    }
}