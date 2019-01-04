package vn.haui.web.controller;

import vn.haui.web.command.CommentDao;
import vn.haui.web.common.WebConstant;
import vn.haui.web.model.Comment;
import vn.haui.web.utils.tool;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ManagerCommentServlet")

public class ManagerCommentServlet extends HttpServlet {
    Comment comment;
    CommentDao commentDao = new CommentDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String url = WebConstant.getLocalHost() + "/Admincp/edit-comment.jsp", error = "", result = "", error_slug = "";
        String command = request.getParameter("command");

        String commentContent = request.getParameter("comment-content");

        HttpSession session = request.getSession(false);
        try {
            switch (command) {
                case "insert":
                    if (commentContent.equals("")) {
                        error = "Không thể bỏ trống!";
                        session.setAttribute("error", error);
                    } else {
                        String urlPath = request.getParameter("urlPath");
                        System.out.println(urlPath);
                        comment = new Comment();
                        comment.setComment_content(commentContent);
                        comment.setComment_parent(Integer.parseInt(request.getParameter("comment-parent")));
                        comment.setComment_date(tool.GetDateNow());
                        comment.setComment_author_email(request.getParameter("comment-email"));
                        comment.setComment_post_id(Integer.parseInt(request.getParameter("comment-post-id")));
                        comment.setComment_author(request.getParameter("comment-author"));
                        comment.setComment_status(WebConstant.getComment().equals("true")?1:0);
                        commentDao.insert(comment);
                        //save message in session
                        session.setAttribute("result", result);
                        url = urlPath;
                    }
                    break;
                case "update":
                    if (commentContent.equals("")) {
                        error = "Không thể bỏ trống tên tiêu đề !";
                        //request.setAttribute("error", error);
                        session.setAttribute("error", error);
                    } else {
                        comment = new Comment();
                        comment.setComment_id(Integer.parseInt(request.getParameter("comment-id")));
                        comment.setComment_content(commentContent);
                        comment.setComment_author_email(request.getParameter("comment-email"));
                        comment.setComment_author(request.getParameter("comment-author"));
                        comment.setComment_status(Integer.parseInt(request.getParameter("comment-status")));
                        commentDao.update(comment);
                        result = "Cập nhập thành công"+comment.getComment_status();
                        session.setAttribute("result", result);
                        url = WebConstant.getLocalHost() + "/Admincp/edit-comment.jsp?comment=" + comment.getComment_id() + "&action=edit";
                    }
                    break;
                case "delete":
                    commentDao.delete(Integer.parseInt(request.getParameter("comment-id")));
                    break;
                default:
                    result = "Không thành công";
                    session.setAttribute("result", result);
                    break;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            result = "Cập không thành công";
            session.setAttribute("result", result);
        }
        response.sendRedirect(url);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //String command = request.getParameter("command");
        String action = request.getParameter("action");
        String url = WebConstant.getLocalHost() + "/Admincp/comment.jsp";
        switch (action) {
            case "delete":
                try {
                    commentDao.delete(Integer.parseInt(request.getParameter("comment")));
                    url = WebConstant.getLocalHost() + "/Admincp/comment.jsp";
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                break;
            case "activate":
                try {
                    commentDao.actionActivate(Integer.parseInt(request.getParameter("comment")));
                    url = WebConstant.getLocalHost() + "/Admincp/comment.jsp";
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                break;
        }
        response.sendRedirect(url);
    }
}
