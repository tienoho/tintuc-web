<%@ page import="vn.haui.web.command.CategoryDao" %>
<%@ page import="vn.haui.web.model.Category" %>
<%@ page import="java.util.ArrayList" %>
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
<script type="text/javascript">
    //check email
    $(document).ready(function () {
        var x_timer;
        $("#category-slug").keyup(function (e) {
            clearTimeout(x_timer);
            var category_slug = $(this).val();
            x_timer = setTimeout(function () {
                check_slug_category_ajax(category_slug);
            }, 1000);
        });

        function check_slug_category_ajax(category_slug) {
            $("#category-slug-result").html('<img src="<%=WebConstant.getLocalHost()%>/js/ajax-loader.gif" />');
            $.post('<%=WebConstant.getLocalHost()%>/CheckCategorySlugServlet', {'category-slug': category_slug}, function (data) {
                $("#category-slug-result").html(data);
            });
        }
    });
</script>
<%
    CategoryDao categoryDao = new CategoryDao();
    ArrayList<Category> categories = null;
    try {
        categories = categoryDao.getListCategory();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    String error = "",result="",error_slug="";
    if (request.getAttribute("error") != null)
        error = (String) request.getAttribute("error");
    if (request.getAttribute("result") != null)
        result = (String) request.getAttribute("result");
    if(request.getAttribute("error-slug")!=null)
        error_slug=(String)request.getAttribute("error-slug");
    Category category = new Category();
    if(request.getParameter("category")!=null) {
        try {
            category = categoryDao.getCategory(Integer.parseInt(request.getParameter("category")));
%>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Chuyên mục</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <form role="form" method="post" action="<%=WebConstant.getLocalHost()%>/MCategoryServlet">
                <div class="form-group">
                    <label>Tên chuyên mục</label>
                    <span name="category-name-result" class="text-danger"><%=error%></span>
                    <input class="form-control" id="category-name" name="category-name" value="<%=category.getCategoryName()%>">
                    <p class="help-block">Tên riêng sẽ hiển thị trên trang mạng của bạn.</p>
                </div>
                <div class="form-group">
                    <label>Chuỗi cho đường dẫn tĩnh</label>
                    <input class="form-control" id="category-slug" name="category-slug" value="<%=category.getCategorySlug()%>">
                    <span id="category-slug-result" class="text-danger"><%=error_slug%></span>
                    <p class="help-block">Chuỗi cho đường dẫn tĩnh là phiên bản của tên hợp chuẩn với Đường dẫn (URL).
                        Chuỗi này bao gồm chữ cái thường, số và dấu gạch ngang (-).</p>
                </div>
                <div class="form-group">
                    <label>Chuyên mục hiện tại</label>
                    <select class="form-control" id="category-parent" name="category-parent">
                        <option value="0">Trống</option>
                        <%for (Category c : categories) {
                        if(c.getCategoryID()!=category.getCategoryID()){
                        %>
                        <option  value="<%=c.getCategoryID()%>" <%if(category.getCategoryParent()==c.getCategoryID()){%> selected="selected"<%}%>><%=c.getCategoryName()%>
                        </option>
                        <%}}%>
                        <%-- <%=(c.getCategoryID()==category.getCategoryID())?"selected=\"selected\"":""%>--%>
                    </select>
                    <p class="help-block">Chuyên mục khác với thẻ, bạn có thể sử dụng nhiều cấp chuyên mục. Ví dụ: Trong
                        chuyên mục nhạc, bạn có chuyên mục con là nhạc Pop, nhạc Jazz. Việc này hoàn toàn là tùy theo ý
                        bạn.</p>
                </div>
                <div class="form-group">
                    <label>Mô tả</label>
                    <textarea class="form-control" rows="3" id="category-des" name="category-des" value=""><%=category.getCategoryDes()%></textarea>
                    <p class="help-block">Thông thường mô tả này không được sử dụng trong các giao diện, tuy nhiên có
                        vài giao diện có thể hiển thị mô tả này.</p>
                </div>
                <input hidden="hidden" name="categoryID" value="<%=category.getCategoryID()%>">
                <input hidden="hidden" name="command" value="edit">
                <span name="category-result" class="text-success"><%=result%></span>
                <button type="submit" class="btn btn-success">Cập nhập</button>
            </form>
        </div>
        <!-- /.col-lg-12 (nested) -->
    </div>
    <!-- /.row -->
</div>
<%} catch (SQLException e) {
    e.printStackTrace();
%>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Chuyên mục không tồn tại</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
</div>
<%}}%>
<!-- /#page-wrapper -->
<jsp:include page="footer.jsp"/>
