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
<!DOCTYPE html>
<html lang="zh">
<head>
    <%@ include file="../common/header.jsp"%>
    <script type="text/javascript">
        function checkForm() {
            if ($('#readerID option:selected').index() === 0) {
                $("#error").html("请选择借阅人");
                return false;
            }
            if ($('#bookID option:selected').index() === 0) {
                $("#error").html("请选择书籍");
                return false;
            }
            return true;
        }

        $(function () {
            //设置默认借阅时间为当前时间
            // document.getElementById('borrowTime').valueAsDate = new Date();

            $(".ajax-post").click(function () {
                // 输入的有效性判断
                if (!checkForm()) {
                    return;
                }

                $.post(
                    "${pageContext.request.contextPath}/borrow?method=borrowAdd",
                    $("#postForm").serialize(),
                    function(data) {
                        //返回值为 0 代表登录成功
                        if (data.code === 0) {
                            alert("借阅成功");
                            // $("#readerID option:first").prop('selected', true)
                            $("#bookID option:first").prop('selected', true)
                        } else {
                            alert(data.msg);
                        }
                    }, 'json'
                );
            })
        });
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
                            <div class="card-body">

                                <form action="#" method="post" class="post-form" id="postForm" onsubmit="return false">
                                    <div class="form-group col-md-12">
                                        <label for="title">借阅人</label><span class="text-danger">*</span>
                                        <select id="readerID" name="readerID" class="form-control">
                                            <option value="">请选择借阅人</option>
                                            <c:forEach items="${readerList}" var="reader">
                                                <option value="${reader.id}">读者ID:&nbsp;${reader.id}&nbsp;,&nbsp;姓名:&nbsp;${reader.nickname}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="title">书名</label><span class="text-danger">*</span>
                                        <select id="bookID" name="bookID" class="form-control">
                                            <option value="">请选择书籍</option>
                                            <c:forEach items="${bookList}" var="book">
                                                <option value="${book.bookID}">书名:&nbsp;${book.bookName}&nbsp;,&nbsp;作者:&nbsp;${book.bookAuthor}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-12">
                                        <button type="submit" class="btn btn-primary ajax-post" target-form="post-form">借  阅</button>&nbsp;&nbsp;&nbsp;
                                        <span id="error" style="color: red; ">${error}</span>
                                    </div>
                                </form>
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