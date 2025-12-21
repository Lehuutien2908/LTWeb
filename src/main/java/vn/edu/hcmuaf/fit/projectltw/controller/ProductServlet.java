package vn.edu.hcmuaf.fit.projectltw.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.fit.projectltw.dao.ProductDAO;
import vn.edu.hcmuaf.fit.projectltw.model.Product;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "ProductServlet", value = "/detail")
public class ProductServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Lấy ID từ tham số URL (?id=...)
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);

            // 2. Sử dụng DAO để lấy dữ liệu sản phẩm
            Product product = productDAO.getProductById(id);

            if (product != null) {
                // 3. Chuẩn bị dữ liệu cho JSP
                request.setAttribute("product", product);

                // Lấy danh sách liên quan: Lọc bỏ sản phẩm hiện tại để không bị trùng
                List<Product> related = productDAO.getHotProducts().stream()
                        .filter(p -> p.getId() != id) // Không hiện lại máy đang xem
                        .limit(4)                     // Chỉ lấy đúng 4 máy
                        .collect(Collectors.toList());

                request.setAttribute("relatedProducts", related);

                // 4. Chuyển hướng đến View
                request.getRequestDispatcher("/WEB-INF/views/product/detail.jsp").forward(request, response);
            } else {
                // Nếu ID không tồn tại trong data, về trang chủ
                response.sendRedirect("home");
            }
        } catch (NumberFormatException e) {
            // Nếu ID không phải là số (VD: ?id=abc), về trang chủ
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}