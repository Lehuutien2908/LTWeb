package vn.edu.hcmuaf.fit.projectltw.controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.projectltw.dao.OrderDAO;
import vn.edu.hcmuaf.fit.projectltw.model.Order;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderAdminController", value = "/admin/orders")
public class OrderAdminController extends HttpServlet {

    OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Order> listOrders = orderDAO.getOrders();

        request.setAttribute("listOrders", listOrders);

        request.getRequestDispatcher("/views/admin/ordersAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("updateStatus")) {
            try {
                String orderId = request.getParameter("id");
                int status = Integer.parseInt(request.getParameter("status"));

                orderDAO.updateStatus(orderId, status);

                request.setAttribute("message", "Cập nhật trạng thái đơn hàng #" + orderId + " thành công!");

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật!");
            }
        }

        doGet(request, response);
    }
}