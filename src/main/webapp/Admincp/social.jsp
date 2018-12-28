<%@ page import="vn.haui.web.command.SocialDao" %>
<%@ page import="vn.haui.web.model.Social" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.haui.web.common.WebConstant" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 24/12/2018
  Time: 1:31 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<%
    SocialDao socialDao = new SocialDao();
    List<Social> socialList = socialDao.getListSocial();
    List<String> listIcon= new ArrayList<>();
    listIcon.add("fa-twitter");
    listIcon.add("fa-facebook");
    listIcon.add("fa-instagram");
    listIcon.add("fa-google-plus");
    listIcon.add("fa-heart");
    listIcon.add("fa-pinterest");
    listIcon.add("fa-youtube");
    listIcon.add("fa-tumblr");
    listIcon.add("fa-rss");
    listIcon.add("fa-envelope");
%>
<jsp:include page="header.jsp"/>

<style>
    .entry:not(:first-of-type) {
        margin-top: 10px;
    }

    .glyphicon {
        font-size: 12px;
    }
</style>
<script>
    $(function () {
        $(document).on('click', '.btn-add', function (e) {
            e.preventDefault();
            var controlForm = $('.controls form:first'),
                currentEntry = $(this).parents('.entry:first'),
                newEntry = $(currentEntry.clone()).appendTo(controlForm);
            newEntry.find('input').val('');
            controlForm.find('.entry:not(:last) .btn-add')
                .removeClass('btn-add').addClass('btn-remove')
                .removeClass('btn-success').addClass('btn-danger')
                .html('<span class="glyphicon glyphicon-minus"></span>');
        }).on('click', '.btn-remove', function (e) {
            $(this).parents('.entry:first').remove();
            e.preventDefault();
            return false;
        });
    });
</script>
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
                        <div class="control-group" id="fields">

                            <div class="controls">
                                <form role="form" autocomplete="off" action="<%=WebConstant.getLocalHost()%>/SocialSevlet" method="post">
                                    <div class="col-xs-2 col-sm-2">
                                        <label class="control-label" for="fields">Tên</label>
                                    </div>
                                    <div class="col-xs-3 col-sm-3">
                                        <label class="control-label" for="fields">url</label>
                                    </div>
                                    <div class="col-xs-3 col-sm-3">
                                        <label class="control-label" for="fields">Tiêu đề</label>
                                    </div>
                                    <div class="col-xs-2 col-sm-2">
                                        <label class="control-label" for="fields">icon</label>
                                    </div>
                                    <div class="col-xs-2 col-sm-2"><button type="submit" class="btn btn-success">Lưu</button></div>

                                    <%if(socialList.size()<=0){%>
                                    <div class="entry">
                                        <div class="col-xs-2 col-sm-2">
                                            <input class="form-control" name="fieldsName[]" type="text"
                                                   placeholder="name"/>
                                        </div>
                                        <div class="col-xs-3 col-sm-3">
                                            <input class="form-control" name="fieldsUrl[]" type="text"
                                                   placeholder="www.fb.com" />
                                        </div>
                                        <div class="col-xs-3 col-sm-3">
                                            <input class="form-control" name="fieldsTitle[]" type="text"
                                                   placeholder="Title" />
                                        </div>
                                        <div class="col-xs-2 col-sm-2">
                                            <select class="form-control" name="fieldsIcon[]">
                                                <%for (String sIcon : listIcon) {%>
                                                <option data-icon="fa <%=sIcon%>" value="<%=sIcon%>"><%=sIcon%></option>
                                                <%}%>
                                            </select>
                                        </div>
                                        <div class="col-xs-2 col-sm-2">
                                        <span class="input-group-btn">
                                            <button class="btn btn-success btn-add" type="button">
                                                <span class="glyphicon glyphicon-plus"></span>
                                            </button></span>
                                        </div>
                                    </div>
                                    <%}%>
                                    <%for(Social s:socialList){%>
                                    <div class="entry">
                                        <div class="col-xs-2 col-sm-2">
                                            <input class="form-control" name="fieldsName[]" type="text"
                                                   placeholder="name" value="<%=s.getSocial_name()%>"/>
                                        </div>
                                        <div class="col-xs-3 col-sm-3">
                                            <input class="form-control" name="fieldsUrl[]" type="text"
                                                   placeholder="www.fb.com" value="<%=s.getSocial_url()%>"/>
                                        </div>
                                        <div class="col-xs-3 col-sm-3">
                                            <input class="form-control" name="fieldsTitle[]" type="text"
                                                   placeholder="Title" value="<%=s.getSocial_title()%>"/>
                                        </div>
                                        <div class="col-xs-2 col-sm-2">
                                            <select class="form-control" id="category-parent" name="fieldsIcon[]">
                                                <%for (String sIcon : listIcon) {%>
                                                <option  value="<%=sIcon%>" <%if(s.getSocial_icon().equals(sIcon)){%> selected="selected"<%}%>>
                                                    <%=sIcon%>
                                                </option>
                                                <%}%>
                                                <%-- <%=(c.getCategoryID()==category.getCategoryID())?"selected=\"selected\"":""%>--%>
                                            </select>
                                        </div>
                                        <div class="col-xs-2 col-sm-2">
                                        <span class="input-group-btn">
                                            <button class="btn btn-success btn-add" type="button">
                                                <span class="glyphicon glyphicon-plus"></span>
                                            </button></span>
                                        </div>
                                    </div>
                                    <%}%>
                                </form>
                                <br>
                                <small>Press <span class="glyphicon glyphicon-plus gs"></span> to add another form field
                                    :)
                                </small>
                            </div>
                        </div>
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
<jsp:include page="footer.jsp"/>
