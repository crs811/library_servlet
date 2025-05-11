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
    <%@ include file="common/header.jsp"%>
    <title>修改密码</title>
    <script type="text/javascript">
        function checkForm() {
            let old_password = $("#old_password").val();
            let new_password = $("#new_password").val();
            let confirm_password = $("#confirm_password").val();

            if (old_password == null || old_password === "") {
                $("#error").html("旧密码不能为空");
                return false;
            }
            if (new_password == null || new_password === "") {
                $("#error").html("新密码不能为空");
                return false;
            }
            console.log(confirm_password+" - "+new_password)
            if (confirm_password !== new_password) {
                $("#error").html("两次密码输入不一致");
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
                    "${pageContext.request.contextPath}/user?method=changePassword",
                    $("#postForm").serialize(),
                    function(data) {
                        //返回值为 0 代表登录成功
                        if (data.code === 0) {
                            alert("修改密码成功");
                        } else {
                            //alert('用户名或密码错误');
                            $('#error').html(data.msg);
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
            <img src="static/LightYearAdmin/images/loading-logo.png" alt="">
        </div>
    </div>
</div>
<!--页面loading end-->
<div class="lyear-layout-web">
    <div class="lyear-layout-container">
        <!--左侧导航-->
        <%@ include file="common/left.jsp" %>

        <!--头部信息-->
        <%@ include file="common/top.jsp" %>

        <!--页面主要内容-->
        <main class="lyear-layout-content">

            <div class="container-fluid p-t-15">

                <div class="row">

                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <form action="" method="post" class="post-form" id="postForm" onsubmit="return false">
                                    <input type="hidden" name="id" value="<%=currentUser.getId()%>">
                                    <div class="form-group">
                                        <label for="old_password">旧密码</label>
                                        <input type="password" class="form-control" name="oldPassword" id="old_password" placeholder="输入旧的密码">
                                    </div>
                                    <div class="form-group">
                                        <label for="new_password">新密码</label>
                                        <input type="password" class="form-control" name="newPassword" id="new_password" placeholder="输入新的密码">
                                    </div>
                                    <div class="form-group">
                                        <label for="confirm_password">确认新密码</label>
                                        <input type="password" class="form-control" name="confirmPassword" id="confirm_password" placeholder="再次输入新的密码">
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary ajax-post" target-form="post-form">修改密码</button>&nbsp;&nbsp;&nbsp;&nbsp;
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