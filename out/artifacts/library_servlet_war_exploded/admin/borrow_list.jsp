<%@ page import="com.crs811.library.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: CRS
  Date: 6/4/2025
  Time: 18:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false"%>
<%@ page import="com.crs811.library.entity.User" %>
<%@ page import="java.util.Objects" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <%@ include file="../common/header.jsp"%>
    <script>
        function borrow_del(obj, readerID, bookID) {
            $.post(
                "${pageContext.request.contextPath}/borrow?method=borrowDelete",
                {
                    "readerID": readerID,
                    "bookID": bookID
                },
                function(data) {
                    //返回值为 0 代表登录成功
                    if (data.code === 0) {
                        alert('归还成功！');
                        location.reload();
                    } else {
                        alert("归还失败");
                    }
                }, 'json'
            );
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
                                    <a class="btn btn-primary m-r-5" href="${pageContext.request.contextPath}/borrow?method=borrowAddPage"><i class="mdi mdi-plus"></i> 新增</a>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" id="r1" name="isNull" value="F" title="全部记录" checked class="custom-control-input">
                                        <label class="custom-control-label" for="r1">全部记录</label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" id="r2" name="isNull" value="T" title="所有未归还记录" class="custom-control-input">
                                        <label class="custom-control-label" for="r2">所有未归还记录</label>
                                    </div>
                                </div>

                                <form class="search-bar ml-md-auto" method="get" action="#!" role="form">
                                    <input type="hidden" name="search_field" id="search-field" value="title" />
                                    <div class="input-group ml-md-auto">
                                        <div class="input-group-prepend">
                                            <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="search-btn">用户名</button>
                                            <div class="dropdown-menu" style="">
                                                <a class="dropdown-item" href="#!" data-field="title">用户名</a>
                                                <a class="dropdown-item" href="#!" data-field="cat_name">性别</a>
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
                                                            <a class="btn btn-purple btn-xs" title="归还书籍"
                                                               onclick="borrow_del(this,'${BR.readerID}','${BR.bookID}')">
                                                                归还书籍
                                                            </a>
                                                        </c:if>
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
