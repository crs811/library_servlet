<%@ page import="com.crs811.library.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: CRS
  Date: 6/4/2025
  Time: 18:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<%@ page import="com.crs811.library.entity.User" %>
<%@ page import="java.util.Objects" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <%@ include file="../common/header.jsp"%>
</head>

<body>
<!--页面loading-->
<div id="lyear-preloader" class="loading">
    <div class="ctn-preloader">
        <div class="round_spinner">
            <div class="spinner"></div>
            <img src="../static/LightYearAdmin/images/loading-logo.png" alt="">
        </div>
    </div>
</div>
<!--页面loading end-->
<div class="lyear-layout-web">
    <div class="lyear-layout-container">
        <!--左侧导航-->
        <%@ include file="../common/left.jsp" %>

        <!--头部信息-->
        <%@ include file="../common/top.jsp" %>

        <!--页面主要内容-->
        <main class="lyear-layout-content">

            <div class="container-fluid p-t-15">

                <div class="row">

                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-toolbar d-flex flex-column flex-md-row">
                                <div class="toolbar-btn-action">
                                    <a class="btn btn-primary m-r-5" href="${pageContext.request.contextPath}/admin/user_register.jsp"><i class="mdi mdi-plus"></i> 新增</a>
                                    <a class="btn btn-success m-r-5 ajax-post confirm" href="http://www.lyear.com/doc_test.php" target-form="ids"><i class="mdi mdi-check"></i> 启用</a>
                                    <a class="btn btn-warning m-r-5" href="#!"><i class="mdi mdi-block-helper"></i> 禁用</a>
                                    <a class="btn btn-danger" href="#!"><i class="mdi mdi-window-close"></i> 删除</a>
                                </div>

                                <form class="search-bar ml-md-auto" method="get" action="#!" role="form">
                                    <input type="hidden" name="search_field" id="search-field" value="title" />
                                    <div class="input-group ml-md-auto">
                                        <div class="input-group-prepend">
                                            <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"
                                                    aria-haspopup="true" aria-expanded="false" id="search-btn">用户名</button>
                                            <div class="dropdown-menu" style="">
                                                <a class="dropdown-item" href="#!" data-field="title">用户名</a>
                                                <a class="dropdown-item" href="#!" data-field="cat_name">昵称</a>
                                            </div>
                                        </div>
                                        <input type="text" class="form-control" name="keyword" placeholder="请输入姓名">
                                    </div>
                                </form>
                            </div>
                            <div class="card-body">

                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>
                                                <div class="custom-control custom-checkbox">
                                                    <input type="checkbox" class="custom-control-input" id="check-all">
                                                    <label class="custom-control-label" for="check-all"></label>
                                                </div>
                                            </th>
                                            <th>用户名</th>
                                            <th style="width: 100%">昵称</th>
                                            <th>电话</th>
                                            <th>邮箱</th>
                                            <th>状态</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="U" items="${adminList}"  >
                                            <tr>
                                                <td>
                                                    <div class="custom-control custom-checkbox">
                                                        <input type="checkbox" class="custom-control-input ids" name="ids[]" value="${U.id}" id="ids-1" name="id">
                                                        <label class="custom-control-label" for="ids-1"></label>
                                                    </div>
                                                </td>
                                                <td>${U.username}</td>
                                                <td>${U.nickname}</td>
                                                <td>${U.telephone}</td>
                                                <td>${U.email}</td>
                                                <td>
                                                    <c:if test="${U.status == 0}">
                                                        <span class="badge badge-success">正常</span>
                                                    </c:if>
                                                    <c:if test="${U.status == 1}">
                                                        <span class="badge badge-danger">禁用</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <div class="btn-group">
                                                        <a class="btn btn-xs btn-default" href="${pageContext.request.contextPath}/user?method=editPage&id=${U.id}"
                                                           title="" data-toggle="tooltip" data-original-title="编辑"><i class="mdi mdi-pencil"></i></a>
                                                        <a class="btn btn-xs btn-default ajax-get confirm" href="${pageContext.request.contextPath}/user?method=deleteById&id=${U.id}&type=admin"
                                                           onclick="return confirm('确认删除 ${U.nickname} 吗？');"  title="" data-toggle="tooltip" data-original-title="删除">
                                                            <i class="mdi mdi-window-close"></i>
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <ul class="pagination">
                                    <li class="page-item disabled"><span class="page-link">上一页</span></li>
                                    <li class="page-item active"><span class="page-link">1</span></li>
                                    <li class="page-item"><a class="page-link" href="#1">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#1">3</a></li>
                                    <li class="page-item"><a class="page-link" href="#1">4</a></li>
                                    <li class="page-item"><a class="page-link" href="#1">5</a></li>
                                    <li class="page-item disabled"><span class="page-link">...</span></li>
                                    <li class="page-item"><a class="page-link" href="#!">14452</a></li>
                                    <li class="page-item"><a class="page-link" href="#!">14453</a></li>
                                    <li class="page-item"><a class="page-link" href="#!">下一页</a></li>
                                </ul>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </main>
        <!--End 页面主要内容-->
    </div>
</div>
</body>
</html>
