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
            let bookName = $("#bookName").val();
            let author = $("#author").val();
            let bookSum = $("#bookSum").val();
            let bookLend = $("#bookLend").val();
            let publishTime = $("#publishTime").val();

            if (bookName == null || bookName === "") {
                $("#error").html("书名不能为空");
                return false;
            }
            if (author == null || author === "") {
                $("#error").html("作者不能为空");
                return false;
            }
            if (bookSum == null || bookSum === "") {
                $("#error").html("总数不能为空");
                return false;
            }
            if (bookLend == null || bookLend === "") {
                $("#error").html("借出数量不能为空");
                return false;
            }
            if (publishTime == null || publishTime === "") {
                $("#error").html("出版时间不能为空");
                return false;
            }
            return true;
        }

        $(function () {
            $(".ajax-post").click(function () {
                // 输入的有效性判断
                if (!checkForm()) {
                    return;
                }
                $.post(
                    "${pageContext.request.contextPath}/book?method=bookAdd",
                    $("#postForm").serialize(),
                    function(data) {
                        //返回值为 0 代表登录成功
                        if (data.code === 0) {
                            alert("添加成功");
                        } else {
                            alert("添加失败");
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

                                <form action="" method="post" class="post-form" id="postForm" onsubmit="return checkForm();">
                                    <div class="form-group col-md-12">
                                        <label for="title">书名</label><span class="text-danger">*</span>
                                        <input type="text" class="form-control" id="bookName" name="bookName" value="" placeholder="请输入书名" />
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="title">作者</label><span class="text-danger">*</span>
                                        <input type="text" class="form-control" id="author" name="bookAuthor" value="" placeholder="请输入作者" />
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="title">出版社</label>
                                        <input type="text" class="form-control" id="publisher" name="bookPublisher" value="" placeholder="请输入出版社" />
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="title">出版时间</label><span class="text-danger">*</span>
                                        <input type="date" class="form-control" id="publishTime" name="publishTime" value="" placeholder="请选择出版时间" />
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="title">价格</label>
                                        <input type="text" class="form-control" id="price" name="bookPrice" value="0" placeholder="请输入价格" />
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="title">总数</label><span class="text-danger">*</span>
                                        <input type="text" class="form-control" id="bookSum" name="bookSum" value="" placeholder="请输入总数" />
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="title">借出数量</label><span class="text-danger">*</span>
                                        <input type="text" class="form-control" id="bookLend" name="bookLend" value="0" placeholder="请输入借出数量" />
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="title">类别</label>
                                        <input type="text" class="form-control" id="tag" name="tag" value="" placeholder="请输入类别" />
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="title">ISBN号</label>
                                        <input type="text" class="form-control" id="isbn" name="isbn" value="" placeholder="请输入ISBN号" />
                                    </div>
                                    <div class="form-group col-md-12">
                                        <button type="submit" class="btn btn-primary ajax-post" target-form="post-form">添  加</button>&nbsp;&nbsp;&nbsp;&nbsp;
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