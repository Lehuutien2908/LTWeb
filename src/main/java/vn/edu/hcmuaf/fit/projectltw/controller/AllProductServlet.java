package vn.edu.hcmuaf.fit.projectltw.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.projectltw.dao.ProductDAO;
import vn.edu.hcmuaf.fit.projectltw.model.Product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AllProductServlet", value = "/products")
public class AllProductServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Khởi tạo danh sách tổng hợp
        List<Product> all = new ArrayList<>();

        // 2. Lấy dữ liệu từ DAO (Thêm danh sách 12 máy mới và 7 máy hot)
        all.addAll(productDAO.getAllProducts());
        all.addAll(productDAO.getHotProducts());

        // 3. Đưa dữ liệu vào Request Attribute
        request.setAttribute("products", all);

        // 4. Chuyển hướng tới trang JSP
        request.getRequestDispatcher("/WEB-INF/views/product/allproduct.jsp").forward(request, response);
    }
}