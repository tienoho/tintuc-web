<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 04/12/2018
  Time: 2:43 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<jsp:include page="header.jsp"/>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Thư viện</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <script>
                // You can use the "CKFinder" class to render CKFinder in a page:
                var finder = new CKFinder();
                // The path for the installation of CKFinder (default = "/ckfinder/").
                // Change the skin to bootstrap.
                finder.skin = 'bootstrap';
                // Create CKFinder instance.
                finder.create();
            </script>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
