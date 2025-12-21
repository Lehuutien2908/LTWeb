package vn.edu.hcmuaf.fit.projectltw.controller;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.projectltw.dao.ProductDAO;
import vn.edu.hcmuaf.fit.projectltw.model.Product;

@WebServlet(name = "HomeServlet", value = "/home")
public class HomeServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Lấy dữ liệu từ DAO
        List<Product> allProducts = productDAO.getAllProducts();

        // 2. Lọc sản phẩm mới và sản phẩm nổi bật
        List<Product> newProducts = allProducts.stream().filter(Product::isNew).collect(Collectors.toList());
        List<Product> hotProducts = allProducts.stream().filter(Product::isHot).collect(Collectors.toList());

        // 3. Đẩy dữ liệu sang trang JSP
        request.setAttribute("newProducts", newProducts);
        request.setAttribute("hotProducts", hotProducts);

        // 4. Forward tới file JSP trong WEB-INF
        request.getRequestDispatcher("/WEB-INF/views/product/home.jsp").forward(request, response);
    }
}