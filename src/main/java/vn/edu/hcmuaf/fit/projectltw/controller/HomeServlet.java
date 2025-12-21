package vn.edu.hcmuaf.fit.projectltw.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.projectltw.dao.ProductDAO;
import vn.edu.hcmuaf.fit.projectltw.model.Product;

@WebServlet(name = "HomeServlet", value = "/home")
public class HomeServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Lấy dữ liệu cho các section chính (12 máy mỗi mục)
        List<Product> newProducts = productDAO.getNewProducts();
        List<Product> hotProducts = productDAO.getHotProducts();

        // 2. Lấy dữ liệu 5 máy cho SIDEBAR (Siêu giảm giá)
        List<Product> saleProducts = productDAO.getSaleProducts();

        // 3. Đẩy dữ liệu sang JSP
        request.setAttribute("newProducts", newProducts);
        request.setAttribute("hotProducts", hotProducts);
        request.setAttribute("saleProducts", saleProducts); // Tên biến dùng trong Sidebar JSP

        // 4. Forward vào thư mục views/product/home.jsp
        request.getRequestDispatcher("/WEB-INF/views/product/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}