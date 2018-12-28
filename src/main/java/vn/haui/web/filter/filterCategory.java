package vn.haui.web.filter;

import vn.haui.web.command.CategoryDao;
import vn.haui.web.command.PostDao;
import vn.haui.web.model.Category;
import vn.haui.web.model.Post;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class filterCategory implements Filter{
    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        System.out.println("Category Filter init!");
    }

    @Override
    public void destroy() {
        System.out.println("Category Filter destroy!");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;

        String servletPath = req.getRequestURL().toString();
        String slug = servletPath.substring(servletPath.lastIndexOf("/") + 1, servletPath.length());

        List<Category> categories = null;
        try {
            categories = new CategoryDao().getListCategory();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Category category = categories.stream()
                .filter(customer -> slug.equals(customer.getCategorySlug()))
                .findAny()
                .orElse(null);
        if (category != null) {
            HttpSession session = ((HttpServletRequest) request).getSession(false);
            session.setAttribute("head_title", category.getCategoryName());

        }
        // Cho phép request được đi tiếp. (Vượt qua Filter này).
        chain.doFilter(request, response);
    }
}
