<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
<meta name="keywords" content="图书管理系统">
<meta name="description" content="图书管理系统">
<meta name="author" content="crs811.com">
<title>图书管理系统</title>
<link rel="shortcut icon" type="image/x-icon" href="../static/LightYearAdmin/favicon.ico">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-touch-fullscreen" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="default">

<link rel="stylesheet" type="text/css" href="../static/LightYearAdmin/css/materialdesignicons.min.css">
<link rel="stylesheet" type="text/css" href="../static/LightYearAdmin/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../static/LightYearAdmin/css/animate.min.css">
<link rel="stylesheet" type="text/css" href="../static/LightYearAdmin/css/style.min.css">

<script type="text/javascript" src="../static/LightYearAdmin/js/jquery.min.js"></script>
<script type="text/javascript" src="../static/LightYearAdmin/js/popper.min.js"></script>
<script type="text/javascript" src="../static/LightYearAdmin/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../static/LightYearAdmin/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="../static/LightYearAdmin/js/jquery.cookie.min.js"></script>
<script type="text/javascript" src="../static/LightYearAdmin/js/main.min.js"></script>
<%@ page import="com.crs811.library.entity.User" %>
<%
    //获取登录人姓名
    User currentUser = (User) session.getAttribute("USER_IN_SESSION");
    request.setAttribute("currentUser", currentUser);
%>