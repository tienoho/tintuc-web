package vn.haui.web.controller;

import vn.haui.web.command.PostDao;
import vn.haui.web.model.Post;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

@WebServlet("/post/*")
public class PostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String servletPath = request.getServletPath();
        List<Post> postList=null;
        try {
            postList=new PostDao().getListAllPost();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        servletPath=servletPath.substring(servletPath.lastIndexOf("/"),servletPath.length());
        String slug=servletPath.replace("/","");
        Post post = postList.stream()
                .filter(customer -> slug.equals(customer.getPostSlug()))
                .findAny()
                .orElse(null);
        if(post!=null)
        {
            HttpSession session = ((HttpServletRequest) request).getSession(false);
            session.setAttribute("postProuct",post);
            RequestDispatcher rd = null;
            String url="/singe.jsp?post="+post.getPostID();
            request.setAttribute("postId",post.getPostID());
            rd = getServletContext().getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //String servletPath = request.getServletPath();
        String servletPath=request.getPathInfo();
        String urlPathPost3=request.getRequestURL().toString();
        List<Post> postList=null;
        try {
            postList=new PostDao().getListAllPost();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        String slug=servletPath.replace("/","");
        Post post = postList.stream()
                .filter(customer -> slug.equals(customer.getPostSlug()))
                .findAny()
                .orElse(null);
        if(post!=null)
        {
            //HttpSession session = ((HttpServletRequest) request).getSession(false);
            //session.setAttribute("postProuct",post);
            RequestDispatcher rd = null;
            String url="/single.jsp";
            //String url="/index.jsp";
            String postID= String.valueOf(post.getPostID());
            request.setAttribute("postId1",postID);
            request.setAttribute("urlPathPost",urlPathPost3);
            rd = getServletContext().getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

}
