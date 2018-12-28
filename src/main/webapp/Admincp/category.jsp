<%@ page import="vn.haui.web.command.CategoryDao" %>
<%@ page import="vn.haui.web.model.Category" %>
<%@ page import="java.util.ArrayList" %>
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
<script>
    function delete_category_ajax(category_ID) {
        $.post('<%=WebConstant.getLocalHost()%>/MCategoryServlet', {'category-ID': category_ID,'command': "delete"},function (data) {
            $("#myModalLabel").html(data);
        });
        //xóa thẻ sau 2 giây
        setTimeout(function(){
            if ($('#item-'+category_ID).length > 0) {
                $('#item-'+category_ID).remove();
            }
        }, 2000)
    }
</script>
<%
    CategoryDao categoryDao = new CategoryDao();
    ArrayList<Category> categories = categoryDao.getListCategory();
    ArrayList<Category> categoriesParent = categoryDao.getListCategoryParent();
    //ArrayList<Category> categoriesChildren = categoryDao.getListCategoryChildren();
    String error = "",result="",error_slug="";
    out.print(request.getAttribute("error"));
    out.print(request.getAttribute("result"));
    if (request.getAttribute("error") != null)
        error = (String) request.getAttribute("error");
    if (request.getAttribute("result") != null)
        result = (String) request.getAttribute("result");
    if(request.getAttribute("error-slug")!=null)
        error_slug=(String)request.getAttribute("error-slug");
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
        <div class="col-lg-4">
            <form role="form" action="<%=WebConstant.getLocalHost()%>/MCategoryServlet" method="post">
                <div class="form-group">
                    <label>Tên chuyên mục</label>
                    <span name="category-name-result" class="text-danger"><%=error%></span>
                    <input class="form-control" id="category-name" name="category-name">
                    <p class="help-block">Tên riêng sẽ hiển thị trên trang mạng của bạn.</p>
                </div>
                <div class="form-group">
                    <label>Chuỗi cho đường dẫn tĩnh</label>
                    <input class="form-control" id="category-slug" name="category-slug"><span
                        id="category-slug-result" class="text-danger"><%=error_slug%></span>
                    <p class="help-block">Chuỗi cho đường dẫn tĩnh là phiên bản của tên hợp chuẩn với Đường dẫn (URL).
                        Chuỗi này bao gồm chữ cái thường, số và dấu gạch ngang (-).</p>
                </div>
                <div class="form-group">
                    <label>Chuyên mục hiện tại</label>
                    <select class="form-control" id="category-parent" name="category-parent">
                        <option value="0">Trống</option>
                        <%for (Category c : categories) {%>
                        <option value="<%=c.getCategoryID()%>"><%=c.getCategoryName()%>
                        </option>
                        <%}%>
                    </select>
                    <p class="help-block">Chuyên mục khác với thẻ, bạn có thể sử dụng nhiều cấp chuyên mục. Ví dụ: Trong
                        chuyên mục nhạc, bạn có chuyên mục con là nhạc Pop, nhạc Jazz. Việc này hoàn toàn là tùy theo ý
                        bạn.</p>
                </div>
                <div class="form-group">
                    <label>Mô tả</label>
                    <textarea class="form-control" rows="3" id="category-des" name="category-des"></textarea>
                    <p class="help-block">Thông thường mô tả này không được sử dụng trong các giao diện, tuy nhiên có
                        vài giao diện có thể hiển thị mô tả này.</p>
                </div>
                <input hidden="hidden" name="command" value="insert">
                <span name="category-result" class="text-success"><%=result%></span>
                <button type="submit" class="btn btn-success">Thêm chuyên mục</button>
            </form>
        </div>
        <!-- /.col-lg-4 (nested) -->
        <div class="col-lg-8">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Kitchen Sink
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Des</th>
                                <th>Slug</th>
                                <th>Parent</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%--<%for (Category c : categories) {%>--%>
                            <%for (Category c : categories) {%>
                            <tr id="item-<%=c.getCategoryID()%>">
                                <td><%=c.getCategoryID()%></td>
                                <td>
                                    <a href="<%=WebConstant.getLocalHost()%>/Admincp/edit-category.jsp?category=<%=c.getCategoryID()%>&action=edit"><%=c.getCategoryName()%>
                                    </a>
                                    <div class="row-actions">
                                        <span class="edit"><a href="<%=WebConstant.getLocalHost()%>/Admincp/edit-category.jsp?category=<%=c.getCategoryID()%>&action=edit"
                                                              aria-label="Sửa “Beauty”">Chỉnh sửa</a> | </span>
                                        <span class="delete"><a href="" class="delete-tag aria-button-if-js"
                                                                data-toggle="modal"
                                                                data-target="#delete<%=c.getCategoryID()%>"
                                                                aria-label="Xóa “Beauty”"
                                                                role="button">Xóa</a> | </span>
                                        <!-- Modal -->
                                        <div class="modal fade" id="delete<%=c.getCategoryID()%>" tabindex="-1"
                                             role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal"
                                                                aria-hidden="true">&times;
                                                        </button>
                                                        <h4 class="modal-title" id="myModalLabel1">Delete</h4>
                                                    </div>
                                                    <div class="modal-body">
                                                        Bạn có chắc chắn muốn xóa chuyên mục này không ?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="delete_category_ajax(<%=c.getCategoryID()%>)">Delete</button>
                                                    </div>
                                                </div>
                                                <!-- /.modal-content -->
                                            </div>
                                            <!-- /.modal-dialog -->
                                        </div>
                                        <!-- /.modal -->
                                        <span class="view"><a href="<%=WebConstant.getLocalHost()%>/<%=c.getCategorySlug()%>" aria-label="Xem lưu trữ “<%=c.getCategoryName()%>>”">Xem</a></span>
                                    </div>
                                </td>
                                <td><%=c.getCategoryDes() == null ? "" : c.getCategoryDes()%>
                                </td>
                                <td><%=c.getCategorySlug()%>
                                </td>
                                <td><%for (Category c2 : categories) {
                                            if(c2.getCategoryID()==c.getCategoryParent()){%>
                                    <%=c2.getCategoryName()%><%}}%>
                                </td>
                            </tr>
                            <%}%>
                            </tbody>
                        </table>
                    </div>
                    <!-- /.table-responsive -->
                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-6 -->
    </div>
    <!-- /.row -->
</div>
<!-- /#page-wrapper -->
<jsp:include page="footer.jsp"/>
