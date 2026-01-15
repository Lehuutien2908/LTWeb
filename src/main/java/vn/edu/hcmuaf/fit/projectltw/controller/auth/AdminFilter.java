package vn.edu.hcmuaf.fit.projectltw.controller.auth;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.fit.projectltw.model.User;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        User user = (User) session.getAttribute("user");

        if (user != null && user.getRole() == 1) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/login?error=access-denied");
        }
    }

    @Override
    public void destroy() {
    }
}