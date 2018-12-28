<%@ page import="vn.haui.web.common.WebConstant" %>
<%@ page import="vn.haui.web.model.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.haui.web.command.CategoryDao" %>
<%@ page import="vn.haui.web.model.Setting" %>
<%@ page import="vn.haui.web.command.SettingDao" %>
<%@ page import="vn.haui.web.utils.FooterHeader" %>
<%@ page import="vn.haui.web.common.WebFooter" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 24/12/2018
  Time: 4:04 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<jsp:include page="header.jsp"/>
<%
    CategoryDao categoryDao = new CategoryDao();
    List<Category> categories = categoryDao.getListCategory();
    //SettingDao settingDao=new SettingDao();
    //List<Setting> settings=settingDao.getTable("option_footer");
    new FooterHeader().getFooter();
%>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Sửa Footer</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <form role="form" action="<%=WebConstant.getLocalHost()%>/" method="post">
            <div class="col-lg-9">
                <div class="form-group">
                    <label>Khẩu hiệu của website</label>
                    <span name="footer-slogan-result" class="text-danger"></span>
                    <textarea class="form-control" rows="5" id="footer-slogan" name="footer-slogan"
                              placeholder="Nhập nội dung"><%=WebFooter.getSlogan()%>
                    </textarea>
                    <p class="help-block">Tên riêng sẽ hiển thị trên trang mạng của bạn.</p>
                </div>
                <div class="form-group">
                    <label>Copyright</label>
                    <input class="form-control" rows="5" id="footer-copyright" name="footer-copyright"
                           placeholder="copyright" value="<%=WebFooter.getCopyright()%>">
                    </input>
                </div>
                <span name="category-result"></span>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-bell fa-fw"></i>logo footer
                    </div>
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
                    </script>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div id="preview" style="display:none">
                            <strong>Chọn logo footer</strong><br/>
                            <div id="thumbnails"></div>
                        </div>
                        <strong>Chọn logo footer URL</strong><br/>
                        <input id="xImagePath" name="ImagePath" type="text"
                               value="<%=WebFooter.getLogo()%>"/>
                        <input type="button" value="Browse Server" onclick="BrowseServer( 'Images:/', 'xImagePath' );"/>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <div class="form-group">
                    <label>Hiển thị số bài viết</label>
                    <input class="form-control" type="number" name="post_home"
                           value="<%=WebFooter.getCategory_number()%>">
                    <p class="help-block">Số bài viết xuất hiện ở trang chủ.</p>
                </div>
                <div class="form-group">
                    <label>Chuyên mục hiện ở trang chủ phụ</label>
                    <select class="form-control" id="category_home_sub_one" name="category_home_sub_one">
                        <%for (Category c : categories) {%>
                        <option value="<%=c.getCategoryID()%>" <%if (WebFooter.getCategory_id() == c.getCategoryID()) {%>
                                selected="selected"<%}%>><%=c.getCategoryName()%>
                        </option>
                        <%}%>
                    </select>
                    <p class="help-block">Chuyên mục hiện ở trang chủ phụ.</p>
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-4 (nested) -->
            <div class="col-lg-3">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-bell fa-fw"></i> Hành động
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="list-group">
                            <button type="submit" class="btn btn-success">Lưu</button>
                        </div>
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
<script>
    $(document).ready( function() {
        if (jQuery('#xImagePath').val() == '') {
        } else {
            var urlImage = $('#xImagePath').val();
            var htmlll='<div class="thumb">' +
                '<img height= "150px" width= "150px" src="<%=WebConstant.getLocalHost()%>' + urlImage + '" />' +
                '</div>';
            document.getElementById('thumbnails').innerHTML+=htmlll;
            document.getElementById('preview').style.display = "";
        }
    });
</script>
<!-- /#page-wrapper -->
<jsp:include page="footer.jsp"/>
