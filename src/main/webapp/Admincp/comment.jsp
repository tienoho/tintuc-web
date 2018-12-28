<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 20/12/2018
  Time: 4:40 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vn.haui.web.model.Post" %>
<%@ page import="vn.haui.web.command.PostDao" %>
<%@ page import="vn.haui.web.command.UsersDao" %>
<%@ page import="vn.haui.web.command.CommentDao" %>
<%@ page import="vn.haui.web.model.Users" %>
<%@ page import="vn.haui.web.model.Comment" %>
<%@ page import="vn.haui.web.common.WebConstant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<jsp:include page="header.jsp"/>
<%
    CommentDao commentDao = new CommentDao();
    PostDao postDao=new PostDao();
    UsersDao usersDao=new UsersDao();

    ArrayList<Post> posts = postDao.getListAllPost();
    ArrayList<Comment> comments = commentDao.getAllListComment();
    //ArrayList<Users> categories=usersDao.get();
%>
<script>
    function delete_commnet_ajax(commnet_ID) {
        $.post('<%=WebConstant.getLocalHost()%>/ManagerCommentServlet', {'comment-id': Post_ID,'command': "delete"},function (data) {
            $("#myModalLabel").html(data);
        });
        //xóa thẻ sau 2 giây
        setTimeout(function(){
            if ($('#item-comment-'+commnet_ID).length > 0) {
                $('#item-comment-'+commnet_ID).remove();
            }
        }, 2000)
    }
</script>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Bài viết</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a href="edit-post.jsp" class="font-italic" >Thêm bài viết mới</a>
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tác giả</th>
                            <th>Bình luận</th>
                            <th>Bình luận cho</th>
                            <th>Đã bình luận vào</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Comment c : comments) {%>
                        <tr class="odd gradeX" id="item-comment-<%=c.getComment_id()%>">
                            <td><%=c.getComment_id()%></td>
                            <td><%=c.getComment_author()%></td>
                            <td><a href="edit-comment.jsp?comment=<%=c.getComment_id()%>&action=edit" class="font-weight-bold"><%=c.getComment_content()%></a>
                                <div class="row-actions">
                                    <%if(c.getComment_status()==1){%>
                                    <span class="activate"><a class="text-success" href="edit-comment.jsp?comment=<%=c.getComment_id()%>&action=activate" aria-label="Xem lưu trữ ">Chấp nhận</a></span>
                                    <%}%>
                                    <span class="edit"><a class="text-info" href="edit-comment.jsp?comment=<%=c.getComment_id()%>&action=edit" aria-label="Sửa">Chỉnh sửa</a> | </span>
                                    <span class="delete"><a href="" class="delete-tag aria-button-if-js text-danger" data-toggle="modal" data-target="#delete<%=c.getComment_id()%>" aria-label="Xóa" role="button">Xóa</a></span>
                                    <!-- Modal -->
                                    <div class="modal fade" id="delete<%=c.getComment_id()%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                    <h4 class="modal-title" id="myModalLabel">Delete</h4>
                                                </div>
                                                <div class="modal-body">
                                                    Bạn có chắc chắn muốn xóa bình luận này không ?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="delete_commnet_ajax(<%=c.getComment_id()%>)">Delete</button>
                                                </div>
                                            </div>
                                            <!-- /.modal-content -->
                                        </div>
                                        <!-- /.modal-dialog -->
                                    </div>
                                    <!-- /.modal -->
                                </div>
                            </td>
                            <td><%Post pC=postDao.getPost(c.getComment_post_id());%>
                                <a href="<%=WebConstant.getLocalHost()%>/post/<%=pC.getPostSlug()%>"><%=pC.getPostTitle()%></a>
                            </td>
                            <td><%=c.getComment_date()%></td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                    <!-- /.table-responsive -->
                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
</div>
<!-- /#page-wrapper -->
<jsp:include page="footer.jsp"/>
