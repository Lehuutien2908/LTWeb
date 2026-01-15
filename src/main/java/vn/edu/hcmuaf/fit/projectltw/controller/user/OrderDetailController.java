package vn.edu.hcmuaf.fit.projectltw.controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.fit.projectltw.dao.OrderDAO;
import vn.edu.hcmuaf.fit.projectltw.model.Order;
import vn.edu.hcmuaf.fit.projectltw.model.OrderDetail;
import vn.edu.hcmuaf.fit.projectltw.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderDetailController", value = "/order-detail")
public class OrderDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String orderId = request.getParameter("id");
        OrderDAO orderDAO = new OrderDAO();

        Order order = orderDAO.getOrderById(orderId);


        if (order != null) {
            List<OrderDetail> details = orderDAO.getListDetails(orderId);

            request.setAttribute("order", order);
            request.setAttribute("details", details);

            request.getRequestDispatcher("/views/user/order-detail.jsp").forward(request, response);
        } else {
            response.sendRedirect("profile");
        }
    }
}