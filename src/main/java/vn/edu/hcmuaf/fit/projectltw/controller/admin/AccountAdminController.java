package vn.edu.hcmuaf.fit.projectltw.controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.hcmuaf.fit.projectltw.dao.UserDAO;
import vn.edu.hcmuaf.fit.projectltw.model.User;

import java.io.IOException;

@WebServlet(name = "AccountAdminController", value = "/admin/accountAD")
public class AccountAdminController extends HttpServlet {

    UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User userInDb = userDAO.getById(user.getId());
        if (userInDb != null) {
            session.setAttribute("user", userInDb);
            request.setAttribute("user", userInDb);
        } else {
            request.setAttribute("user", user);
        }

        request.getRequestDispatcher("/views/admin/accountAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("updateInfo".equals(action)) {
                String fullName = request.getParameter("fullName");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");

                userDAO.updateProfile(user.getId(), fullName, phone, address);

                user.setFullName(fullName);
                user.setPhone(phone);
                user.setAddress(address);

                session.setAttribute("user", user);

                request.setAttribute("message", "Cập nhật thông tin thành công!");
            } else if ("changePassword".equals(action)) {
                String currentPass = request.getParameter("currentPass");
                String newPass = request.getParameter("newPass");
                String confirmPass = request.getParameter("confirmPass");

                User userInDb = UserDAO.getById(user.getId());
                if (userInDb == null) {
                    request.setAttribute("error", "Không tìm thấy tài khoản!");
                } else if (userInDb.getPassword() == null || !currentPass.trim().equals(userInDb.getPassword().trim())) {
                    request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
                } else if (!newPass.equals(confirmPass)) {
                    request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                } else {
                    userDAO.changePassword(user.getId(), newPass.trim());

                    user.setPassword(newPass.trim());
                    session.setAttribute("user", user);

                    request.setAttribute("message", "Đổi mật khẩu thành công!");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

        doGet(request, response);
    }
}