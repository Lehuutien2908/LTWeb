package vn.edu.hcmuaf.fit.projectltw.controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.projectltw.dao.UserDAO;
import vn.edu.hcmuaf.fit.projectltw.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserAdminController", value = "/admin/users")
public class UserAdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        List<User> list = dao.getAllUsers();

        request.setAttribute("listUsers", list);
        request.getRequestDispatcher("/views/admin/usersAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                int id = Integer.parseInt(idStr);
                new UserDAO().deleteUser(id);
            }
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
}