<%@ page import="vn.haui.web.command.CategoryDao" %>
<%@ page import="vn.haui.web.command.PostDao" %>
<%@ page import="vn.haui.web.command.TermsRelationshipsDao" %>
<%@ page import="vn.haui.web.model.Category" %>
<%@ page import="vn.haui.web.model.Post" %>
<%@ page import="vn.haui.web.model.TermsRelationships" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="vn.haui.web.common.WebConstant" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 29/11/2018
  Time: 11:10 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<jsp:include page="header.jsp"/>
<%
    String action = "", postId = "", result = "", error = "";
    if (request.getParameter("action") != null)
        action = request.getParameter("action");
    PostDao postDao = new PostDao();
    CategoryDao categoryDao = new CategoryDao();
    TermsRelationshipsDao termsRelationshipsDao = new TermsRelationshipsDao();
    Post post = new Post();
    if (action.equals("edit")) {
        if (request.getParameter("post") != null) {
            postId = request.getParameter("post");
            try {
                post = postDao.getPost(Integer.parseInt(postId));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (session.getAttribute("result") != null) {
            result = (String) session.getAttribute("result");
            session.removeAttribute("result");
        }
        if (session.getAttribute("error") != null) {
            error = (String) session.getAttribute("error");
            session.removeAttribute("error");
        }
    }
%>
<script>
    function addTag() {
        var tag=document.getElementById('input-tag').value;
        var listTag;var x;
        if(tag.includes(',')===true){
            listTag=tag.split(',');
            for (x in listTag){
                var tagLi = '<li>'+listTag[x]+'</li>';
                if(tag!=""){
                    document.getElementById('tagchecklist').innerHTML += tagLi;
                }
            }
        }else {
            var tagLi = '<li>'+tag+'</li>';
            if(tag!=""){document.getElementById('tagchecklist').innerHTML += tagLi;}
        }
    }
    function delete_tag_li(item) {
        //xóa thẻ sau 2 giây
        setTimeout(function(){
            if ($('#'+item).length > 0) {
                $('#'+item).remove();
            }
        }, 1000)
    }
</script>
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
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <%if (!result.equals("")) {%>
            <h3 class="text-success"><%=result%>
            </h3>
            <%}%>
            <h1 class="page-header"><%=action.equals("edit") ? "Cập nhập bài viết" : "Bài viết mới"%>
            </h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <form role="form" action="<%=WebConstant.getLocalHost()%>/ManagerPostServlet" method="post">
            <div class="col-lg-9">
                <div class="form-group">
                    <label>Tiêu đề bài viết</label>
                    <span name="post-title-result" class="text-danger"><%=error%></span>
                    <input class="form-control" id="post-title" name="post-title" placeholder="Nhập tiêu đề tại đây"
                           value="<%=action.equals("edit")?post.getPostTitle():""%>">
                    <p class="help-block">Tên riêng sẽ hiển thị trên trang mạng của bạn.</p>
                </div>
                <%if (action.equals("edit")) {%>
                <div class="form-group">
                    <label>Liên kết tĩnh</label>
                    <input class="form-control" id="post-slug" name="post-slug"
                           value="<%=action.equals("edit")?post.getPostSlug():""%>">
                    <span id="post-slug-result"></span>
                    <p class="help-block">Chuỗi cho đường dẫn tĩnh là phiên bản của tên hợp chuẩn với Đường dẫn (URL).
                        Chuỗi này bao gồm chữ cái thường, số và dấu gạch ngang (-).</p>
                </div>
                <%}%>
                <div class="form-group">
                    <label>Nội dung</label>
                    <textarea class="form-control" rows="5" id="post-content" name="post-content">
                        <%=action.equals("edit") ? post.getPostContent() : ""%>
                    </textarea>
                    <script type="text/javascript" language="javascript">
                        var editer = CKEDITOR.replace('post-content', {
                            width: '100%',
                            height: '300px'
                        }, {editorConfig: '/ckeditor/config.js'});
                        CKFinder.setupCKEditor(editer, '<%=WebConstant.getLocalHost()%>/ckfinder/');
                    </script>
                    <p class="help-block"></p>
                </div>
                <div class="form-group">
                    <label>Tóm tắt</label>
                    <textarea class="form-control" rows="2" id="post-summary" name="post-summary"></textarea>
                    <p class="help-block"></p>
                </div>
                <span name="category-result"></span>
            </div>
            <!-- /.col-lg-4 (nested) -->
            <div class="col-lg-3">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-bell fa-fw"></i> <%=action.equals("edit") ? "Cập nhập" : "Đăng"%>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="list-group">
                            <a href="#" class="list-group-item">
                                <i class="fa fa-comment fa-fw"></i> Trạng thái
                                <span class="pull-right text-muted small"><em><%=action.equals("edit") ? post.getPostStatus() : "Công khai"%></em>
                                    </span>
                            </a>
                            <a href="#" class="list-group-item">
                                <i class="fa fa-twitter fa-fw"></i> Ngày đăng
                                <span class="pull-right text-muted small"><em><%=action.equals("edit") ? post.getPostDateTimestamp() : "Ngay bây giờ"%></em>
                                    </span>
                            </a>
                        </div>
                        <!-- /.list-group -->
                        <%if (action.equals("edit")) {%>
                        <a href="<%=WebConstant.getLocalHost()%>/ManagerPostServlet?post=<%=post.getPostID()%>&action=delete"
                           class="text-danger">Xóa</a>
                        <input hidden="hidden" name="postID" value="<%=post.getPostID()%>">
                        <%}%>
                        <input hidden="hidden" name="command" value="<%=action.equals("edit")?"update":"insert"%>">
                        <button type="submit" class="btn btn-success"><%=action.equals("edit") ? "Cập nhập" : "Đăng"%>
                        </button>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
                <div class="chat-panel panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-comments fa-fw"></i> Chuyên mục
                        <div class="btn-group pull-right">
                            <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-chevron-down"></i>
                            </button>
                            <ul class="dropdown-menu slidedown">
                                <li><a href="#"><i class="fa fa-refresh fa-fw"></i> Làm mới</a></li>
                                <li><a href="#"><i class="fa fa-check-circle fa-fw"></i> Available</a></li>
                            </ul>
                        </div>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body" style="height: 200px;">
                        <ul class="chat">
                            <%for (Category c : categoryDao.getListCategory()) {%>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="category" id="category-item-<%=c.getCategoryID()%>"
                                        <%for (TermsRelationships t:termsRelationshipsDao.getListTermsRelationshipsByPostID(post.getPostID())){
                                            if(t.getCategoryID()==c.getCategoryID()){%> checked="checked"
                                        <%}}%>
                                           value="<%=c.getCategoryID()%>"><%=c.getCategoryName()%>
                                </label>
                            </div>
                            <%}%>
                        </ul>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel .chat-panel -->
                <div class="panel panel-default">
                    <div class="panel-heading"><i class="fa fa-bell fa-fw"></i>Thẻ</div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="form-group">
                            <div class="input-group">
                                <input id="input-tag" type="text" class="form-control input-sm" placeholder="tag here..."/>
                                <span class="input-group-btn">
                                    <input type="button" class="btn btn-warning btn-sm" id="btn-add-tag" value="Thêm" onclick="addTag();"/>
                                </span>
                            </div>
                            <p class="help-block">Phân cách các thẻ bằng dấu phẩy (,).</p>
                        </div>
                        <ul class="tagchecklist" id="tagchecklist" role="list">
                            <li name="item-tag" id="item-tag-1">a <button type="button" onclick="delete_tag_li('item-tag-1');" class="btn btn-warning btn-circle" style="width: 15px;height: 15px;padding: 0px;"><i class="fa fa-times"></i>
                            </button></li>
                            <li name="item-tag" id="item-tag-2">dsss <button type="button" onclick="delete_tag_li('item-tag-1');" class="btn btn-warning btn-circle" style="width: 15px;height: 15px;padding: 0px;"><i class="fa fa-times"></i>
                            </button></li>
                        </ul>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-bell fa-fw"></i>Ảnh đại diện
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div id="preview" style="display:none">
                            <strong>Selected Thumbnails</strong><br/>
                            <div id="thumbnails"></div>
                        </div>
                        <strong>Selected Image URL</strong><br/>
                        <input id="xImagePath" name="ImagePath" type="text" value="<%=action.equals("edit")?post.getPostImg():""%>"/>
                        <input type="button" value="Browse Server" onclick="BrowseServer( 'Images:/', 'xImagePath' );"/>
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
<!-- /#page-wrapper -->
<jsp:include page="footer.jsp"/>
