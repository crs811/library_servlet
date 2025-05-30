<%--
  Created by IntelliJ IDEA.
  User: CRS
  Date: 27/4/2025
  Time: 19:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
  <title>错误页面 - 图书管理系统</title>
  <link rel="icon" href="static/LightYearAdmin/favicon.ico" type="image/ico">
  <meta name="keywords" content="LightYear,LightYearAdmin,光年,后台模板,后台管理系统,光年HTML模板">
  <meta name="description" content="Light Year Admin V4是一个后台管理系统的HTML模板，基于Bootstrap v4.4.1。">
  <meta name="author" content="yinqi">
  <link href="static/LightYearAdmin/css/bootstrap.min.css" rel="stylesheet">
  <link href="static/LightYearAdmin/css/materialdesignicons.min.css" rel="stylesheet">
  <link href="static/LightYearAdmin/css/style.min.css" rel="stylesheet">
  <style>
    .error-page {
      height: 100%;
      position: fixed;
      width: 100%;
    }
    .error-body {
      padding-top: 5%;
    }
    .error-body h1 {
      font-size: 210px;
      font-weight: 700;
      text-shadow: 4px 4px 0 #f5f6fa, 6px 6px 0 #868e96;
      line-height: 210px;
      color: #868e96;
    }
  </style>
</head>

<body>
<section class="error-page">
  <div class="error-box">
    <div class="error-body text-center">
      <h1>404</h1>
      <h5 class="mb-5 mt-3 text-gray">很抱歉，但是那个页面看起来已经不存在了。</h5>
      <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">返回首页</a>
    </div>
  </div>
</section>
<script type="text/javascript" src="static/LightYearAdmin/js/jquery.min.js"></script>
<script type="text/javascript" src="static/LightYearAdmin/js/bootstrap.min.js"></script>
<script type="text/javascript"></script>
</body>
</html>
