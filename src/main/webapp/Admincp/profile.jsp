<%@ page import="vn.haui.web.command.RoleDao" %>
<%@ page import="vn.haui.web.command.UsersDao" %>
<%@ page import="vn.haui.web.common.WebConstant" %>
<%@ page import="vn.haui.web.model.Role" %>
<%@ page import="vn.haui.web.model.Users" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 26/12/2018
  Time: 9:13 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<jsp:include page="header.jsp"/>
<%
    RoleDao roleDao = new RoleDao();
    UsersDao usersDao = new UsersDao();
    List<Role> roleList = roleDao.getListRole();
    Users users = null;
    String result = "";
    if (session.getAttribute("user") != null) {
        users = (Users) session.getAttribute("user");
    }
    if (session.getAttribute("result") != null) {
        result = (String) session.getAttribute("result");
        session.removeAttribute("result");
    }
%>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <%if (!result.equals("")) {%>
            <h3 class="text-success"><%=result%>
            </h3>
            <%}%>
            <h1 class="page-header">Thành viên</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <form role="form" action="<%=WebConstant.getLocalHost()%>/MUserServlet" method="post">
                <div class="form-group row">
                    <label for="email" class="col-sm-2 col-form-label">Email</label>
                    <div class="col-sm-10">
                        <input type="text" readonly class="form-control-plaintext" id="email" name="email"
                               style="border: none;"
                               value="<%=users.getEmail()%>">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="fullname" class="col-sm-2 col-form-label">Họ Tên</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Le Van A"
                               value="<%=users.getFullName()%>">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="roleid" class="col-sm-2 col-form-label">Chức vị</label>
                    <div class="col-sm-2">
                        <select class="form-control col-sm-10" id="roleid" name="roleid">
                            <%for (Role r : roleList) {%>
                            <option value="<%=r.getRoleid()%>"><%=r.getRoleName()%>
                            </option>
                            <%}%>
                        </select>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="xImagePath" class="col-sm-2 col-form-label">Ảnh đại diện</label>
                    <script>
                        function BrowseServer(startupPath, functionData) {
                            // You can use the "CKFinder" class to render CKFinder in a page:
                            var finder = new CKFinder();
                            //Startup path in a form: "Type:/path/to/directory/"
                            finder.startupPath = startupPath;
                            // Name of a function which is called when a file is selected in CKFinder.
                            finder.selectActionFunction = SetFileField;
                            // Additional data to be passed to the selectActionFunction in a second argument.
                            // We'll use this feature to pass the Id of a field that will be updated.
                            finder.selectActionData = functionData;
                            // Name of a function which is called when a thumbnail is selected in CKFinder.
                            finder.selectThumbnailActionFunction = ShowThumbnails;
                            // Launch CKFinder
                            finder.popup();
                        }

                        // This is a sample function which is called when a file is selected in CKFinder.
                        function SetFileField(fileUrl, data) {
                            document.getElementById(data["selectActionData"]).value = fileUrl;
                            ShowThumbnailsaa(fileUrl);
                        }

                        // This is a sample function which is called when a thumbnail is selected in CKFinder.
                        function ShowThumbnails(fileUrl, data) {   // this = CKFinderAPI
                            var sFileName = this.getSelectedFile().name;
                            document.getElementById('thumbnails').innerHTML +=
                                '<div class="thumb">' +
                                '<img src="' + fileUrl + '" />' +
                                '<div class="caption">' +
                                '<a href="' + data["fileUrl"] + '" target="_blank">' + sFileName + '</a> (' + data["fileSize"] + 'KB)' +
                                '</div>' +
                                '</div>';
                            document.getElementById('preview').style.display = "";
                            // It is not required to return any value.
                            // When false is returned, CKFinder will not close automatically.
                            return false;
                        }

                        function ShowThumbnailsaa(imgUrl) {
                            var htmlll = '<div class="thumb">' +
                                '<img height= "150px" width= "150px" src="<%=WebConstant.getLocalHost()%>' + imgUrl + '" />' +
                                '</div>';
                            document.getElementById('thumbnails').innerHTML = htmlll;
                            document.getElementById('preview').style.display = "";
                        }
                    </script>
                    <!-- /.panel-heading -->
                    <div class="panel-body col-sm-10">
                        <div id="preview" style="display:none">
                            <div id="thumbnails"></div>
                        </div>
                        <strong>Selected Image URL</strong><br/>
                        <input id="xImagePath" name="ImagePath" type="text" value="<%=users.getImg()%>"/>
                        <input type="button" value="Chọn ảnh" onclick="BrowseServer( 'Images:/', 'xImagePath' );"/>
                    </div>
                </div>
                <input hidden="hidden" name="command" value=update">
                <button type="submit" class="btn btn-success">Lưu lại</button>
            </form>
        </div>
    </div>
    <!-- /.row -->
</div>
<!-- /#page-wrapper -->
<script>
    $(document).ready(function () {
        if (jQuery('#xImagePath').val() == '') {
        } else {
            var urlImage = $('#xImagePath').val();
            var htmlll = '<div class="thumb">' +
                '<img height= "150px" width= "150px" src="<%=WebConstant.getLocalHost()%>' + urlImage + '" />' +
                '</div>';
            document.getElementById('thumbnails').innerHTML += htmlll;
            document.getElementById('preview').style.display = "";
        }
    });
</script>
<jsp:include page="footer.jsp"/>
