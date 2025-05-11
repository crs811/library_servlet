<%--
  Created by IntelliJ IDEA.
  User: CRS
  Date: 6/4/2025
  Time: 18:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%
    String username = "";
    String password = "";
    boolean remember = false;

    Cookie[] cookies = request.getCookies();
    for (int i = 0; cookies != null && i < cookies.length; i++) {
        if (cookies[i].getName().equals("user_cookie")) {
            username = cookies[i].getValue().split("-")[0];
            password = cookies[i].getValue().split("-")[1];
            remember = true;
            break;
        }
    }
    if (remember) {
        pageContext.setAttribute("remember", 1);
    }
    if (username != "") {
        pageContext.setAttribute("username", username);
    }
    if (password != "") {
        pageContext.setAttribute("password", password);
    }
%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="keywords" content="LightYear,LightYearAdmin,光年,后台模板,后台管理系统,光年HTML模板">
    <meta name="description" content="Light Year Admin V4是一个基于Bootstrap v4.4.1的后台管理系统的HTML模板。">
    <meta name="author" content="yinq">
    <title>登录</title>
    <link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-touch-fullscreen" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">

    <link rel="stylesheet" type="text/css" href="static/LightYearAdmin/css/materialdesignicons.min.css">
    <link rel="stylesheet" type="text/css" href="static/LightYearAdmin/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="static/LightYearAdmin/css/animate.min.css">
    <link rel="stylesheet" type="text/css" href="static/LightYearAdmin/css/style.min.css">

    <script type="text/javascript" src="static/LightYearAdmin/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/LightYearAdmin/js/popper.min.js"></script>
    <script type="text/javascript" src="static/LightYearAdmin/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="static/LightYearAdmin/js/perfect-scrollbar.min.js"></script>
    <script type="text/javascript" src="static/LightYearAdmin/js/jquery.cookie.min.js"></script>
    <script type="text/javascript" src="static/LightYearAdmin/js/main.min.js"></script>
    <style>
        .login-form .has-feedback {
            position: relative;
        }
        .login-form .has-feedback .form-control {
            padding-left: 36px;
        }
        .login-form .has-feedback .mdi {
            position: absolute;
            top: 0;
            left: 0;
            right: auto;
            width: 36px;
            height: 36px;
            line-height: 36px;
            z-index: 4;
            color: #dcdcdc;
            display: block;
            text-align: center;
            pointer-events: none;
        }
        .login-form .has-feedback.row .mdi {
            left: 15px;
        }
    </style>
    <script type="text/javascript">
        function checkForm() {
            let username = $("#name").val();
            let password = $("#pwd").val();

            if (username == null || username === "") {
                $("#error").html("用户名不能为空");
                return false;
            }
            if (password == null || password === "") {
                $("#error").html("密码不能为空");
                return false;
            }
            return true;
        }

        // Ajax 异步登录表单
        $(function(){
            $(".ajax-post").click(function () {
                // 输入的有效性判断
                if (!checkForm()) {
                    return;
                }
                $.post(
                    "${pageContext.request.contextPath}/login",
                    $("#userForm").serialize(),
                    function(data) {
                        //返回值为 0 代表登录成功
                        if (data.code === 0) {
                            window.location = "${pageContext.request.contextPath}/index.jsp";
                            // alert('登录成功');
                        } else {
                            // alert('用户名或密码错误');
                            $('#error').html(data.msg);
                        }
                    }, 'json'
                );
            })
        });
    </script>
</head>

<body class="center-vh" style="background-image: url(static/LightYearAdmin/images/login-bg-2.jpg); background-size: cover;">
<!--页面loading-->
<div id="lyear-preloader" class="loading">
    <div class="ctn-preloader">
        <div class="round_spinner">
            <div class="spinner"></div>
            <img src="static/LightYearAdmin/images/loading-logo.png" alt="">
        </div>
    </div>
</div>
<!--页面loading end-->
<div class="card card-shadowed p-5 w-420 mb-0 mr-2 ml-2">
    <div class="text-center mb-3">
        <a href="#"> <img alt="light year admin" src="static/LightYearAdmin/images/logo-sidebar.png"> </a>
    </div>

    <%--    Ajax 登录表单 ----%>
    <form action="#" method="post" class="login-form" id="userForm" onsubmit="return false">
        <div class="form-group has-feedback">
            <span class="mdi mdi-account" aria-hidden="true"></span>
            <input type="text" class="form-control" id="name" name="username" placeholder="用户名" value="${username}">
        </div>

        <div class="form-group has-feedback">
            <span class="mdi mdi-lock" aria-hidden="true"></span>
            <input type="password" class="form-control" id="pwd" name="password" placeholder="密码" value="${password}">
        </div>

        <div class="form-group has-feedback row">
            <div class="col-7">
                <span class="mdi mdi-check-all form-control-feedback" aria-hidden="true"></span>
                <input type="text" name="captcha" class="form-control" placeholder="验证码">
            </div>
            <div class="col-5 text-right">
                <img src="static/LightYearAdmin/images/captcha.png" class="pull-right" id="captcha" style="cursor: pointer;" onclick="this.src=this.src+'?d='+Math.random();" title="点击刷新" alt="captcha">
            </div>
        </div>

        <div class="form-group">
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="rememberme" name="remember" ${remember==1?'checked':''}>
                <label class="custom-control-label not-user-select" for="rememberme">5天内自动登录</label>
                &nbsp;&nbsp;&nbsp;&nbsp;<span id="error" style="color: red; ">${error}</span>
            </div>
        </div>

        <div class="form-group">
            <input class="btn btn-block btn-primary ajax-post" type="submit" value="立即登录" target-form="login-form">
        </div>
    </form>

    <p class="text-center text-muted mb-0">Copyright © 2020 <a href="http://lyear.itshubao.com">IT书包</a>. All right reserved</p>
</div>
</body>
</html>