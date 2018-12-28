<%@ page import="vn.haui.web.command.SocialDao" %>
<%@ page import="vn.haui.web.model.Social" %>
<%@ page import="vn.haui.web.utils.FooterHeader" %>
<%@ page import="vn.haui.web.common.WebConstant" %>
<%@ page import="vn.haui.web.common.WebFooter" %>
<%@ page import="vn.haui.web.model.Post" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.haui.web.command.PostDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<%
    new FooterHeader().getFooter();
    PostDao postDao=new PostDao();
    List<Post> posts=postDao.getListProductByPagesInTerm(WebFooter.getCategory_id(),1,WebFooter.getCategory_number());
    SocialDao socialDao=new SocialDao();

%>
<footer class="main-footer">
    <div class="wrap">
        <ul class="widgets row cf">
            <li class="widget col-4 bunyad-about">
                <h3 class="widgettitle">About</h3>
                <div class="about-widget">
                    <img src="<%=WebConstant.getLocalHost()+WebFooter.getLogo()%>"/>
                    <p><%=WebFooter.getSlogan()%></p>
                    <p>Liên kết mạng xã hội:</p><br/>
                    <ul class="social-icons cf">
                    <%for (Social social:socialDao.getListSocial()){%>
                        <li><a href="<%=social.getSocial_url()%>" class="icon fa <%=social.getSocial_icon()%>" title="<%=social.getSocial_title()%>">
                                <span class="visuallyhidden"><%=social.getSocial_name()%></span>
                            </a>
                        </li>
                    <%}%>
                    </ul>
                </div>
            </li>
            <li class="widget col-4 latest-posts">
                <h3 class="widgettitle">Tin tức phổ biến</h3>
                <ul class="posts-list">
                    <%for(Post pFooter:posts){
                        String extendsImg = pFooter.getPostImg();
                        if (extendsImg.contains(".")) {
                            extendsImg = extendsImg.substring(extendsImg.lastIndexOf("."), extendsImg.length());
                        }
                    %>
                    <li>
                        <a href="<%=WebConstant.getLocalHost()+"/post/"+pFooter.getPostSlug()%>">
                            <img width="104" height="69" src="<%=WebConstant.getLocalHost()%>/<%=pFooter.getPostImg().replace(extendsImg,"-104x69"+extendsImg)%>"
                                 class="attachment-post-thumbnail size-post-thumbnail wp-post-image"
                                 alt="<%=pFooter.getPostTitle()%>"
                                 title="<%=pFooter.getPostTitle()%>"
                                 srcset="<%=WebConstant.getLocalHost()%>/<%=pFooter.getPostImg().replace(extendsImg,"-104x69"+extendsImg)%> 104w, <%=WebConstant.getLocalHost()%>/<%=pFooter.getPostImg().replace(extendsImg,"-300x200"+extendsImg)%> 300w, <%=WebConstant.getLocalHost()%>/<%=pFooter.getPostImg().replace(extendsImg,"-1000x667"+extendsImg)%> 1000w, <%=WebConstant.getLocalHost()%>/<%=pFooter.getPostImg().replace(extendsImg,"-702x459"+extendsImg)%> 702w, <%=WebConstant.getLocalHost()%>/<%=pFooter.getPostImg().replace(extendsImg,"-214x140"+extendsImg)%> 214w"
                                 sizes="(max-width: 104px) 100vw, 104px"/>
                        </a>
                        <div class="content">
                            <a href="<%=WebConstant.getLocalHost()+"/post/"+pFooter.getPostSlug()%>"
                               title="<%=pFooter.getPostTitle()%>"><%=pFooter.getPostTitle()%></a>
                            <div class="cf listing-meta meta below">
                                <time datetime="<%=pFooter.getPostDate()%>" class="meta-item"><%=pFooter.getPostDate()%></time>
                            </div>
                        </div>
                    </li>
                    <%}%>
                </ul>
            </li>
            <li class="widget col-4 bunyad-flickr">
                <h3 class="widgettitle">From Flickr</h3>
                <div class="flickr-widget">
                    <div class="flickr_badge_image">
                        <a href="http://www.flickr.com/photos/53228952@N08/43393062345/">
                            <img src="<%=WebConstant.getLocalHost()%>/images/static/43393062345_1ddb2dcc98_s.jpg" alt="Ascend"/>
                        </a>
                    </div>
                    <div class="flickr_badge_image">
                        <a href="http://www.flickr.com/photos/53228952@N08/35635796836/">
                            <img src="<%=WebConstant.getLocalHost()%>/images/static/35635796836_ca0a463fa2_s.jpg" alt="terns"/>
                        </a>
                    </div>
                    <div class="flickr_badge_image">
                        <a href="http://www.flickr.com/photos/53228952@N08/31501807183/">
                            <img src="<%=WebConstant.getLocalHost()%>/images/static/31501807183_fbf20ecb7e_s.jpg" alt="casual"/>
                        </a>
                    </div>
                    <div class="flickr_badge_image">
                        <a href="http://www.flickr.com/photos/53228952@N08/27665237533/">
                            <img src="<%=WebConstant.getLocalHost()%>/images/static/27665237533_674219b6b9_s.jpg" alt="riders on the storm"/>
                        </a>
                    </div>
                    <div class="flickr_badge_image">
                        <a href="http://www.flickr.com/photos/53228952@N08/23774500140/">
                            <img src="<%=WebConstant.getLocalHost()%>/images/static/23774500140_5a2c4858c4_s.jpg" alt="chairman"/>
                        </a>
                    </div>
                    <div class="flickr_badge_image">
                        <a href="http://www.flickr.com/photos/53228952@N08/24070220745/">
                            <img src="<%=WebConstant.getLocalHost()%>/images/static/24070220745_ffca32f781_s.jpg" alt="mood"/>
                        </a>
                    </div>
                    <div class="flickr_badge_image">
                        <a href="http://www.flickr.com/photos/53228952@N08/23702470069/">
                            <img src="<%=WebConstant.getLocalHost()%>/images/static/23702470069_c00dd38001_s.jpg" alt="monument"/>
                        </a>
                    </div>
                    <div class="flickr_badge_image">
                        <a href="http://www.flickr.com/photos/53228952@N08/23987688351/">
                            <img src="<%=WebConstant.getLocalHost()%>/images/static/23987688351_7967fb2e21_s.jpg" alt="liquid cancer"/>
                        </a>
                    </div>
                    <div class="flickr_badge_image">
                        <a href="http://www.flickr.com/photos/53228952@N08/23702464939/">
                            <img src="<%=WebConstant.getLocalHost()%>/images/static/23702464939_3178441198_s.jpg" alt="blue"/>
                        </a>
                    </div>
                    <div class="flickr_badge_image">
                        <a href="http://www.flickr.com/photos/53228952@N08/23961993242/">
                            <img src="<%=WebConstant.getLocalHost()%>/images/static/23961993242_4591cddafa_s.jpg" alt="basement"/>
                        </a>
                    </div>
                    <div class="flickr_badge_image">
                        <a href="http://www.flickr.com/photos/53228952@N08/24044103816/">
                            <img src="<%=WebConstant.getLocalHost()%>/images/static/24044103816_43d4ea4e25_s.jpg" alt="ditch"/>
                        </a>
                    </div>
                    <div class="flickr_badge_image">
                        <a href="http://www.flickr.com/photos/53228952@N08/23962165962/">
                            <img src="<%=WebConstant.getLocalHost()%>/images/static/23962165962_43b337129f_s.jpg" alt="stars"/>
                        </a>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <div class="lower-foot">
        <div class="wrap">
            <div class="widgets">
                <div class="textwidget"><a href="<%=WebConstant.getLocalHost()%>"><%=WebFooter.getCopyright()%></a>.
                </div>
                <div class="menu-footer-right-container">
                    <ul id="menu-footer-right" class="menu">
                        <li id="menu-item-143"
                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-143">
                            <a href="#">About</a>
                        </li>
                        <li id="menu-item-144"
                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-144">
                            <a href="#">Privacy</a>
                        </li>
                        <li id="menu-item-145"
                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-145">
                            <a href="#">Liên hệ</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</footer>
</div>
<script type="text/javascript" defer src="<%=WebConstant.getLocalHost()%>/js/mainjs.js"></script>
</body>
</html>
