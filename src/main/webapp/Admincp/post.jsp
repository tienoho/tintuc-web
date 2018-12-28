<%@ page import="vn.haui.web.command.CategoryDao" %>
<%@ page import="vn.haui.web.model.Category" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vn.haui.web.model.Post" %>
<%@ page import="vn.haui.web.command.PostDao" %>
<%@ page import="vn.haui.web.command.UsersDao" %>
<%@ page import="vn.haui.web.common.WebConstant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<jsp:include page="header.jsp"/>
<%
    PostDao postDao = new PostDao();
    CategoryDao categoryDao=new CategoryDao();
    UsersDao usersDao=new UsersDao();
    ArrayList<Post> posts = postDao.getListAllPost();
    ArrayList<Category> categories=categoryDao.getListCategory();
%>
<script>
    function delete_post_ajax(Post_ID) {
        $.post('<%=WebConstant.getLocalHost()%>/ManagerPostServlet', {'post-ID': Post_ID,'command': "delete"},function (data) {
            $("#myModalLabel").html(data);
        });
        //xóa thẻ sau 2 giây
        setTimeout(function(){
            if ($('#item-post-'+Post_ID).length > 0) {
                $('#item-post-'+Post_ID).remove();
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
                    <a href="edit-post.jsp" class="font-italic" ><strong>Thêm bài viết mới</strong></a>
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tiêu đề</th>
                            <th>Tác giả</th>
                            <th>Chuyên mục</th>
                            <th>Ngày đăng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Post p : posts) {%>
                        <tr class="odd gradeX" id="item-post-<%=p.getPostID()%>">
                            <td><%=p.getPostID()%></td>
                            <td><a href="edit-post.jsp?post=<%=p.getPostID()%>&action=edit" class="font-weight-bold"><strong><%=p.getPostTitle()%></strong></a>
                                <div class="row-actions">
                                    <span class="edit"><a class="text-primary" href="edit-post.jsp?post=<%=p.getPostID()%>&action=edit" aria-label="Sửa">Chỉnh sửa</a> | </span>
                                    <span class="delete"><a href="" class="delete-tag aria-button-if-js text-danger" data-toggle="modal" data-target="#delete<%=p.getPostID()%>" aria-label="Xóa" role="button">Xóa</a> | </span>
                                    <!-- Modal -->
                                    <div class="modal fade" id="delete<%=p.getPostID()%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                    <h4 class="modal-title" id="myModalLabel">Delete</h4>
                                                </div>
                                                <div class="modal-body">
                                                    Bạn có chắc chắn muốn xóa bài viết này không ?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="delete_post_ajax(<%=p.getPostID()%>)">Delete</button>
                                                </div>
                                            </div>
                                            <!-- /.modal-content -->
                                        </div>
                                        <!-- /.modal-dialog -->
                                    </div>
                                    <!-- /.modal -->
                                    <span class="view"><a href="<%=WebConstant.getLocalHost()+"/post/"+p.getPostSlug()%>" class="text-success" aria-label="Xem">Xem</a></span>
                                </div>
                            </td>
                            <td><%=usersDao.getName(p.getAuthorID())%></td>
                            <td>
                                <%for(Category c:categoryDao.getListCategoryByPost(p.getPostID()))
                                {%>
                                    <%=c.getCategoryName()%> ,
                                <%}%>
                            </td>
                            <td><%=p.getPostDate()%></td>
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
