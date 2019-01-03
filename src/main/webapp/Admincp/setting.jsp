<%@ page import="vn.haui.web.command.CategoryDao" %>
<%@ page import="vn.haui.web.common.WebConstant" %>
<%@ page import="vn.haui.web.model.Category" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Tam
  Date: 12/3/2018
  Time: 5:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<%
    CategoryDao categoryDao = new CategoryDao();
    List<Category> categories = categoryDao.getListCategory();
    String error_blogname = "", error_siteurl = "";
    String errorbl = "", error = "";
    if (session.getAttribute("error_blogname") != null) {
        error_blogname = (String) session.getAttribute("error_blogname");
        session.removeAttribute("error_blogname");
    }
    if (session.getAttribute("error_siteurl") != null) {
        error_siteurl = (String) session.getAttribute("error_siteurl");
        session.removeAttribute("error_siteurl");
    }
%>
<jsp:include page="header.jsp"/>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Cài đặt</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Tùy chọn trang webiste
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <form role="form" method="post" action="<%=WebConstant.getLocalHost()%>/SettingServlet">
                                <div class="form-group">
                                    <label>Tên website</label>
                                    <input class="form-control" name="blogname" value="<%=WebConstant.getBlogname()%>">
                                    <span name="post-title-result" class="text-danger"><%=error_blogname%></span>
                                </div>
                                <div class="form-group">
                                    <label>Khẩu hiệu</label>
                                    <input class="form-control" name="blogdescription"
                                           value="<%=WebConstant.getBlogdescription()%>">
                                    <p class="help-block">Giới thiệu về website</p>
                                </div>
                                <div class="form-group">
                                    <label>Địa chỉ trang web(URL)</label>
                                    <input class="form-control" name="siteurl" value="<%=WebConstant.getLocalHost()%>">
                                    <span name="post-title-result" class="text-danger"><%=error_siteurl%></span>
                                    <p class="help-block">Nhập địa chỉ website của bạn.</p>
                                </div>
                                <div class="form-group">
                                    <label>Địa chỉ email</label>
                                    <input class="form-control" name="admin_email"
                                           value="<%=WebConstant.getAdmin_email()%>">
                                    <p class="help-block">Địa chỉ này được sử dụng cho mục đích quản trị.</p>
                                </div>
                                <div class="form-group">
                                    <label>Hiển thị số bài viết ở trang chủ</label>
                                    <input class="form-control" type="number" name="post_home"
                                           value="<%=WebConstant.getPostNumberHome()%>">
                                    <p class="help-block">Số bài viết xuất hiện ở trang chủ.</p>
                                </div>
                                <div class="form-group">
                                    <label>Chuyên mục hiện ở trang chủ phụ</label>
                                    <select class="form-control" id="category_home_sub_one"
                                            name="category_home_sub_one">
                                        <%for (Category c : categories) {%>
                                        <option value="<%=c.getCategoryID()%>" <%if (WebConstant.getCategorySubOne() == c.getCategoryID()) {%>
                                                selected="selected"<%}%>><%=c.getCategoryName()%>
                                        </option>
                                        <%}%>
                                    </select>
                                    <p class="help-block">Chuyên mục hiện ở trang chủ phụ.</p>
                                </div>
                                <div class="form-group">
                                    <label>Hiển thị số bài viết ở trang chủ phụ</label>
                                    <input class="form-control" type="number" name="post_home_sub"
                                           value="<%=WebConstant.getPostNumberHomeSub()%>">
                                    <p class="help-block">Số bài viết xuất hiện ở trang chủ phụ.</p>
                                </div>
                                <div class="form-group">
                                    <label>Hiển thị số bài viết chuyên mục</label>
                                    <input class="form-control" type="number" name="post_category"
                                           value="<%=WebConstant.getPostNumber()%>">
                                    <p class="help-block">Số bài viết xuất hiện mỗi trang ở chuyên mục.</p>
                                </div>
                                <div class="form-group">
                                    <label>Hiển thị số bài viết có lượt xem nhiều nhất</label>
                                    <input class="form-control" type="number" name="post_number_view"
                                           value="<%=WebConstant.getPostView()%>">
                                    <p class="help-block">Số bài viết xuất hiện lượt xem nhiều nhất.</p>
                                </div>
                                <div class="form-group">
                                    <label>Chuyên mục đừng bỏ lỡ</label>
                                    <select class="form-control" id="category_miss" name="category_miss">
                                        <%for (Category c : categories) {%>
                                        <option value="<%=c.getCategoryID()%>" <%if (WebConstant.getPostView() == c.getCategoryID()) {%>
                                                selected="selected"<%}%>><%=c.getCategoryName()%>
                                        </option>
                                        <%}%>
                                    </select>
                                    <p class="help-block">Chuyên mục hiện ở trang chủ phụ.</p>
                                </div>
                                <div class="form-group">
                                    <label>Hiển thị số bài viết ở đừng bỏ lỡ</label>
                                    <input class="form-control" type="number" name="post_miss_number"
                                           value="<%=WebConstant.getPostMissId()%>">
                                    <p class="help-block">Số bài viết xuất hiện.</p>
                                </div>
                                <div class="form-group row">
                                    <label for="xImagePath-icon" class="col-sm-2 col-form-label">icon</label>
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
                                            var x = document.getElementById(data["selectActionData"]).getAttribute("id");
                                            x = x.replace("xImagePath", "");
                                            ShowThumbnailsaa(x, fileUrl);
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

                                        function ShowThumbnailsaa(x, imgUrl) {
                                            var htmlll = '<div class="thumb">' +
                                                '<img height= "150px" width= "150px" src="<%=WebConstant.getLocalHost()%>' + imgUrl + '" />' +
                                                '</div>';
                                            document.getElementById('thumbnails' + x).innerHTML = htmlll;
                                            document.getElementById('preview' + x).style.display = "";
                                        }
                                    </script>
                                    <!-- /.panel-heading -->
                                    <div class="panel-body col-sm-10">
                                        <div id="preview-icon" style="display:none">
                                            <div id="thumbnails-icon"></div>
                                        </div>
                                        <strong>Selected Image URL</strong><br/>
                                        <input id="xImagePath-icon" name="xImagePath-icon" type="text"
                                               value="<%=WebConstant.getxImagePath_icon()%>"/>
                                        <input type="button" value="Chọn ảnh"
                                               onclick="BrowseServer( 'Images:/', 'xImagePath-icon' );"/>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="xImagePath-logo" class="col-sm-2 col-form-label">Logo</label>
                                    <!-- /.panel-heading -->
                                    <div class="panel-body col-sm-10">
                                        <div id="preview-logo" style="display:none">
                                            <div id="thumbnails-logo"></div>
                                        </div>
                                        <strong>Selected Image URL</strong><br/>
                                        <input id="xImagePath-logo" name="xImagePath-logo" type="text"
                                               value="<%=WebConstant.getxImagePath_logo()%>"/>
                                        <input type="button" value="Chọn ảnh"
                                               onclick="BrowseServer( 'Images:/', 'xImagePath-logo' );"/>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="xImagePath-logo-2x" class="col-sm-2 col-form-label">Logo 2x</label>
                                    <!-- /.panel-heading -->
                                    <div class="panel-body col-sm-10">
                                        <div id="preview-logo-2x" style="display:none">
                                            <div id="thumbnails-logo-2x"></div>
                                        </div>
                                        <strong>Selected Image URL</strong><br/>
                                        <input id="xImagePath-logo-2x" name="xImagePath-logo-2x" type="text"
                                               value="<%=WebConstant.getxImagePath_logo_2x()%>"/>
                                        <input type="button" value="Chọn ảnh"
                                               onclick="BrowseServer( 'Images:/', 'xImagePath-logo-2x');"/>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="xImagePath-logo-mobile" class="col-sm-2 col-form-label">Logo
                                        mobile</label>
                                    <!-- /.panel-heading -->
                                    <div class="panel-body col-sm-10">
                                        <div id="preview-logo-mobile" style="display:none">
                                            <div id="thumbnails-logo-mobile"></div>
                                        </div>
                                        <strong>Selected Image URL</strong><br/>
                                        <input id="xImagePath-logo-mobile" name="xImagePath-logo-mobile" type="text"
                                               value="<%=WebConstant.getxImagePath_logo_mobile()%>"/>
                                        <input type="button" value="Chọn ảnh"
                                               onclick="BrowseServer( 'Images:/', 'xImagePath-logo-mobile');"/>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="xImagePath-banner-header" class="col-sm-2 col-form-label">Banner
                                        header</label>
                                    <!-- /.panel-heading -->
                                    <div class="panel-body col-sm-10">
                                        <div id="preview-banner-header" style="display:none">
                                            <div id="thumbnails-banner-header"></div>
                                        </div>
                                        <strong>Selected Image URL</strong><br/>
                                        <input id="xImagePath-banner-header" name="xImagePath-banner-header" type="text"
                                               value="<%=WebConstant.getBanner_header()%>"/>
                                        <input type="button" value="Chọn ảnh"
                                               onclick="BrowseServer( 'Images:/', 'xImagePath-banner-header' );"/>
                                        <label>Url</label>
                                        <input class="form-control" type="text" name="url-banner-header"
                                               value="<%=WebConstant.getUrl_banner_header()%>">
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-success">Lưu thay đổi</button>
                            </form>
                        </div>
                        <!-- /.col-lg-6 (nested) -->
                    </div>
                    <!-- /.row (nested) -->
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
<script>
    $(document).ready(function () {
        if (jQuery('#xImagePath-icon').val() == '') {
        } else {
            var urlImage = $('#xImagePath-icon').val();
            var htmlll = '<div class="thumb">' +
                '<img height= "16px" width= "16px" src="<%=WebConstant.getLocalHost()%>' + urlImage + '" />' +
                '</div>';
            document.getElementById('thumbnails-icon').innerHTML += htmlll;
            document.getElementById('preview-icon').style.display = "";
        }
        if (jQuery('#xImagePath-logo').val() == '') {
        } else {
            var urlImage = $('#xImagePath-logo').val();
            var htmlll = '<div class="thumb">' +
                '<img height= "" width= "" src="<%=WebConstant.getLocalHost()%>' + urlImage + '" />' +
                '</div>';
            document.getElementById('thumbnails-logo').innerHTML += htmlll;
            document.getElementById('preview-logo').style.display = "";
        }
        if (jQuery('#xImagePath-logo-2x').val() == '') {
        } else {
            var urlImage = $('#xImagePath-logo-2x').val();
            var htmlll = '<div class="thumb">' +
                '<img height= "" width= "" src="<%=WebConstant.getLocalHost()%>' + urlImage + '" />' +
                '</div>';
            document.getElementById('thumbnails-logo-2x').innerHTML += htmlll;
            document.getElementById('preview-logo-2x').style.display = "";
        }
        if (jQuery('#xImagePath-logo-mobile').val() == '') {
        } else {
            var urlImage = $('#xImagePath-logo-mobile').val();
            var htmlll = '<div class="thumb">' +
                '<img height= "" width= "" src="<%=WebConstant.getLocalHost()%>' + urlImage + '" />' +
                '</div>';
            document.getElementById('thumbnails-logo-mobile').innerHTML += htmlll;
            document.getElementById('preview-logo-mobile').style.display = "";
        }
        if (jQuery('#xImagePath-banner-header').val() == '') {
        } else {
            var urlImage = $('#xImagePath-banner-header').val();
            var htmlll = '<div class="thumb"><img height= "" width= "" src="<%=WebConstant.getLocalHost()%>' + urlImage + '" /></div>';
            document.getElementById('thumbnails-banner-header').innerHTML += htmlll;
            document.getElementById('preview-banner-header').style.display = "";
        }
    });
</script>
<jsp:include page="footer.jsp"/>