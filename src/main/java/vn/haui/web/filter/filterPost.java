package vn.haui.web.filter;

import vn.haui.web.command.PostDao;
import vn.haui.web.model.Post;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class filterPost implements Filter {
    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        System.out.println("Post Filter init!");
    }

    @Override
    public void destroy() {
        System.out.println("Post Filter destroy!");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String servletPath = req.getRequestURL().toString();
        String slug = servletPath.substring(servletPath.lastIndexOf("/") + 1, servletPath.length());
        List<Post> postList = null;
        try {
            postList = new PostDao().getListAllPost();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Post post = postList.stream()
                .filter(customer -> slug.equals(customer.getPostSlug()))
                .findAny()
                .orElse(null);
        if (post != null) {
            HttpSession session = ((HttpServletRequest) request).getSession();
            session.setAttribute("urlPathPost", servletPath);
            session.setAttribute("head_title", post.getPostTitle());
        }
        // Cho phép request được đi tiếp. (Vượt qua Filter này).
        chain.doFilter(request, response);
    }
}
