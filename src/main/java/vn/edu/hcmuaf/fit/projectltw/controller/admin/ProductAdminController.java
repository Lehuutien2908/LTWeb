package vn.edu.hcmuaf.fit.projectltw.controller.admin;

import vn.edu.hcmuaf.fit.projectltw.dao.ProductDAO;
import vn.edu.hcmuaf.fit.projectltw.model.Product;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductAdminController", value = "/admin/products")
public class ProductAdminController extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> list = productDAO.getAllProducts();

        request.setAttribute("listProducts", list);

        request.getRequestDispatcher("/views/admin/productsAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";

        String message = "";

        try {
            switch (action) {
                case "create":
                    createProduct(request);
                    message = "Thêm sản phẩm thành công!";
                    break;
                case "update":
                    updateProduct(request);
                    message = "Cập nhật sản phẩm thành công!";
                    break;
                case "delete":
                    deleteProduct(request);
                    message = "Đã xóa sản phẩm!";
                    break;
                default:
                    message = "Hành động không hợp lệ!";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Có lỗi xảy ra: " + e.getMessage();
        }

        request.setAttribute("message", message);

        doGet(request, response);
    }


    private void createProduct(HttpServletRequest request) {
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String image = request.getParameter("image");
        String category = request.getParameter("category");
        int stock = Integer.parseInt(request.getParameter("stock"));

        boolean isNew = request.getParameter("isNew") != null;
        boolean isHot = request.getParameter("isHot") != null;

        Product p = new Product(0, name, price, image, category, isNew, isHot, stock);

        productDAO.insertProduct(p);
    }

    private void updateProduct(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String image = request.getParameter("image");
        String category = request.getParameter("category");
        int stock = Integer.parseInt(request.getParameter("stock"));

        boolean isNew = request.getParameter("isNew") != null;
        boolean isHot = request.getParameter("isHot") != null;

        Product p = new Product(id, name, price, image, category, isNew, isHot, stock);

        productDAO.updateProduct(p);
    }

    private void deleteProduct(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.deleteProduct(id);
    }
}