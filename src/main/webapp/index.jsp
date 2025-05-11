<%--
  Created by IntelliJ IDEA.
  User: CRS
  Date: 6/4/2025
  Time: 18:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.crs811.library.entity.User" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <%@ include file="common/header.jsp"%>
    <script>
        $.get(
            "${pageContext.request.contextPath}/user?method=staticInfo",
            function(data) {
                //返回值为 0 代表登录成功
                if (data.code === 0) {
                    $("#totalBookCount").html(data.data.bookCount);
                    $("#totalUserCount").html(data.data.userCount);
                    $("#totalBorrowCount").html(data.data.borrowCount);
                    $("#totalBorrowUnreturnedCount").html(data.data.borrowUnreturnedCount);
                } else {
                    alert(data.msg)
                }
            }, 'json'
        );
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
                    <div class="col-md-6 col-xl-3">
                        <div class="card bg-primary text-white">
                            <div class="card-body clearfix">
                                <div class="flex-box">
                                    <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-book-open-page-variant fs-22"></i></span>
                                    <span class="fs-22 lh-22" id="totalBookCount"></span>
                                </div>
                                <div class="text-right">图书总量</div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-xl-3">
                        <div class="card bg-danger text-white">
                            <div class="card-body clearfix">
                                <div class="flex-box">
                                    <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-account-supervisor fs-22"></i></span>
                                    <span class="fs-22 lh-22" id="totalUserCount"></span>
                                </div>
                                <div class="text-right">用户总数</div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-xl-3">
                        <div class="card bg-success text-white">
                            <div class="card-body clearfix">
                                <div class="flex-box">
                                    <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi mdi-book-plus-multiple fs-22"></i></span>
                                    <span class="fs-22 lh-22" id="totalBorrowCount"></span>
                                </div>
                                <div class="text-right">借阅总量</div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-xl-3">
                        <div class="card bg-purple text-white">
                            <div class="card-body clearfix">
                                <div class="flex-box">
                                    <span class="img-avatar img-avatar-48 bg-translucent"><i class="mdi  mdi-book-remove-multiple fs-22"></i></span>
                                    <span class="fs-22 lh-22" id="totalBorrowUnreturnedCount"></span>
                                </div>
                                <div class="text-right">借出数量</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">每周借阅数量</div>
                            </div>
                            <div class="card-body">
                                <canvas class="js-chartjs-bars"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">各年份借阅统计</div>
                            </div>
                            <div class="card-body">
                                <canvas class="js-chartjs-lines"></canvas>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </main>
        <!--End 页面主要内容-->
    </div>
</div>

<script type="text/javascript" src="static/LightYearAdmin/js/Chart.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(e) {
        let $dashChartBarsCnt  = jQuery( '.js-chartjs-bars' )[0].getContext( '2d' );
        let $dashChartLinesCnt = jQuery( '.js-chartjs-lines' )[0].getContext( '2d' );

        let $dashChartBarsData = {
            labels: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
            datasets: [
                {
                    label: '借阅数量',
                    borderWidth: 1,
                    borderColor: 'rgba(0, 0, 0, 0)',
                    backgroundColor: 'rgba(51, 202, 185, 0.5)',
                    hoverBackgroundColor: "rgba(51, 202, 185, 0.7)",
                    hoverBorderColor: "rgba(0, 0, 0, 0)",
                    data: [2500, 1500, 1200, 3200, 4800, 3500, 1500]
                }
            ]
        };
        let $dashChartLinesData = {
            labels: ['2003', '2004', '2005', '2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014'],
            datasets: [
                {
                    label: '借阅数量',
                    data: [20, 25, 40, 30, 45, 40, 55, 40, 48, 40, 42, 50],
                    borderColor: '#358ed7',
                    backgroundColor: 'rgba(53, 142, 215, 0.175)',
                    borderWidth: 1,
                    fill: false,
                    lineTension: 0.5
                }
            ]
        };

        new Chart($dashChartBarsCnt, {
            type: 'bar',
            data: $dashChartBarsData
        });

        var myLineChart = new Chart($dashChartLinesCnt, {
            type: 'line',
            data: $dashChartLinesData,
        });
    });
</script>
</body>
</html>