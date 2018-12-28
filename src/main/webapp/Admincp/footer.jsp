<%@ page import="vn.haui.web.common.WebConstant" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 28/11/2018
  Time: 4:33 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<footer>
    <p>Tien</p>
</footer>
<!-- /#wrapper -->

<!-- jQuery -->
<script src="<%=WebConstant.getLocalHost()%>/Admincp/vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="<%=WebConstant.getLocalHost()%>/Admincp/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="<%=WebConstant.getLocalHost()%>/Admincp/vendor/metisMenu/metisMenu.min.js"></script>

<!-- Morris Charts JavaScript -->
<%--<script src="<%=WebConstant.getLocalHost()%>/Admincp/vendor/raphael/raphael.min.js"></script>--%>
<%--<script src="<%=WebConstant.getLocalHost()%>/Admincp/vendor/morrisjs/morris.min.js"></script>--%>
<%--<script src="<%=WebConstant.getLocalHost()%>/Admincp/data/morris-data.js"></script>--%>
<!-- DataTables JavaScript -->
<script src="<%=WebConstant.getLocalHost()%>/Admincp/vendor/datatables/js/jquery.dataTables.min.js"></script>
<script src="<%=WebConstant.getLocalHost()%>/Admincp/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
<%--<script src="<%=WebConstant.getLocalHost()%>/Admincp/vendor/datatables-responsive/dataTables.responsive.js"></script>--%>
<script src="<%=WebConstant.getLocalHost()%>/Admincp/js/bootstrap-select.js"></script>

<!-- Custom Theme JavaScript -->
<script src="<%=WebConstant.getLocalHost()%>/Admincp/dist/js/sb-admin-2.js"></script>
<!-- Page-Level Demo Scripts - Tables - Use for reference -->
<script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
            responsive: true
        });
    });
</script>
</body>

</html>