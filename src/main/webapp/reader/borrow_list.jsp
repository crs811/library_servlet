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
    <script>
        function showInfo(obj) {
            alert("图书馆开放时间为: [周一至周日 8:00 - 22:00] 请尽快前往图书馆归还！")
        }
    </script>
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
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" id="r1" name="isNull" value="F" title="全部记录" checked class="custom-control-input">
                                        <label class="custom-control-label" for="r1">全部记录</label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" id="r2" name="isNull" value="T" title="所有未归还记录" class="custom-control-input">
                                        <label class="custom-control-label" for="r2">所有未归还记录</label>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">

                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>借阅者</th>
                                            <th>书名</th>
                                            <th>借出日期</th>
                                            <th>归还日期</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="BR" items="${borrowDetailList}"  >
                                            <tr>
                                                <td>${BR.nickname}</td>
                                                <td>${BR.bookName}</td>
                                                <td>${BR.borrowTime}</td>
                                                <td>${BR.returnTime}</td>
                                                <td>
                                                    <div class="btn-group">
                                                        <c:if test="${BR.returnTime==null}">
                                                        <a class="btn btn-danger btn-xs" title="归还书籍" onclick="showInfo(this)" href="javascript:">归还书籍</a>
                                                        </c:if>
                                                        <c:if test="${BR.returnTime!=null}">
                                                            <a class="btn btn-success btn-xs" title="已归还" href="javascript:">已归还</a>
                                                        </c:if>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div><!-- 分页内容 -->
                                <%@include file="../common/pagination.jsp" %>
                                <!-- 分页内容结束 -->
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
