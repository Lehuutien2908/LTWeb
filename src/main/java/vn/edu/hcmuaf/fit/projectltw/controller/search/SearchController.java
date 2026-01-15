package vn.edu.hcmuaf.fit.projectltw.controller.search;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.fit.projectltw.dao.ProductDAO;
import vn.edu.hcmuaf.fit.projectltw.model.Product;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchController", value = "/search")
public class SearchController extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");

        List<Product> list = productDAO.searchProducts(query != null ? query.trim() : "");

        request.setAttribute("listP", list);
        request.setAttribute("txtSearch", query);
        request.getRequestDispatcher("/views/product/search-results.jsp").forward(request, response);
    }
}