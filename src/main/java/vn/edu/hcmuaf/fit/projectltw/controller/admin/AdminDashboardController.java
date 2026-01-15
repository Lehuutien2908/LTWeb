package vn.edu.hcmuaf.fit.projectltw.controller.admin;

import vn.edu.hcmuaf.fit.projectltw.dao.OrderDAO;
import vn.edu.hcmuaf.fit.projectltw.dao.ProductDAO;
import vn.edu.hcmuaf.fit.projectltw.dao.UserDAO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AdminDashboardController", value = "/admin/dashboard")
public class AdminDashboardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        UserDAO userDAO = new UserDAO();
        ProductDAO productDAO = new ProductDAO();

        Map<String, Object> stats = new HashMap<>();
        stats.put("totalRevenue", orderDAO.getRevenueCurrentMonth());
        stats.put("newOrders", orderDAO.countNewOrders());
        stats.put("totalUsers", userDAO.countTotalUsers());
        stats.put("lowStockProducts", productDAO.countLowStockProducts());

        request.setAttribute("stats", stats);
        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
