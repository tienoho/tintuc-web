<%@ page import="vn.haui.web.common.WebConstant" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 26/12/2018
  Time: 11:18 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<jsp:include page="header.jsp"/>
<%

    String result = "";

    if (session.getAttribute("result") != null) {
        result = (String) session.getAttribute("result");
        session.removeAttribute("result");
    }
%>
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
        x=x.replace("xImagePath","");
        ShowThumbnailsaa(x,fileUrl);
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
    function ShowThumbnailsaa(x,imgUrl) {
        var htmlll = '<div class="thumb">' +
            '<img height= "150px" width= "150px" src="<%=WebConstant.getLocalHost()%>' + imgUrl + '" />' +
            '</div>';
        document.getElementById('thumbnails'+x).innerHTML = htmlll;
        document.getElementById('preview'+x).style.display = "";
    }
</script>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <%if (!result.equals("")) {%>
            <h3 class="text-success"><%=result%>
            </h3>
            <%}%>
            <h1 class="page-header">Thêm thành viên</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <form role="form" action="<%=WebConstant.getLocalHost()%>/ManagerAdvServlet" method="post">
                <label for="title-2" class="col-form-label">Banner Sibar 1</label>
                <div class="form-group row">
                    <label for="title-1" class="col-sm-2 col-form-label">Title</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="title-1" name="title-1" value="">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="url-1" class="col-sm-2 col-form-label">Url</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="url-1" name="url-1" placeholder="url-1" value="">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="xImagePath-banner-1" class="col-sm-2 col-form-label">Banner sibar 1</label>
                    <!-- /.panel-heading -->
                    <div class="panel-body col-sm-10">
                        <div id="preview-banner-1" style="display:none">
                            <div id="thumbnails-banner-1"></div>
                        </div>
                        <strong>Selected Image URL</strong><br/>
                        <input id="xImagePath-banner-1" name="xImagePath-banner-1" type="text" value=""/>
                        <input type="button" value="Chọn ảnh" onclick="BrowseServer( 'Images:/', 'xImagePath-banner-1');"/>
                    </div>
                </div>
                <label for="title-2" class="col-form-label">Banner Sibar 2</label>
                <div class="form-group row">
                    <label for="title-2" class="col-sm-2 col-form-label">Title</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="title-2" name="title-2" value="">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="url-2" class="col-sm-2 col-form-label">Url</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="url-2" name="url-1" placeholder="url-2" value="">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="xImagePath-banner-2" class="col-sm-2 col-form-label">Banner sibar 1</label>
                    <!-- /.panel-heading -->
                    <div class="panel-body col-sm-10">
                        <div id="preview-banner-2" style="display:none">
                            <div id="thumbnails-banner-2"></div>
                        </div>
                        <strong>Selected Image URL</strong><br/>
                        <input id="xImagePath-banner-2" name="xImagePath-banner-2" type="text" value=""/>
                        <input type="button" value="Chọn ảnh" onclick="BrowseServer( 'Images:/', 'xImagePath-banner-2');"/>
                    </div>
                </div>
                <input hidden="hidden" name="command" value=insert">
                <button type="submit" class="btn btn-success">Lưu lại</button>
            </form>
        </div>
    </div>
    <!-- /.row -->
</div>
<!-- /#page-wrapper -->
<script>
    $(document).ready(function () {
        if (jQuery('#xImagePath-banner-1').val() == '') {
        } else {
            var urlImage = $('#xImagePath-banner-1').val();
            var htmlll = '<div class="thumb">' +
                '<img height= "150px" width= "150px" src="<%=WebConstant.getLocalHost()%>/' + urlImage + '" />' +
                '</div>';
            document.getElementById('thumbnails-banner-1').innerHTML += htmlll;
            document.getElementById('preview-banner-1').style.display = "";
        }
        if (jQuery('#xImagePath-banner-2').val() == '') {
        } else {
            var urlImage = $('#xImagePath-banner-2').val();
            var htmlll = '<div class="thumb">' +
                '<img height= "150px" width= "150px" src="<%=WebConstant.getLocalHost()%>/' + urlImage + '" />' +
                '</div>';
            document.getElementById('thumbnails-banner-2').innerHTML += htmlll;
            document.getElementById('preview-banner-2').style.display = "";
        }
    });
</script>
<jsp:include page="footer.jsp"/>
