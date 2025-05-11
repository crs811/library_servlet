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
                                <form class="search-bar ml-md-auto" method="post" action="${pageContext.request.contextPath}/book?method=bookSearch" role="form">
                                    <div class="input-group ml-md-auto">
                                        <select class="form-control" name="search_field">
                                            <option value="bookName">书名</option>
                                            <option value="bookAuthor">作者</option>
                                            <option value="tag">类型</option>
                                        </select>&nbsp;
                                        <input type="text" class="form-control" name="search_text" placeholder="请输入查询条件">&nbsp;
                                        <button class="btn btn-label btn-success btn-sm" type="submit"><label><i class="mdi mdi-account-search"></i></label> 搜索</button>
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
                                                    <a class="btn btn-purple btn-xs" title="借阅"
                                                        ${(B.bookSum - B.bookLend)>0?"":"disabled"}
                                                            <c:if test="${(B.bookSum - B.bookLend)>0}">${allow?"onclick=allow(this)":"onclick=notAllow(this)"}</c:if>
                                                       href="javascript:">借阅</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- 分页内容 -->
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
