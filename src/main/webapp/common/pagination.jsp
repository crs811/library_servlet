<%--
  Created by IntelliJ IDEA.
  User: CRS
  Date: 7/5/2025
  Time: 08:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 分页信息 -->
<%--<div class="row">--%>
<%--    <div class="col-md-3">--%>
<%--        <select class="form-control input-mini" onchange="self.location.href=options[selectedIndex].value">--%>
<%--            <option value="?${page.pathPrefix}pageNum=1&pageSize=10&${searchParams}"--%>
<%--                    <c:if test="${page.pageSize eq '10' }">selected</c:if>>10</option>--%>
<%--            <option value="?${page.pathPrefix}&pageNum=1&pageSize=50&${searchParams}"--%>
<%--                    <c:if test="${page.pageSize eq '50' }">selected</c:if>>50</option>--%>
<%--            <option value="?${page.pathPrefix}pageNum=1&pageSize=100&${searchParams}"--%>
<%--                    <c:if test="${page.pageSize eq '100' }">selected</c:if>>100</option>--%>
<%--        </select>--%>
<%--    </div>--%>
<%--    <div class="col-md-9">--%>
        <ul class="pagination">
            <li class="btn btn-default no-border">共${page.totalNumber}条</li>

            <c:if test="${page.hasPrevious == false}">
<%--                <li class="disabled"><a href="#" >首页</a></li>--%>
                <li class="page-item disabled"><span class="page-link">上一页</span></li>
            </c:if>
            <c:if test="${page.hasPrevious == true}">
<%--                <li><a href="?${page.pathPrefix}pageNum=1&pageSize=${page.pageSize}&${searchParams}" rel="external nofollow" >首页</a></li>--%>
                <li class="page-item"><a class="page-link" href="?${page.pathPrefix}pageNum=${page.prePage}&pageSize=${page.pageSize}&${searchParams}">上一页</a></li>
            </c:if>

            <c:forEach var="i" begin="${page.begin}" end="${page.end}">
                <c:choose>
                    <c:when test="${i == page.pageNum}">
                        <li class="page-item active"><a class="page-link" href="?${page.pathPrefix}pageNum=${i}&pageSize=${page.pageSize}&${searchParams}" >${i}</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item"><a class="page-link" href="?${page.pathPrefix}pageNum=${i}&pageSize=${page.pageSize}&${searchParams}">${i}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${page.hasNext == true}">
                <li class="page-item"><a class="page-link" href="?${page.pathPrefix}pageNum=${page.nextPage}&pageSize=${page.pageSize}&${searchParams}">下一页</a></li>
<%--                <li><a href="?${page.pathPrefix}pageNum=${page.totalPages}&pageSize=${page.pageSize}&${searchParams}" rel="external nofollow" >末页</a></li>--%>
            </c:if>
            <c:if test="${page.hasNext == false}">
                <li class="page-item disabled"><a class="page-link" href="#!">下一页</a></li>
<%--                <li class="disabled"><a href="#" rel="external nofollow">末页</a></li>--%>
            </c:if>
        </ul>
<%--    </div>--%>
<%--</div>--%>
<!-- 分页信息结束 -->
