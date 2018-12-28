<%@ page import="java.util.ArrayList" %>
<%@ page import="vn.haui.web.command.UsersDao" %>
<%@ page import="vn.haui.web.common.WebConstant" %>
<%@ page import="vn.haui.web.model.Users" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 25/12/2018
  Time: 2:03 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<jsp:include page="header.jsp"/>
<%
    UsersDao usersDao=new UsersDao();
    ArrayList<Users> users=usersDao.getListUsers();
%>
<script>
    function delete_post_ajax(User_ID) {
        $.post('<%=WebConstant.getLocalHost()%>/ManagerUserServlet', {'user-ID': User_ID,'command': "delete"},function (data) {
            $("#myModalLabel").html(data);
        });
        //xóa thẻ sau 2 giây
        setTimeout(function(){
            if ($('#item-user-'+User_ID).length > 0) {
                $('#item-user-'+User_ID).remove();
            }
        }, 2000)
    }
</script>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Người dùng</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a href="add-user.jsp" class="font-italic" ><strong>Thêm người dùng mới</strong></a>
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <thead>
                        <tr>
                            <th>Email</th>
                            <th>Tên</th>
                            <th>Ngày tạo</th>
                            <th>Vai trò</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Users u : users) {%>
                        <tr class="odd gradeX" id="item-user-<%=u.getEmail()%>">
                            <td><%=u.getFullName()%></td>
                            <td><a href="profile.jsp?user=<%=u.getEmail()%>&action=edit" class="font-weight-bold"><strong><%=u.getEmail()%></strong></a>
                                <div class="row-actions">
                                    <span class="edit"><a class="text-primary" href="profile.jsp?user=<%=u.getEmail()%>&action=edit" aria-label="Sửa">Chỉnh sửa</a> | </span>
                                    <span class="delete"><a href="" class="delete-tag aria-button-if-js text-danger" data-toggle="modal" data-target="#delete-<%=u.getEmail()%>" aria-label="Xóa" role="button">Xóa</a> | </span>
                                    <!-- Modal -->
                                    <div class="modal fade" id="delete-<%=u.getEmail()%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                    <h4 class="modal-title" id="myModalLabel">Delete</h4>
                                                </div>
                                                <div class="modal-body">
                                                    Bạn có chắc chắn muốn xóa người dùng này này không ?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="delete_post_ajax(<%=u.getEmail()%>)">Delete</button>
                                                </div>
                                            </div>
                                            <!-- /.modal-content -->
                                        </div>
                                        <!-- /.modal-dialog -->
                                    </div>
                                    <!-- /.modal -->
                                </div>
                            </td>
                            <td><%=u.getCreatedDate()%></td>
                            <td><%=usersDao.getNameRole(u.getRoleId())%></td>
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

