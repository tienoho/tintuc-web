<%@ page import="vn.haui.web.common.WebConstant" %>
<%@ page import="vn.haui.web.utils.tool" %>
<%@ page import="vn.haui.web.model.Post" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.haui.web.command.UsersDao" %>
<%@ page import="vn.haui.web.command.PostDao" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 27/12/2018
  Time: 10:57 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<%
    UsersDao usersDao=new UsersDao();
    PostDao postDao = new PostDao();
    String tag = "";
    if(request.getParameter("tag")!=null){
        tag = (String) request.getParameter("tag");
    }
    int total=0;
    try {
        total=postDao.getCountSearch(tag);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    int pages = 1, firstResult = 0, maxResult = 0;
    if (request.getParameter("pages") != null) {
        pages = Integer.parseInt(request.getParameter("pages"));
    }
    if (total <= WebConstant.getPostNumber()) {
        firstResult = 0;
        maxResult = total;
    } else {
        firstResult = (pages - 1) * WebConstant.getPostNumber();
        maxResult = WebConstant.getPostNumber();
    }
    List<Post> posts = null;
    try {
        posts = postDao.getListSearch(tag, firstResult, maxResult);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<jsp:include page="header.jsp"/>
<div class="breadcrumbs-wrap">
    <div class="wrap">
        <div class="breadcrumbs">
            <span class="location">Bạn đang ở:</span>
            <span itemscope itemtype="">
                <a itemprop="url" href=""> <span itemprop="title">Trang chủ</span></a>
            </span>
            <span class="delim">&raquo;</span>
            <span class="current">Tìm kiếm</span>
        </div>
    </div>
</div>
<div class="main wrap cf">
    <div class="row">
        <div class="col-8 main-content">
            <h2 class="main-heading">Tìm kiếm: "<%=tag%>"<strong>
            </strong></h2>
            <div class="posts-list listing-alt">
                <% for (Post p : posts) {%>
                <article
                        class="post-<%=p.getPostID()%> post type-post status-publish format-standard has-post-thumbnail category-business category-lifestyle tag-culture tag-fashion tag-fitness tag-leisure tag-lifestyle">
                    <div class="post-wrap">
                        <a href="<%=WebConstant.getLocalHost()%>/post/<%=p.getPostSlug()%>" class="image-link">
                            <img width="312" height="198"
                                 src="<%=WebConstant.getLocalHost()%><%=p.getPostImg()%>"
                                 class="attachment-list-block size-list-block wp-post-image"
                                 alt="shutterstock_485005621"
                                 title="Rachel Runs a Business by Her Own Set of Rules"
                                 srcset="<%=WebConstant.getLocalHost()%><%=p.getPostImg().replace(".jpg","-300x200.jpg")%> 300w, <%=WebConstant.getLocalHost()%><%=p.getPostImg().replace(".jpg","-163x102.jpg")%> 163w"
                                 sizes="(max-width: 300px) 100vw, 300px"/> </a>
                        <div class="content">
                            <a href="<%=WebConstant.getLocalHost()+"/post/"+p.getPostSlug()%>"
                               class="post-title"><%=p.getPostTitle()%>
                            </a>
                            <div class="cf listing-meta meta below">
                                <span class="meta-item author">By <a href="#"
                                                                     title="Posts by <%=usersDao.getName(p.getAuthorID())%>"
                                                                     rel="author"><%=usersDao.getName(p.getAuthorID())%></a>
                                </span>
                                <time datetime="<%=p.getPostDateTimestamp()%>" class="meta-item"><%=p.getPostDateTimestamp()%>
                                </time>
                            </div>
                            <div class="excerpt">
                                <%--content--%>
                                <%=tool.html2text(p.getPostContent()).substring(0, 50)%><%=WebConstant.tobeContime%>
                            </div>
                        </div>
                    </div>
                </article>
                <%}%>
            </div>
            <div class="main-pagination">
                <%
                    int cout = total / WebConstant.getPostNumber();
                    if (pages > 1) {
                %>
                <a class="prev page-numbers"
                   href="<%=WebConstant.getLocalHost()%>/tag?tag=<%=tag%>&pages=<%=pages-1%>">
                    <i class="fa fa-angle-left"></i>
                    <span class="visuallyhidden">Previous</span>
                </a>
                <%}%>
                <%
                    for (int i = 1; i <= (cout) + 1; i++) {
                        if (i == pages) {
                %>
                <span class='page-numbers current'><%=i%></span>
                <%
                } else {
                %>
                <a class='page-numbers'
                   href='<%=WebConstant.getLocalHost()%>/tag?s=<%=tag%>&pages=<%=i%>'><%=i%>
                </a>
                <%}}if (pages >= cout && cout > 1) {%>
                <a class="next page-numbers"
                   href="<%=WebConstant.getLocalHost()%>/tag?s=<%=tag%>&pages=<%=pages+1%>">
                    <span class="visuallyhidden">Next</span>
                    <i class="fa fa-angle-right"></i>
                </a>
                <%}%>

            </div>
        </div>
        <jsp:include page="sidebar-category.jsp"/>
    </div>
</div>
<jsp:include page="footer.jsp"/>
