<%@ page import="vn.haui.web.command.CategoryDao" %>
<%@ page import="vn.haui.web.command.PostDao" %>
<%@ page import="vn.haui.web.common.WebConstant" %>
<%@ page import="vn.haui.web.model.Category" %>
<%@ page import="vn.haui.web.model.Post" %>
<%@ page import="vn.haui.web.utils.tool" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="vn.haui.web.utils.genJson" %>
<%@ page import="vn.haui.web.command.UsersDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<%
    PostDao postDao = new PostDao();
    CategoryDao categoryDao = new CategoryDao();
    Category categoryTerm=null;
    ArrayList<Category> categoriesParent = categoryDao.getListCategoryParent();
    ArrayList<Post> postsNew = postDao.getListAllPostNew(WebConstant.getPostNumberHome());
    UsersDao usersDao=new UsersDao();
%>
<div class="main-featured">
    <div class="wrap cf">
        <div class="featured-grid featured-grid-b" data-animation="fade" data-animation-speed="600"
             data-slide-delay="5000">
            <ul class="grid">
                <%
                    int dem = 0;
                    for (Post p : postDao.getListAllPostNew(4)) {
                        categoryTerm=categoryDao.getCategoryTerms(p.getPostID());
                        String extendsImg = p.getPostImg();
                        if (extendsImg.contains(".")) {
                            extendsImg = extendsImg.substring(extendsImg.lastIndexOf("."), extendsImg.length());
                        }
                        dem++;
                        if (dem == 1) {
                %>
                <li class="first">
                    <div class="item large-item">
                        <a href="<%=WebConstant.getLocalHost()%>/post/<%=p.getPostSlug()%>" class="image-link">
                            <img width="600" height="460" src="<%=WebConstant.getLocalHost()%><%=p.getPostImg()%>"
                                 class="attachment-grid-slider-b-large size-grid-slider-b-large wp-post-image"
                                 alt="<%=p.getPostTitle()%>" title="<%=p.getPostTitle()%>"
                                 srcset="<%=WebConstant.getLocalHost()%><%=p.getPostImg().replace(extendsImg,"-600x460"+extendsImg)%> 600w"
                                 sizes="(max-width: 600px) 100vw, 600px"/>
                        </a>
                        <div class="caption caption-large">
                                    <span class="cat-title cat-4">
                                        <a href="<%=WebConstant.getLocalHost()%>/Category/<%=categoryTerm.getCategorySlug()%>" title="<%=categoryTerm.getCategoryName()%>"><%=categoryTerm.getCategoryName()%></a>
                                    </span>
                            <h3><a href="<%=WebConstant.getLocalHost()%>/post/<%=p.getPostSlug()%>" class="item-heading"><%=p.getPostTitle()%></a></h3>
                            <time class="the-date" datetime="<%=p.getPostDateTimestamp()%>"><%=p.getPostDateTimestamp()%></time>
                        </div>
                    </div>
                </li>
                <li class="second">
                    <%} else if (dem == 2) {%>
                    <div class="item medium-item">
                        <a href="<%=WebConstant.getLocalHost()%>/post/<%=p.getPostSlug()%>"
                           class="image-link">
                            <img width="474" height="240" src="<%=WebConstant.getLocalHost()%><%=p.getPostImg()%>"
                                 class="attachment-grid-slider-b-med size-grid-slider-b-med wp-post-image"
                                 alt="<%=p.getPostTitle()%>" title="<%=p.getPostTitle()%>"
                                 srcset="<%=WebConstant.getLocalHost()%><%=p.getPostImg().replace(extendsImg,"-474x240"+extendsImg)%> 474w"
                                 sizes="(max-width: 474px) 100vw, 474px"/>
                        </a>
                        <div class="caption caption-small">
                                    <span class="cat-title cat-4">
                                        <a href="<%=WebConstant.getLocalHost()%>/Category/<%=categoryTerm.getCategorySlug()%>" title="<%=categoryTerm.getCategoryName()%>"><%=categoryTerm.getCategoryName()%></a>
                                    </span>
                            <h3>
                                <a href="<%=WebConstant.getLocalHost()%>/post/<%=p.getPostSlug()%>" class="item-heading heading-small"><%=p.getPostTitle()%></a>
                            </h3>
                            <time class="the-date" datetime="<%=p.getPostDateTimestamp()%>"><%=p.getPostDateTimestamp()%></time>
                        </div>
                    </div>
                    <%} else {%>
                    <div class="col-6 item small-item">
                        <a href="<%=WebConstant.getLocalHost()%>/post/<%=p.getPostSlug()%>"
                           class="image-link">
                            <img width="235" height="216" src="<%=WebConstant.getLocalHost()%>/<%=p.getPostImg()%>"
                                 class="attachment-grid-slider-b-small size-grid-slider-b-small wp-post-image"
                                 alt="<%=p.getPostTitle()%>" title="<%=p.getPostTitle()%>"
                                 srcset="<%=WebConstant.getLocalHost()%><%=p.getPostImg().replace(extendsImg,"-235x216"+extendsImg)%> 235w"
                                 sizes="(max-width: 235px) 100vw, 235px"/>
                        </a>
                        <div class="caption caption-small">
                            <span class="cat-title cat-7"><a href="<%=WebConstant.getLocalHost()%>/Category/<%=categoryTerm.getCategorySlug()%>" title="<%=categoryTerm.getCategoryName()%>"><%=categoryTerm.getCategoryName()%></a></span>
                            <h3>
                                <a href="<%=WebConstant.getLocalHost()%>/post/<%=p.getPostSlug()%>" class="item-heading heading-small"><%=p.getPostTitle()%></a>
                            </h3>
                            <time class="the-date" datetime="<%=p.getPostDateTimestamp()%>"><%=p.getPostDateTimestamp()%></time>
                        </div>
                    </div>
                    <%
                            }
                        }
                    %>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="main wrap cf">
    <div class="row">
        <div class="col-8 main-content">
            <div id="post-11" class="page-content post-11 page type-page status-publish">
                <section class="block-wrap highlights highlights-b" data-id="1">
                    <div class="block-head">
                        <h3 class="heading">Bài viết mới nhất</h3>
                        <ul class="subcats filters">
                            <li><a href="#" data-id="0" class="active">All</a></li>
                            <%for (Category c : categoriesParent) {%>
                            <li><a href="<%=WebConstant.getLocalHost()%>/Category/<%=c.getCategorySlug()%>"
                                   data-id="<%=c.getCategoryID()%>"><%=c.getCategoryName()%>
                            </a></li>
                            <%}%>
                        </ul>
                    </div>
                    <div class="block-content">
                        <div class="container cf">
                            <div class="large b-row cf">
                                <%int demPost = 0;
                                for (Post p : postsNew) {
                                        demPost++;
                                        String extendsImgNew = p.getPostImg();
                                        if (extendsImgNew.contains(".")) {
                                            extendsImgNew = extendsImgNew.substring(extendsImgNew.lastIndexOf("."), extendsImgNew.length());
                                        }
                                %>
                                <div class="column half b-col">
                                    <article>
                                        <a href="<%=WebConstant.getLocalHost()%>/post/<%=p.getPostSlug()%>"
                                           title="<%=p.getPostTitle()%>"
                                           class="image-link">
                                            <img width="336" height="200"
                                                 src="<%=WebConstant.getLocalHost()%><%=p.getPostImg()%>"
                                                 class="image wp-post-image"
                                                 alt="<%=p.getPostImg().substring(p.getPostImg().lastIndexOf("/"))%>"
                                                 title="<%=p.getPostTitle()%>"
                                                 srcset="<%=WebConstant.getLocalHost()%><%=p.getPostImg().replace(extendsImgNew,"-336x200"+extendsImgNew)%> 336w"
                                                 sizes="(max-width: 336px) 100vw, 336px"/>
                                        </a>
                                        <h2 class="post-title">
                                            <a href="<%=WebConstant.getLocalHost()%>/post/<%=p.getPostSlug()%>"
                                               title="<%=p.getPostTitle()%>"><%=p.getPostTitle()%>
                                            </a>
                                        </h2>
                                        <div class="cf listing-meta meta below">
                                            <span class="meta-item author">Bởi <a
                                                    href="author/trendy/index.html" title="Posts by <%=usersDao.getName(p.getAuthorID())%>"
                                                    rel="author"><%=usersDao.getName(p.getAuthorID())%></a>
                                            </span>
                                            <time datetime="<%=p.getPostDateTimestamp()%>" class="meta-item"><%=p.getPostDateTimestamp()%>
                                            </time>
                                        </div>
                                        <div class="excerpt">
                                            <p>
                                                <%String contenTomTat=tool.html2text(p.getPostContent());
                                                if(contenTomTat.length()>=50){contenTomTat=contenTomTat.substring(0, 50);}%>
                                                <%=contenTomTat%><%=WebConstant.tobeContime%>
                                            </p>
                                        </div>
                                    </article>
                                </div>
                                <%if (demPost == 2) {break;}}%>
                            </div>
                            <ul class="b-row posts-list thumb">
                                <%
                                    int demPost2 = 0;
                                    for (Post p : postsNew) {
                                        demPost2++;
                                        if (demPost2 > 2) {
                                            String extendsImgNew = p.getPostImg();
                                            if (extendsImgNew.contains(".")) {
                                                extendsImgNew = extendsImgNew.substring(extendsImgNew.lastIndexOf("."), extendsImgNew.length());
                                            }
                                %>
                                <li class="column half b-col">
                                    <article class="post cf">
                                        <a href="<%=WebConstant.getLocalHost()%>/post/<%=p.getPostSlug()%>"
                                           class="image-link">
                                            <img width="104" height="69"
                                                 src="<%=WebConstant.getLocalHost()%><%=p.getPostImg()%>"
                                                 class="<%=p.getPostImg().substring(p.getPostImg().lastIndexOf("/"))%>"
                                                 alt="StockSnap_HBI15KEJR3"
                                                 title="<%=p.getPostTitle()%>"
                                                 srcset="<%=WebConstant.getLocalHost()%><%=p.getPostImg().replace(extendsImgNew,"-104x69"+extendsImgNew)%> 104w, <%=WebConstant.getLocalHost()%><%=p.getPostImg().replace(extendsImgNew,"-300x200"+extendsImgNew)%> 300w, <%=WebConstant.getLocalHost()%><%=p.getPostImg().replace(extendsImgNew,"-1000x667"+extendsImgNew)%> 1000w, <%=WebConstant.getLocalHost()%><%=p.getPostImg().replace(extendsImgNew,"-702x459"+extendsImgNew)%> 702w, <%=WebConstant.getLocalHost()%><%=p.getPostImg().replace(extendsImgNew,"-214x140"+extendsImgNew)%> 214w"
                                                 sizes="(max-width: 104px) 100vw, 104px"/>
                                        </a>
                                        <div class="content"><a
                                                href="<%=WebConstant.getLocalHost()%>/post/<%=p.getPostSlug()%>"
                                                title="<%=p.getPostTitle()%>"><%=p.getPostTitle()%>
                                        </a>
                                            <div class="cf listing-meta below">
                                                <time datetime="<%=p.getPostDateTimestamp()%>"
                                                      class="meta-item"><%=p.getPostDateTimestamp()%>
                                                </time>
                                            </div>
                                        </div>
                                    </article>
                                </li>
                                <%
                                        }
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                </section>
                <section class="block-wrap blog" data-id="2">
                    <div class="block-head cat-text-12">
                        <%
                            Category categorySubContent= null;
                            try {
                                categorySubContent = categoryDao.getCategory(WebConstant.getCategorySubOne());
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                        <h3 class="heading"><a href="<%=WebConstant.getLocalHost()+"/Category/"+categorySubContent.getCategorySlug()%>"><%=categorySubContent.getCategoryName()%></a></h3>
                        <ul class="subcats filters">
                            <li><a href="#" data-id="0" class="active">Tất cả</a></li>
                            <%for (Category cSub:categoryDao.getListCategoryChildren(WebConstant.getCategorySubOne())){%>
                            <li><a href="" data-id="<%=cSub.getCategoryID()%>"><%=cSub.getCategoryName()%></a></li>
                            <%}%>
                        </ul>
                    </div>
                    <div class="block-content">
                        <div class="row b-row listing meta-below grid-2">
                            <%for(Post pSub:postDao.getListProductByPagesInTermChildren(WebConstant.getCategorySubOne(),1,WebConstant.getPostNumberHomeSub())){
                                String extendsImgNew = pSub.getPostImg();
                                if (extendsImgNew.contains(".")) {
                                    extendsImgNew = extendsImgNew.substring(extendsImgNew.lastIndexOf("."), extendsImgNew.length());
                                }%>
                            <div class="column half b-col">
                                <article class="highlights post-<%=pSub.getPostID()%> post type-post status-publish format-standard has-post-thumbnail category-entertainment category-leisure category-opinion tag-culture tag-fashion tag-fitness tag-leisure tag-lifestyle">
                                    <a href="<%=WebConstant.getLocalHost()+"/post/"+pSub.getPostSlug()%>"
                                       title="<%=pSub.getPostTitle()%>" class="image-link">
                                        <img width="336" height="200"
                                             src="<%=WebConstant.getLocalHost()%><%=pSub.getPostImg().replace(extendsImgNew,"-336x200"+extendsImgNew)%>"
                                             class="image wp-post-image" alt="<%=pSub.getPostImg()%>"
                                             title="<%=pSub.getPostTitle()%>"
                                             srcset="<%=WebConstant.getLocalHost()%><%=pSub.getPostImg().replace(extendsImgNew,"-336x200"+extendsImgNew)%> 336w"
                                             sizes="(max-width: 336px) 100vw, 336px"/> </a>
                                    <h2 class="post-title">
                                        <a href="<%=WebConstant.getLocalHost()+"/post/"+pSub.getPostSlug()%>"><%=pSub.getPostTitle()%></a>
                                    </h2>
                                    <div class="cf listing-meta meta below">
                                                <span class="meta-item author">
                                                    By <a href="" title="Posts by <%=usersDao.getName(pSub.getAuthorID())%>"
                                                          rel="author"><%=usersDao.getName(pSub.getAuthorID())%></a>
                                                </span>
                                        <time datetime="<%=pSub.getPostDateTimestamp()%>" class="meta-item"><%=pSub.getPostDateTimestamp()%></time>
                                    </div>
                                    <div class="excerpt">
                                        <p><%String contenTomTat=tool.html2text(pSub.getPostContent());
                                            if(contenTomTat.length()>=50){contenTomTat=contenTomTat.substring(0, 50);}%>
                                            <%=contenTomTat%><%=WebConstant.tobeContime%>
                                        </p>
                                    </div>
                                </article>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </section>

                <section class="block-wrap blog" data-id="3">
                    <div class="block-head cat-text-11">
                        <h3 class="heading">
                            <a href="">From Beauty</a>
                        </h3>
                    </div>
                    <div class="block-content">
                        <div class="row listing grid-overlay tall-overlay">
                            <div class="column one-third">
                                <article
                                        class="post-78 post type-post status-publish format-standard has-post-thumbnail category-beauty tag-culture tag-fashion tag-fitness tag-leisure tag-lifestyle">
                                    <a href=""
                                       class="image-link">
                                        <img width="233" height="300"
                                             src="<%=WebConstant.getLocalHost()%>/upload/images/18528837284_effa27b50a_o-233x300.jpg"
                                             class="image wp-post-image" alt="18528837284_effa27b50a_o"
                                             title="L.A.&#8217;s 6 Coolest Haircuts — &#038; How To Style Them In Shortest Time"
                                             srcset="<%=WebConstant.getLocalHost()%>/upload/images/18528837284_effa27b50a_o-233x300.jpg 233w, <%=WebConstant.getLocalHost()%>/upload/images/18528837284_effa27b50a_o.jpg 691w"
                                             sizes="(max-width: 233px) 100vw, 233px"/>
                                    </a>
                                    <div class="overlay">
                                        <h2 class="post-title">
                                            <a href="="
                                               title="L.A.&#8217;s 6 Coolest Haircuts — &#038; How To Style Them In Shortest Time">L.A.&#8217;s
                                                6 Coolest Haircuts — &#038; How To Style Them In Shortest Time</a>
                                        </h2>
                                        <div class="cf listing-meta meta below">
                                            <time datetime="2017-01-08T02:18:37+00:00" class="meta-item">January 8,
                                                2017
                                            </time>
                                        </div>
                                    </div>
                                </article>
                            </div>
                            <div class="column one-third">
                                <article
                                        class="post-82 post type-post status-publish format-standard has-post-thumbnail category-beauty tag-culture tag-fashion tag-fitness tag-leisure tag-lifestyle">
                                    <a href=""
                                       class="image-link">
                                        <img width="233" height="300"
                                             src="<%=WebConstant.getLocalHost()%>/upload/images/FreeGreatPicture.com-26872-fashion-model-233x300.jpg"
                                             class="image wp-post-image"
                                             alt="FreeGreatPicture.com-26872-fashion-model"
                                             title="Wear This Colorful Eye Look To Your Next Party &#038; Be Awesome"
                                             srcset="<%=WebConstant.getLocalHost()%>/upload/images/FreeGreatPicture.com-26872-fashion-model-233x300.jpg 233w"
                                             sizes="(max-width: 233px) 100vw, 233px"/>
                                    </a>
                                    <div class="overlay">
                                        <h2 class="post-title">
                                            <a href=""
                                               title="Wear This Colorful Eye Look To Your Next Party &#038; Be Awesome">Wear
                                                This Colorful Eye Look To Your Next Party &#038; Be Awesome</a>
                                        </h2>
                                        <div class="cf listing-meta meta below">
                                            <time datetime="2017-01-08T02:17:37+00:00" class="meta-item">January 8,
                                                2017
                                            </time>
                                        </div>
                                    </div>
                                </article>
                            </div>
                            <div class="column one-third">
                                <article
                                        class="post-84 post type-post status-publish format-standard has-post-thumbnail category-beauty tag-culture tag-fashion tag-fitness tag-leisure tag-lifestyle">
                                    <a href=""
                                       class="image-link">
                                        <img width="233" height="300"
                                             src="<%=WebConstant.getLocalHost()%>/upload/images/1shutterstock_66981412-233x300.jpg"
                                             class="image wp-post-image" alt="1shutterstock_66981412"
                                             title="Exclusive: Jane Allure Shows Us The New Foam Dry Shampoo"
                                             srcset="<%=WebConstant.getLocalHost()%>/upload/images/1shutterstock_66981412-233x300.jpg 233w, <%=WebConstant.getLocalHost()%>/upload/images/1shutterstock_66981412-777x1000.jpg 777w"
                                             sizes="(max-width: 233px) 100vw, 233px"/>
                                    </a>
                                    <div class="overlay">
                                        <h2 class="post-title">
                                            <a href=""
                                               title="Exclusive: Jane Allure Shows Us The New Foam Dry Shampoo">Exclusive:
                                                Jane Allure Shows Us The New Foam Dry Shampoo</a>
                                        </h2>
                                        <div class="cf listing-meta meta below">
                                            <time datetime="2017-01-08T02:16:37+00:00" class="meta-item">January 8,
                                                2017
                                            </time>
                                        </div>
                                    </div>
                                </article>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="block-wrap blog" data-id="4">
                    <div class="block-head cat-text-4">
                        <h3 class="heading">
                            <%Category categorySubOne=categoryDao.getCategory(WebConstant.getCategorySubOne());%>
                            <a href="<%=WebConstant.getLocalHost()+"/Category/"+categorySubOne.getCategorySlug()%>"><%=categorySubOne.getCategoryName()%></a>
                        </h3>
                    </div>
                    <div class="block-content">
                        <div class="posts-list listing-alt">
                            <%for (Post pSection4:postDao.getListProductByPagesInTerm(WebConstant.getCategorySubOne(),1,4)){
                                String extendsImgNew = pSection4.getPostImg();
                                if (extendsImgNew.contains(".")) {
                                    extendsImgNew = extendsImgNew.substring(extendsImgNew.lastIndexOf("."), extendsImgNew.length());
                                }
                            %>
                            <article class="post-<%=pSection4.getPostID()%> post type-post status-publish format-standard has-post-thumbnail category-fashion tag-culture tag-fashion tag-fitness tag-leisure tag-lifestyle">
                                <div class="post-wrap">
                                    <a href="<%=WebConstant.getLocalHost()+"/post/"+pSection4.getPostSlug()%>"
                                        class="image-link">
                                        <img width="312" height="198"
                                          src="<%=WebConstant.getLocalHost()%><%=pSection4.getPostImg().replace(extendsImgNew,"-336x200"+extendsImgNew)%>"
                                          class="attachment-list-block size-list-block wp-post-image"
                                          alt="<%=pSection4.getPostImg()%>"
                                          title="<%=pSection4.getPostTitle()%>"
                                          srcset="<%=WebConstant.getLocalHost()%><%=pSection4.getPostImg().replace(extendsImgNew,"-336x200"+extendsImgNew)%> 312w, <%=WebConstant.getLocalHost()%><%=pSection4.getPostImg().replace(extendsImgNew,"-163x102"+extendsImgNew)%> 163w"
                                          sizes="(max-width: 312px) 100vw, 312px"/> </a>
                                    <div class="content">
                                        <a href="<%=WebConstant.getLocalHost()+"/post/"+pSection4.getPostSlug()%>" class="post-title"><%=pSection4.getPostTitle()%></a>
                                        <div class="cf listing-meta meta below"><span class="meta-item author">By <a
                                                href="author/trendy/index.html" title="Posts by <%=usersDao.getName(pSection4.getAuthorID())%>" rel="author"><%=usersDao.getName(pSection4.getAuthorID())%></a></span>
                                            <time datetime="<%=pSection4.getPostDateTimestamp()%>" class="meta-item"><%=pSection4.getPostDateTimestamp()%></time>
                                        </div>
                                        <div class="excerpt"><p>
                                            <%String contenTomTat=tool.html2text(pSection4.getPostContent());
                                                if(contenTomTat.length()>=200){contenTomTat=contenTomTat.substring(0, 50);}%>
                                            <%=contenTomTat%><%=WebConstant.tobeContime%>
                                        </p></div>
                                    </div>
                                </div>
                            </article>
                            <%}%>
                        </div>
                    </div>
                </section>

            </div>
        </div>
        <jsp:include page="sidebar.jsp"/>
    </div>
</div>

<script>// Preloaded sub-block content
var bunyad_preload =<%=new genJson().jsonObject().toJSONString()%>;</script>