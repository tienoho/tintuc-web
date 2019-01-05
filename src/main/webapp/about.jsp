<%@ page import="vn.haui.web.common.WebConstant" %>
<%
    String result = "", error = "";
    if (session.getAttribute("result") != null) {
        result = (String) session.getAttribute("result");
        session.removeAttribute("result");
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--header--%>
<jsp:include page="header.jsp"></jsp:include>
<link href="<%=WebConstant.getLocalHost()%>/Admincp/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<%--content--%>
<div class="main wrap cf">
    <div class="row">
        <section id="about">
            <div class="container">
                <div class="center">
                    <div class="col-md-12">
                        <h2>Về chúng tôi</h2>
                        <hr>
                        <p class="lead">ThoiTrangVietNam.tk là trang thông tin về thời trang, làm đẹp cao cấp và chuyên nghiệp với danh bạ nhân vật và thương hiệu, cùng cộng đồng dành cho người đam mê thời trang, làm đẹp và các vấn đề văn hóa.<br>

                            ThoiTrangVietNam.tk  cung cấp những nội dung chính liên quan đến thế giới thời trang, làm đẹp chuyên nghiệp và những bí quyết giúp bạn luôn tự tin như một cô gái ThoiTrangVietNam.tk “Sắc sảo, sành điệu và sâu lắng”.<br>

                            Ngoài ra, ThoiTrangVietNam.tk  còn luôn cập nhật những chia sẻ ngắn, bí quyết về thời trang, làm đẹp cùng những trang phục đẹp hàng ngày, đồng thời giới thiệu những tác phẩm văn hóa, nguồn cảm hứng và các blog thú vị bình luận về phong cách sống, quan điểm sống từ biên tập viên của Phái đẹp ThoiTrangVietNam, độc giả và blogger.<br>

                            Hãy mở rộng thế giới thời trang và làm đẹp xung quanh mình mỗi ngày cùng ThoiTrangVietNam.tk .</p>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <img src="<%=WebConstant.getLocalHost()%>/upload/images/moe.jpg" class="img-responsive"/>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magni autem minus sint,
                            commodi.</p>
                    </div>
                    <!--/.col-sm-6-->
                </div>
                <!--/.row-->
            </div>
            <!--/.container-->
        </section>
        <!--/#about-->
        <section id="contact">
            <div class="contact-page">
                <div class="container">
                    <div class="col-md-6 col-md-offset-5">
                        <h2>Liên hệ</h2>
                    </div>
                    <div class="row contact-wrap">
                        <div class="col-md-8 col-md-offset-2">
                            <%if(!result.equals("")){%>
                            <div id="sendmessage"><%=result%></div>
                            <%}%>
                            <div id="errormessage"></div>
                            <form action="<%=WebConstant.getLocalHost()%>/ContactServlet" method="post" role="form" class="contactForm" >
                                <div class="form-group">
                                    <input type="text" name="name" class="form-control" id="name"
                                           placeholder="Your Name" data-rule="minlen:4"
                                           data-msg="Please enter at least 4 chars"/>
                                    <div class="validation"></div>
                                </div>
                                <div class="form-group">
                                    <input type="email" class="form-control" name="email" id="email"
                                           placeholder="Your Email" data-rule="email"
                                           data-msg="Please enter a valid email"/>
                                    <div class="validation"></div>
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" name="subject" id="subject"
                                           placeholder="Subject" data-rule="minlen:4"
                                           data-msg="Please enter at least 8 chars of subject"/>
                                    <div class="validation"></div>
                                </div>
                                <div class="form-group">
                <textarea class="form-control" name="message" rows="5" data-rule="required"
                          data-msg="Please write something for us" placeholder="Message"></textarea>
                                    <div class="validation"></div>
                                </div>
                                <div class="text-center">
                                    <input hidden="hidden" name="command" value=insert">
                                    <button type="submit" class="btn btn-primary btn-lg">Gửi liên hệ</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!--/.row-->
                </div>
                <!--/.container-->
            </div>
            <!--/#contact-page-->
        </section>
    </div>
</div>

<%--footer--%>
<jsp:include page="footer.jsp"></jsp:include>
