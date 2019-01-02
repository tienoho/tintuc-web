<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="vn.haui.web.command.CategoryDao" %>
<%@ page import="vn.haui.web.common.WebConstant" %>
<%@ page import="vn.haui.web.model.Category" %>
<%@ page import="vn.haui.web.model.Users" %>
<%@ page import="vn.haui.web.model.Social" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.haui.web.command.SocialDao" %>
<%@ page import="vn.haui.web.utils.SettingConfig" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi-VN">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link type="text/css" media="all" href="<%=WebConstant.getLocalHost()%>/css/style.css" rel="stylesheet"/>
    <link rel="icon" href="<%=WebConstant.getLocalHost()+"/"+WebConstant.getxImagePath_icon()%>">
    <%
        Users users = null;
        new SettingConfig().getSettingStart();
        if (session.getAttribute("user") != null) {
            users = (Users) session.getAttribute("user");
        }
        CategoryDao categoryDao = new CategoryDao();
        String head_title = "";
        if (session.getAttribute("head_title") != null) {
            head_title = (String) session.getAttribute("head_title");
            session.removeAttribute("head_title");
        }
        List<Social> socialList=new SocialDao().getListSocial();
    %>
    <%if (!head_title.equals("")) {%>
    <title><%=head_title%> - <%=WebConstant.getBlogname()%>
    </title>
    <%} else {%>
    <title><%=WebConstant.getBlogname()%> - <%=WebConstant.getBlogdescription()%>
    </title>
    <%}%>
    <script type='text/javascript' src='<%=WebConstant.getLocalHost()%>/js/jquery.js'></script>
    <script>document.querySelector('head').innerHTML += '<style class="bunyad-img-effects-css">.main img, .main-footer img { opacity: 0; }</style>';</script>
    <script>
        // Hàm khởi tạo đồng hồ
        function startTime() {
            // Lấy Object ngày hiện tại
            var today = new Date();
            //lấy ngày, tháng, năm
            var day = today.getDay();var date = today.getDate();var month = today.getMonth();
            var year = today.getFullYear();
            // Giờ, phút, giây hiện tại
            var h = today.getHours();var m = today.getMinutes();var s = today.getSeconds();
            // Chuyển đổi sang dạng 01, 02, 03
            m = checkTime(m);
            s = checkTime(s);
            // Ghi ra trình duyệt
            document.getElementById('timer').innerHTML = h + ":" + m + ":" + s + " | " + getDay(day) + ", " + date + "/" + month + "/" + year;
            // Dùng hàm setTimeout để thiết lập gọi lại 0.5 giây / lần
            var t = setTimeout(function () {
                startTime();
            }, 500);
        }
        // Hàm này có tác dụng chuyển những số bé hơn 10 thành dạng 01, 02, 03, ...
        function checkTime(i) {if (i < 10) {i = "0" + i;}return i;}
        //hàm lấy thứ trong tuần
        function getDay(i) {switch (i) {case 0:return "Chủ nhật";case 1:return "Thứ 2";case 2:return "Thứ 3";case 3:return "Thứ 4";case 4:return "Thứ 5";case 5:return "Thứ 6";case 6:return "Thứ 7";}}
    </script>
</head>
<body onload="startTime()"
      class="home page-template page-template-page-blocks page-template-page-blocks-php page page-id-11 page-builder right-sidebar full skin-tech has-featured img-effects has-nav-light-b has-nav-full has-head-tech has-mobile-head">
