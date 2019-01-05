<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <link href="css/login.css" rel="stylesheet"/>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <%--<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>--%>
    <script src="js/login.js"></script>
    <!------ Include the above in your HEAD tag ---------->
    <script type="text/javascript">
        //check email
        $(document).ready(function () {
            var x_timer;
            $("#email").keyup(function (e) {
                clearTimeout(x_timer);
                var user_name = $(this).val();
                x_timer = setTimeout(function () {
                    check_username_ajax(user_name);
                }, 1000);
            });

            function check_username_ajax(email) {
                $("#user-result").html('<img src="js/ajax-loader.gif" />');
                $.post('CheckEmailServlet', {'email': email}, function (data) {
                    $("#user-result").html(data);
                });
            }
        });
    </script>
</head>
<body>
<%
    String errorL=(String)request.getAttribute("errorL");
   // String errorR=(String)request.getAttribute("errorR");
//    String actionL=(String)request.getAttribute("actionL");
//    String actionR=(String)request.getAttribute("actionR");

%>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="panel panel-login">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-12">
                            <%--class="active"--%>
                            <a href="#" class="active" id="login-form-link">Đăng nhập</a>
                        </div>
                        <%--<div class="col-xs-6">--%>
                            <%--<a href="#" <%=(actionR!=null&&actionL==null?actionR:"")%> id="register-form-link">Đăng ký</a>--%>
                        <%--</div>--%>
                    </div>
                    <hr>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <form id="login-form" action="SinupServlet" method="post" role="form" style="display: block;">
                                <div class="form-group">
                                    <p style="color: red;"><%=(errorL!=null)?errorL:""%></p>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="emailLogin" id="emailLogin" tabindex="1" class="form-control" placeholder="email" value="">
                                </div>
                                <div class="form-group">
                                    <input type="password" name="passwordLogin" id="passwordLogin" tabindex="2" class="form-control" placeholder="Password">
                                </div>
                                <div class="form-group text-center">
                                    <input type="checkbox" tabindex="3" class="" name="remember" id="remember">
                                    <label for="remember">Ghi nhớ</label>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6 col-sm-offset-3">
                                            <input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="Đăng nhập">
                                        </div>
                                    </div>
                                </div>
                                <input type="hidden" hidden="hidden" name="command" value="login"/>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="text-center">
                                                <a href="" tabindex="5" class="forgot-password">Quên mật khẩu?</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="text-center">
                                                Nếu bạn chưa có tài khoản ? hãy <a href="registered.jsp" tabindex="5" class="btn-register">Đăng ký</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <%--<form id="register-form" action="SinupServlet" method="post" role="form" style="display: none;">--%>
                                <%--<div class="form-group">--%>
                                    <%--<p style="color: red;"><%=(errorR!=null)?errorR:""%></p>--%>
                                <%--</div>--%>
                                <%--<div class="form-group">--%>
                                    <%--<input type="email" name="email" id="email" tabindex="1" class="form-control" placeholder="Địa chỉ Email" value="">--%>
                                    <%--<span id="user-result"></span>--%>
                                <%--</div>--%>
                                <%--<div class="form-group">--%>
                                    <%--<input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="Password">--%>
                                <%--</div>--%>
                                <%--<div class="form-group">--%>
                                    <%--<input type="password" name="confirm-password" id="confirm-password" tabindex="2" class="form-control" placeholder="Nhập lại Password">--%>
                                    <%--<span id="message"></span>--%>
                                <%--</div>--%>
                                <%--<div class="form-group">--%>
                                    <%--<input type="text" name="fullname" id="fullname" tabindex="2" class="form-control" placeholder="Le Van A">--%>
                                <%--</div>--%>
                                <%--<input type="hidden" hidden="hidden" name="command" value="insert"/>--%>
                                <%--<div class="form-group">--%>
                                    <%--<div class="row">--%>
                                        <%--<div class="col-sm-6 col-sm-offset-3">--%>
                                            <%--<input type="submit" name="register-submit"  id="register-submit" tabindex="4" class="form-control btn btn-register" value="Đăng ký">--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                            <%--</form>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
