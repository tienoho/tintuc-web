package vn.haui.web.filter;

import vn.haui.web.common.WebConstant;
import vn.haui.web.model.Users;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class filterAdmin implements Filter {
    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        System.out.println("Admin Filter init!");
    }

    @Override
    public void destroy() {
        System.out.println("Admin Filter destroy!");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        Users users = null;
        if (req.getSession().getAttribute("user") != null) {
            users = (Users) req.getSession().getAttribute("user");
        }
        if (users == null || users.getRoleId() == 2) {
            ((HttpServletResponse) response).sendRedirect(WebConstant.getLocalHost());
        } else {
            // Cho phép request được đi tiếp. (Vượt qua Filter này).
            chain.doFilter(request, response);
        }
    }
}