<div class="main-wrap">
    <div class="top-bar dark">
        <div class="wrap">
            <section class="top-bar-content cf">
                <span id="timer" class="date">  </span>
                <div class="menu-top-nav-container">
                    <ul id="menu-top-nav" class="menu">
                        <%if (users != null) {%>
                        <li id="menu-item-4"
                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-4">
                            <a href="#"><%=users.getFullName()%></a>
                        </li>
                        <%} else {%>
                        <li id="menu-item-4"
                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-4">
                            <a href="<%=WebConstant.getLocalHost()%>/login">Đăng nhập</a>
                        </li>
                        <%}%>
                        <li id="menu-item-5"
                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-5">
                            <a href="#">Forums</a>
                        </li>
                        <li id="menu-item-7"
                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-7">
                            <a href="#">Contact</a>
                        </li>
                        <%if (users != null) {%>
                        <li id="menu-item-4"
                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-4">
                            <a href="<%=WebConstant.getLocalHost()%>/logout">Đăng xuất</a>
                        </li>
                        <%}%>
                    </ul>
                </div>
                <div class="textwidget">
                    <ul class="social-icons cf">
                        <%for (Social s:socialList){%>
                        <li><a href="<%=s.getSocial_url()%>" class="icon fa <%=s.getSocial_icon()%>" title="<%=s.getSocial_title()%>">
                                <span class="visuallyhidden"><%=s.getSocial_name()%></span>
                            </a>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </section>
        </div>
    </div>
    <div id="main-head" class="main-head">
        <div class="wrap">
            <div class="mobile-head">
                <div class="menu-icon"><a href="#"><i class="fa fa-bars"></i></a></div>
                <div class="title">
                    <a href="<%=WebConstant.getLocalHost()%>/" title="<%=WebConstant.getBlogname()%>" rel="home" class="is-logo-mobile">
                        <img src="<%=WebConstant.getLocalHost()+WebConstant.getxImagePath_logo_mobile()%>" class="logo-mobile" width="0" height="0"/>
                        <img src="<%=WebConstant.getLocalHost()+WebConstant.getxImagePath_logo()%>" class="logo-image" alt="<%=WebConstant.getBlogname()%>"
                             srcset="<%=WebConstant.getLocalHost()+WebConstant.getxImagePath_logo()%> ,<%=WebConstant.getLocalHost()+WebConstant.getxImagePath_logo_2x()%> 2x"/>
                    </a>
                </div>
                <div class="search-overlay">
                    <a href="#" title="Search" class="search-icon"><i class="fa fa-search"></i></a>
                </div>
            </div>
            <header class="tech">
                <div class="title">
                    <a href="<%=WebConstant.getLocalHost()%>" title="Website tin tức" rel="home" class="is-logo-mobile">
                        <img src="<%=WebConstant.getLocalHost()+WebConstant.getxImagePath_logo_mobile()%>" class="logo-mobile" width="0" height="0"/>
                        <img src="<%=WebConstant.getLocalHost()+WebConstant.getxImagePath_logo()%>" class="logo-image" alt="<%=WebConstant.getBlogname()%>"
                             srcset="<%=WebConstant.getLocalHost()+WebConstant.getxImagePath_logo_2x()%> ,<%=WebConstant.getLocalHost()+WebConstant.getxImagePath_logo_2x()%> 2x"/>
                    </a>
                </div>
                <div class="right">
                    <div class="a-widget">
                        <a href="<%=WebConstant.getUrl_banner_header()%>">
                            <img src="<%=WebConstant.getLocalHost()+WebConstant.getBanner_header()%>" width="728" height="90" alt="Banner"/>
                        </a>
                    </div>
                </div>
            </header>
        </div>
        <div class="main-nav">
            <div class="navigation-wrap cf" data-sticky-nav="1" data-sticky-type="smart">
                <nav class="navigation cf nav-full has-search nav-light nav-light-b">
                    <div class="wrap">
                        <div class="mobile" data-type="off-canvas" data-search="1">
                            <a href="#" class="selected">
                                <span class="text">Navigate</span>
                                <span class="current"></span>
                                <i class="hamburger fa fa-bars"></i>
                            </a>
                        </div>
                        <div class="menu-main-menu-container">
                            <ul id="menu-main-menu" class="menu">
                                <li id="menu-item-8"
                                    class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children menu-item-8">
                                    <a href="#"><i class="fa fa-bars only-icon"></i></a>
                                    <ul class="sub-menu">
                                        <%for (Category category : categoryDao.getListCategory()) {%>
                                        <li id="menu-item-<%=category.getCategoryID()%>"
                                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-<%=category.getCategoryID()%>">
                                            <a href="<%=WebConstant.getLocalHost()%>/Category/<%=category.getCategorySlug()%>"><%=category.getCategoryName()%></a>
                                        </li>
                                        <%}%>
                                    </ul>
                                </li>
                                <li id="menu-item-home"
                                    class="menu-item menu-item-type-custom menu-item-object-custom current-menu-item current_page_item menu-item-home menu-item-10">
                                    <a href="<%=WebConstant.getLocalHost()%>">Home</a>
                                </li>
                                <%for (Category cMenu : categoryDao.getListCategoryParent()) {%>
                                <li id="menu-item-<%=cMenu.getCategoryID()%>"
                                    class="menu-item menu-item-type-custom menu-item-object-custom current-menu-ancestor menu-item-has-children menu-item-<%=cMenu.getCategoryID()%>">
                                    <a href="<%=WebConstant.getLocalHost()%>/Category/<%=cMenu.getCategorySlug()%>"><%=cMenu.getCategoryName()%></a>
                                    <ul class="sub-menu">
                                        <%for (Category cSubMenu : categoryDao.getListCategoryChildren(cMenu.getCategoryID())) {%>
                                        <li id="menu-item-<%=cSubMenu.getCategoryID()%>"
                                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children menu-item-<%=cSubMenu.getCategoryID()%>">
                                            <a href="<%=WebConstant.getLocalHost()%>/Category/<%=cSubMenu.getCategorySlug()%>"><%=cSubMenu.getCategoryName()%>
                                            </a>
                                            <ul class="sub-menu">
                                                <%for (Category cSub2Menu : categoryDao.getListCategoryChildren(cSubMenu.getCategoryID())) {%>
                                                <li id="menu-item-<%=cSub2Menu.getCategoryID()%>"
                                                    class="menu-item menu-item-type-custom menu-item-object-custom menu-item-<%=cSub2Menu.getCategoryID()%>">
                                                    <a href="<%=WebConstant.getLocalHost()%>/Category/<%=cSub2Menu.getCategorySlug()%>"><%=cSub2Menu.getCategoryName()%>
                                                    </a>
                                                </li>
                                                <%}%>
                                            </ul>
                                        </li>
                                        <%}%>
                                    </ul>
                                </li>
                                <%}%>
                                <li id="menu-item-38"
                                    class="menu-item menu-item-type-taxonomy menu-item-object-category menu-item-has-children menu-cat-4 menu-item-38">
                                    <a href="category/fashion/index.html">Fashion</a>
                                    <div class="mega-menu row">
                                        <div class="col-3 sub-cats">
                                            <ol class="sub-nav">
                                                <li id="menu-item-44"
                                                    class="menu-item menu-item-type-taxonomy menu-item-object-category menu-cat-11 menu-item-44">
                                                    <a href="category/beauty/index.html">Beauty</a>
                                                </li>
                                                <li id="menu-item-257"
                                                    class="menu-item menu-item-type-taxonomy menu-item-object-category menu-cat-18 menu-item-257">
                                                    <a href="category/lifestyle/index.html">Lifestyle</a>
                                                </li>
                                                <li id="menu-item-256"
                                                    class="menu-item menu-item-type-taxonomy menu-item-object-category menu-cat-9 menu-item-256">
                                                    <a href="category/leisure/travel/index.html">Travel</a>
                                                </li>
                                                <li id="menu-item-46"
                                                    class="menu-item menu-item-type-taxonomy menu-item-object-category menu-cat-10 menu-item-46">
                                                    <a href="category/fitness/index.html">Fitness</a>
                                                </li>
                                            </ol>
                                        </div>
                                        <div class="col-9 extend">
                                            <section class="col-6 featured">
                                                <span class="heading">Featured</span>
                                                <div class="highlights">
                                                    <article>
                                                        <a href="2017/01/08/summer-style-chunky-knit-for-leather-suits-2/index.html"
                                                           title="Summer Style: Chunky Knit For Leather Suits"
                                                           class="image-link">
                                                            <img width="336" height="200"
                                                                 src="<%=WebConstant.getLocalHost()%>/images/shutterstock_350007890-336x200.jpg"
                                                                 class="image wp-post-image"
                                                                 alt="shutterstock_350007890"
                                                                 title="Summer Style: Chunky Knit For Leather Suits"
                                                                 srcset="<%=WebConstant.getLocalHost()%>/images/shutterstock_350007890-336x200.jpg 336w"
                                                                 sizes="(max-width: 336px) 100vw, 336px"/>
                                                        </a>
                                                        <h2 class="post-title">
                                                            <a href="2017/01/08/summer-style-chunky-knit-for-leather-suits-2/index.html"
                                                               title="Summer Style: Chunky Knit For Leather Suits">
                                                                Summer Style: Chunky Knit For Leather Suits
                                                            </a>
                                                        </h2>
                                                        <div class="cf listing-meta meta below">
                                                                <span class="meta-item author">
                                                                    By <a href="author/trendy/index.html" title="Posts by Kate Hanson" rel="author">Kate Hanson</a>
                                                                </span>
                                                            <time datetime="2017-01-08T02:30:37+00:00" class="meta-item">
                                                                January 8, 2017
                                                            </time>
                                                        </div>
                                                    </article>
                                                </div>
                                            </section>
                                            <section class="col-6 recent-posts">
                                                <span class="heading">Recent</span>
                                                <div class="posts-list">
                                                    <div class="post">
                                                        <a href="">
                                                            <img width="104" height="69"
                                                                 src="<%=WebConstant.getLocalHost()%>/images/shutterstock_536935141-104x69.jpg"
                                                                 class="attachment-post-thumbnail size-post-thumbnail wp-post-image"
                                                                 alt="shutterstock_536935141"
                                                                 title="Fashion Chic X Mejuri Jewelry Collection of 2017"
                                                                 srcset="<%=WebConstant.getLocalHost()%>/images/shutterstock_536935141-104x69.jpg 104w, <%=WebConstant.getLocalHost()%>/images/shutterstock_536935141-300x196.jpg 300w, <%=WebConstant.getLocalHost()%>/images/shutterstock_536935141-1000x653.jpg 1000w, <%=WebConstant.getLocalHost()%>/images/shutterstock_536935141-702x459.jpg 702w, <%=WebConstant.getLocalHost()%>/images/shutterstock_536935141-214x140.jpg 214w"
                                                                 sizes="(max-width: 104px) 100vw, 104px"/>
                                                        </a>
                                                        <div class="content">
                                                            <a href="">Fashion Chic X Mejuri Jewelry Collection of 2017</a>
                                                            <div class="cf listing-meta meta below">
                                                                <time datetime="2017-01-08T02:34:37+00:00" class="meta-item"> January 8, 2017 </time>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="post">
                                                        <a href="">
                                                            <img width="104" height="69"
                                                                 src="<%=WebConstant.getLocalHost()%>/images/shutterstock_518581786-104x69.jpg"
                                                                 class="attachment-post-thumbnail size-post-thumbnail wp-post-image"
                                                                 alt="shutterstock_518581786"
                                                                 title="Trending: Bodysuits and Faded Friendship Jeans"
                                                                 srcset="<%=WebConstant.getLocalHost()%>/images/shutterstock_518581786-104x69.jpg 104w, <%=WebConstant.getLocalHost()%>/images/shutterstock_518581786-300x200.jpg 300w, <%=WebConstant.getLocalHost()%>/images/shutterstock_518581786-1000x667.jpg 1000w, <%=WebConstant.getLocalHost()%>/images/shutterstock_518581786-702x459.jpg 702w, <%=WebConstant.getLocalHost()%>/images/shutterstock_518581786-214x140.jpg 214w, <%=WebConstant.getLocalHost()%>/images/shutterstock_518581786-104x69@2x.jpg 208w"
                                                                 sizes="(max-width: 104px) 100vw, 104px"/>
                                                        </a>
                                                        <div class="content">
                                                            <a href=""> Trending: Bodysuits and Faded Friendship Jeans </a>
                                                            <div class="cf listing-meta meta below">
                                                                <time datetime="2017-01-08T02:33:37+00:00" class="meta-item"> January 8, 2017 </time>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="post">
                                                        <a href="">
                                                            <img width="104" height="69"
                                                                 src="<%=WebConstant.getLocalHost()%>/images/shutterstock_350007890-104x69.jpg"
                                                                 class="attachment-post-thumbnail size-post-thumbnail wp-post-image"
                                                                 alt="shutterstock_350007890"
                                                                 title="Summer Style: Chunky Knit For Leather Suits"
                                                                 srcset="<%=WebConstant.getLocalHost()%>/images/shutterstock_350007890-104x69.jpg 104w, <%=WebConstant.getLocalHost()%>/images/shutterstock_350007890-300x200.jpg 300w, <%=WebConstant.getLocalHost()%>/images/shutterstock_350007890-1000x667.jpg 1000w, <%=WebConstant.getLocalHost()%>/images/shutterstock_350007890-702x459.jpg 702w, <%=WebConstant.getLocalHost()%>/images/shutterstock_350007890-214x140.jpg 214w"
                                                                 sizes="(max-width: 104px) 100vw, 104px"/>
                                                        </a>
                                                        <div class="content">
                                                            <a href=""> Summer Style: Chunky Knit For Leather Suits </a>
                                                            <div class="cf listing-meta meta below">
                                                                <time datetime="2017-01-08T02:30:37+00:00" class="meta-item">
                                                                    January 8, 2017
                                                                </time>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <div class="nav-search nav-light-search wrap">
                    <div class="search-overlay">
                        <a href="#" title="Search" class="search-icon"><i class="fa fa-search"></i></a>
                        <div class="search">
                            <form role="search" action="<%=WebConstant.getLocalHost()%>/Search" method="get">
                                <input type="text" name="s" class="query live-search-query" value=""
                                       placeholder="Search..."/>
                                <button class="search-button" type="submit">
                                    <i class="fa fa-search"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="breadcrumbs-wrap">
        <div class="wrap">
        </div>
    </div>