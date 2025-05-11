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
        /*用户-借书*/
        function allow(obj) {
            alert("图书馆开放时间为: 周一至周日 8:00 - 22:00, 请前往图书馆借阅！")
        }

        /*用户-不准借书*/
        function notAllow(obj) {
            alert("每个用户最多可借阅 [8] 本书籍,请尽快前往图书馆归还！")
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
                                    <a class="btn btn-primary m-r-5" href="../admin/book_add.jsp"><i class="mdi mdi-plus"></i> 新增</a>
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
                                            <th style="width: 100%">书名</th>
                                            <th>作者</th>
                                            <th>总数</th>
                                            <th>借出</th>
                                            <th>类型</th>
                                            <th style="text-align: center">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="B" items="${bookList}"  >
                                            <tr>
                                                <td>${B.bookName}</td>
                                                <td>${B.bookAuthor}</td>
                                                <td>${B.bookSum}</td>
                                                <td>${B.bookLend}</td>
                                                <td><span class="badge badge-success">${B.tag}</span></td>
                                                <td>
                                                    <div class="btn-group">
                                                        <a class="btn btn-xs btn-default" href="book?method=bookEditPage&id=${B.bookID}"
                                                           title="" data-toggle="tooltip" data-original-title="编辑"><i class="mdi mdi-pencil"></i></a>
                                                        <a class="btn btn-xs btn-default ajax-get confirm" href="book?method=bookDelete&id=${B.bookID}"
                                                           onclick="return confirm('确认 ${B.bookName} 删除吗？');"  title="" data-toggle="tooltip" data-original-title="删除">
                                                            <i class="mdi mdi-window-close"></i>
                                                        </a>
                                                    </div>
                                                    <div class="btn-group">
                                                        <a class="btn btn-purple btn-xs" href="borrow?method=borrowDetailList&bookID=${B.bookID}" title="查询借阅记录" >借阅记录</a>&nbsp;
                                                        <a class="btn btn-pink btn-xs" href="borrow?method=borrowDetailList&bookID=${B.bookID}&isNull=T" title="查询未归还记录">未归还</a>
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
