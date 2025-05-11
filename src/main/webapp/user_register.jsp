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
    <script type="text/javascript">
        function checkForm() {
            let username = $("#username").val();
            let password = $("#password").val();
            let nickname = $("#nickname").val();

            if (username == null || username === "") {
                $("#error").html("用户名不能为空");
                return false;
            }
            if (password == null || password === "") {
                $("#error").html("密码不能为空");
                return false;
            }
            if (nickname == null || nickname === "") {
                $("#error").html("昵称不能为空");
                return false;
            }
            return true;
        }

        $(function () {
            // $("form").submit(function (e) {
            //     e.preventDefault();
            // });

            $("#btn-avatar").click(function () {
                console.log("btn-avatar")
                $("#avatar-file").click();
            });

            $("#avatar-file").change(function (){
                let formData = new FormData();
                let imageFile = $($(this))[0].files[0];
                formData.append("imageFile", imageFile);

                $.ajax({
                    url: "${pageContext.request.contextPath}/upload",
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    dataType: 'json',
                    success:function (res) {
                        console.log(res);
                        // $("#avatar").attr("src", reader.result);
                        $("#avatar").attr("src", "static/LightYearAdmin/images/users/"+res.msg);
                        $("#avatarImage").val(res.msg);
                    }
                    ,error:function () {
                        alert('上传失败！');
                    }
                });
            });


            $(".ajax-post").click(function () {
                // 输入的有效性判断
                if (!checkForm()) {
                    return;
                }
                $.post(
                    "${pageContext.request.contextPath}/user?method=register",
                    $("#postForm").serialize(),
                    function(data) {
                        //返回值为 0 代表登录成功
                        if (data.code === 0) {
                            alert("注册成功，请登录");
                            window.location.href = "${pageContext.request.contextPath}/login.jsp";
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
                                    <div class="form-group col-md-12">
                                        <label for="title">用户名</label><span class="text-danger">*</span>
                                        <input type="text" class="form-control" id="username" name="username" value="" placeholder="请输入用户名" />
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="title">密码</label><span class="text-danger">*</span>
                                        <input type="password" class="form-control" id="password" name="password" value="" placeholder="请输入密码" />
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="title">昵称</label><span class="text-danger">*</span>
                                        <input type="text" class="form-control" id="nickname" name="nickname" value="" placeholder="请输入昵称" />
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="avatar">头像</label><br/>
                                        <img id="avatar" class="img-avatar mr-3" width="80px" height="80px"
                                             src="static/LightYearAdmin/images/users/avatar.jpg"/>
                                        <input type="file" id="avatar-file" name="avatar" value="" style="display: none;"/>
                                        <input type="hidden" name="avatarImage" id="avatarImage">
                                        <button type="button" class="btn btn-default" id="btn-avatar">更换头像</button>
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="title">电话</label>
                                        <input type="text" class="form-control" id="telephone" name="telephone" value="" placeholder="请输入电话" />
                                    </div>

                                    <div class="form-group col-md-12">
                                        <label for="title">邮箱</label>
                                        <input type="text" class="form-control" id="email" name="email" value="" placeholder="请输入邮箱" />
                                    </div>
                                    <% if (currentUser.getType().equals(User.ADMIN)) { %>
                                    <div class="form-group col-md-12">
                                        <label for="type">用户类型</label>
                                        <div class="clearfix">
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="typeOne" name="type" class="custom-control-input" value="0">
                                                <label class="custom-control-label" for="typeOne">管理员</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="typeTwo" name="type" class="custom-control-input" checked value="1">
                                                <label class="custom-control-label" for="typeTwo">普通用户</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label for="status">状态</label>
                                        <div class="clearfix">
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="statusTwo" name="status" class="custom-control-input" checked value="0">
                                                <label class="custom-control-label" for="statusTwo">启用</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="statusOne" name="status" class="custom-control-input" value="1">
                                                <label class="custom-control-label" for="statusOne">禁用</label>
                                            </div>
                                        </div>
                                    </div>
                                    <% } %>
                                    <div class="form-group col-md-12">
                                        <button type="submit" class="btn btn-primary ajax-post" target-form="post-form">注  册</button>&nbsp;&nbsp;&nbsp;&nbsp;
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