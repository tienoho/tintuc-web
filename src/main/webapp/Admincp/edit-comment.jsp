<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 20/12/2018
  Time: 4:41 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="vn.haui.web.command.PostDao" %>
<%@ page import="vn.haui.web.model.Post" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="vn.haui.web.command.CommentDao" %>
<%@ page import="vn.haui.web.model.Comment" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vn.haui.web.common.WebConstant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<jsp:include page="header.jsp"/>
<%
    String action = "",commentId="",result="",error="";

    if (request.getParameter("action") != null)
        action = request.getParameter("action");
    CommentDao commentDao = new CommentDao();
    Comment comment=new Comment();
    PostDao postDao=new PostDao();
    Post post=new Post();

    if(action.equals("edit"))
    {
        if(request.getParameter("comment")!=null)
        {
            commentId= request.getParameter("comment");
            try {
                comment=commentDao.getComment(Integer.parseInt(commentId));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(session.getAttribute("result")!=null)
        {
            result=(String)session.getAttribute("result");
            session.removeAttribute("result");
        }
        if(session.getAttribute("error")!=null)
        {
            error=(String)session.getAttribute("error");
            session.removeAttribute("error");
        }
    }
%>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <%if(!result.equals("")){%>
            <h3 class="text-success"><%=result%></h3>
            <%}%>
            <h1 class="page-header">Sửa bình luận</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <form role="form" action="<%=WebConstant.getLocalHost()%>/ManagerCommentServlet" method="post">
            <div class="col-lg-9">
                <div class="form-group">
                    <label>Tên:</label>
                    <span name="comment-author-result" class="text-danger"><%=error%></span>
                    <input class="form-control" id="comment-author" name="comment-author" value="<%=comment.getComment_author()%>">
                </div>
                <div class="form-group">
                    <label>Email:</label>
                    <input class="form-control" id="comment-email" name="comment-email" value="<%=comment.getComment_author_email()%>">
                    <span id="comment-email-result"></span>
                </div>
                <div class="form-group">
                    <label>Nội dung</label>
                    <textarea class="form-control" rows="4" id="comment-content" name="comment-content"><%=comment.getComment_content()%></textarea>
                    <p class="help-block"></p>
                </div>
                <span name="category-result"></span>
            </div>
            <!-- /.col-lg-4 (nested) -->
            <div class="col-lg-3">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-bell fa-fw"></i>Cập nhập
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="list-group">
                            <a href="#" class="list-group-item">
                                <div class="form-group">
                                    <label>Trạng thái</label>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="comment-status" id="comment-status-1" value="0" <%=comment.getComment_status()==0?"checked":""%>>Được chấp thuận
                                        </label>
                                    </div>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="comment-status" id="comment-status-2" value="1" <%=comment.getComment_status()==1?"checked":""%>>Chờ xác nhận
                                        </label>
                                    </div>
                                </div>
                            </a>
                            <a href="#" class="list-group-item">
                                <i class="fa fa-twitter fa-fw"></i> Ngày đăng
                                <span class="pull-right text-muted small">
                                    <em><%=action.equals("edit") ? comment.getComment_date() : "Ngay bây giờ"%></em>
                                </span>
                            </a>
                        </div>
                        <!-- /.list-group -->
                        <a href="<%=WebConstant.getLocalHost()%>/ManagerCommentServlet?comment=<%=comment.getComment_id()%>&action=delete" class="text-danger">Xóa</a>
                        <input hidden="hidden" name="comment-id" value="<%=comment.getComment_id()%>">
                        <input hidden="hidden" name="comment_post_id" value="<%=comment.getComment_post_id()%>">
                        <input hidden="hidden" name="command" value="update">
                        <button type="submit" class="btn btn-success">Cập nhập</button>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-6 -->
        </form>
    </div>
    <!-- /.row -->
</div>
<!-- /#page-wrapper -->
<jsp:include page="footer.jsp"/>
