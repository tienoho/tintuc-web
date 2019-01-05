<%@ page import="vn.haui.web.common.WebConstant" %>
<%@ page import="vn.haui.web.command.PostDao" %>
<%@ page import="vn.haui.web.command.UsersDao" %>
<%@ page import="vn.haui.web.command.SocialDao" %>
<%@ page import="vn.haui.web.model.Post" %>
<%@ page import="vn.haui.web.model.Social" %>
<%@ page import="vn.haui.web.utils.tool" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<%
    PostDao postDao=new PostDao();
    UsersDao usersDao=new UsersDao();
    SocialDao socialDao=new SocialDao();
%>
<aside class="col-4 sidebar" data-sticky="1">
    <div class="theiaStickySidebar">
        <ul>
            <li id="bunyad-latest-posts-widget-5" class="widget latest-posts">
                <h3 class="widgettitle">Xem nhiều nhất</h3>
                <ul class="posts-list">
                    <%for(Post pView:postDao.getListInPostView(WebConstant.postView)){
                        String extendsImgNew = pView.getPostImg();
                        if (extendsImgNew.contains(".")) {
                            extendsImgNew = extendsImgNew.substring(extendsImgNew.lastIndexOf("."), extendsImgNew.length());
                        }
                    %>
                    <li><a href="<%=WebConstant.getLocalHost()+"/post/"+pView.getPostSlug()%>">
                        <img width="104" height="69" src="<%=WebConstant.getLocalHost()%><%=pView.getPostImg().replace(extendsImgNew,"-104x69"+extendsImgNew)%>"
                             class="attachment-post-thumbnail size-post-thumbnail wp-post-image"
                             alt="<%=pView.getPostImg()%>"
                             title="<%=pView.getPostTitle()%>"
                             srcset="<%=WebConstant.getLocalHost()%><%=pView.getPostImg().replace(extendsImgNew,"-104x69"+extendsImgNew)%> 104w, <%=WebConstant.getLocalHost()%><%=pView.getPostImg().replace(extendsImgNew,"-300x200"+extendsImgNew)%> 300w, <%=WebConstant.getLocalHost()%><%=pView.getPostImg().replace(extendsImgNew,"-1000x667"+extendsImgNew)%> 1000w, <%=WebConstant.getLocalHost()%><%=pView.getPostImg().replace(extendsImgNew,"-702x459"+extendsImgNew)%> 702w, <%=WebConstant.getLocalHost()%><%=pView.getPostImg().replace(extendsImgNew,"-214x140"+extendsImgNew)%> 214w"
                             sizes="(max-width: 104px) 100vw, 104px"/>
                    </a>
                        <div class="content">
                            <a href="<%=WebConstant.getLocalHost()+"/post/"+pView.getPostSlug()%>"
                               title="<%=pView.getPostTitle()%>"><%=pView.getPostTitle()%></a>
                            <div class="cf listing-meta meta below">
                                <time datetime="<%=pView.getPostDateTimestamp()%>" class="meta-item"><%=pView.getPostDateTimestamp()%></time>
                            </div>
                        </div>
                    </li>
                    <%}%>
                </ul>
            </li>
            <li id="bunyad-social-2" class="widget widget-social">
                <ul class="social-follow" itemscope itemtype="http://schema.org/Organization">
                    <link itemprop="url" href="<%=WebConstant.getLocalHost()%>">
                    <%for (Social s:socialDao.getListSocial()){
                        String classSocial=s.getSocial_icon().replace("fa-","");
                    %>
                    <li class="service">
                        <a href="<%=s.getSocial_url()%>" class="service-link <%=classSocial%> cf"
                           target="_blank" itemprop="sameAs">
                            <i class="icon fa <%=s.getSocial_icon()%>"></i>
                            <span class="label"><%=s.getSocial_title()%></span>
                            <span class="count">970</span>
                        </a>
                    </li>
                    <%}%>
                </ul>
            </li>
            <li id="bunyad-blocks-widget-2" class="widget page-blocks">
                <h3 class="widgettitle">Tin ngẫu nhiên</h3>
                <section class="block-wrap highlights" data-id="5">
                    <div class="highlights">
                        <%int demRamdom=0;
                            List<Post> postListRandom=postDao.getListRandomInPost(4);
                            for(Post pRandom:postListRandom){
                                String extendsImgNew = pRandom.getPostImg();
                                if (extendsImgNew.contains(".")) {
                                    extendsImgNew = extendsImgNew.substring(extendsImgNew.lastIndexOf("."), extendsImgNew.length());
                                }%>
                        <article>
                            <a href="<%=WebConstant.getLocalHost()+"/post/"+pRandom.getPostSlug()%>"
                               title="<%=pRandom.getPostTitle()%>" class="image-link">
                                <img width="336" height="200"
                                     src="<%=WebConstant.getLocalHost()%><%=pRandom.getPostImg().replace(extendsImgNew,"-336x200"+extendsImgNew)%>"
                                     class="image wp-post-image" alt="<%=pRandom.getPostTitle()%>"
                                     title="<%=pRandom.getPostTitle()%>"
                                     srcset="<%=WebConstant.getLocalHost()%><%=pRandom.getPostImg().replace(extendsImgNew,"-336x200"+extendsImgNew)%> 336w"
                                     sizes="(max-width: 336px) 100vw, 336px"/>
                            </a>
                            <h2 class="post-title">
                                <a href=""
                                   title="<%=pRandom.getPostTitle()%>"><%=pRandom.getPostTitle()%></a>
                            </h2>
                            <div class="cf listing-meta meta below">
                                                <span class="meta-item author">
                                                    By <a href="author/trendy/index.html" title="Posts by <%=new UsersDao().getName(pRandom.getAuthorID())%>"
                                                          rel="author"><%=new UsersDao().getName(pRandom.getAuthorID())%></a>
                                                </span>
                                <time datetime="<%=pRandom.getPostDateTimestamp()%>" class="meta-item"><%=pRandom.getPostDateTimestamp()%></time>
                            </div>
                            <div class="excerpt">
                                <p><%String contenTomTat= tool.html2text(pRandom.getPostContent());
                                    if(contenTomTat.length()>=100){contenTomTat=contenTomTat.substring(0, 100);}%>
                                    <%=contenTomTat%><%=WebConstant.tobeContime%></p>
                            </div>
                        </article>
                        <%break;}%>
                        <ul class="block posts-list thumb">
                            <%for(Post pRandom:postListRandom){
                                String extendsImgNew = pRandom.getPostImg();
                                if (extendsImgNew.contains(".")) {
                                    extendsImgNew = extendsImgNew.substring(extendsImgNew.lastIndexOf("."), extendsImgNew.length());
                                }
                                if(demRamdom>0){%>
                            <li>
                                <a href="<%=WebConstant.getLocalHost()+"/post/"+pRandom.getPostSlug()%>">
                                    <img width="104" height="69" src="<%=WebConstant.getLocalHost()%><%=pRandom.getPostImg().replace(extendsImgNew,"-104x69"+extendsImgNew)%>"
                                         class="attachment-post-thumbnail size-post-thumbnail wp-post-image"
                                         alt="<%=pRandom.getPostTitle()%>"
                                         title="<%=pRandom.getPostTitle()%>"
                                         srcset="<%=WebConstant.getLocalHost()%><%=pRandom.getPostImg().replace(extendsImgNew,"-104x69"+extendsImgNew)%> 104w, <%=WebConstant.getLocalHost()%><%=pRandom.getPostImg().replace(extendsImgNew,"-300x200"+extendsImgNew)%> 300w, <%=WebConstant.getLocalHost()%><%=pRandom.getPostImg().replace(extendsImgNew,"-1000x667"+extendsImgNew)%> 1000w, <%=WebConstant.getLocalHost()%><%=pRandom.getPostImg().replace(extendsImgNew,"-702x459"+extendsImgNew)%> 702w, <%=WebConstant.getLocalHost()%><%=pRandom.getPostImg().replace(extendsImgNew,"-214x140"+extendsImgNew)%> 214w"
                                         sizes="(max-width: 104px) 100vw, 104px"/>
                                </a>
                                <div class="content">
                                    <a href=""><%=pRandom.getPostTitle()%></a>
                                    <div class="cf listing-meta below">
                                        <time datetime="<%=pRandom.getPostDateTimestamp()%>" class="meta-item"><%=pRandom.getPostDateTimestamp()%></time>
                                    </div>
                                </div>
                            </li>
                            <%}demRamdom++;}%>
                        </ul>
                    </div>
                </section>
            </li>
        </ul>
    </div>
</aside>
