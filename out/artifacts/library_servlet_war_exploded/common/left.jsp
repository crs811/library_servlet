<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<aside class="lyear-layout-sidebar">
    <!-- logo -->
    <div id="logo" class="sidebar-header">
        <a href="../index.jsp"><img src="../static/LightYearAdmin/images/logo-sidebar.png" title="LightYear" alt="LightYear" /></a>
    </div>
    <div class="lyear-layout-sidebar-info lyear-scroll">
        <nav class="sidebar-main">
            <ul class="nav-drawer">
                <li class="nav-item
                <% if (request.getServletPath().equals("/index.jsp")) { %>
                   active
                <% } %>"> <a href="../index.jsp"><i class="mdi mdi-home"></i> <span>后台首页</span></a> </li>
                <% if (user.getType().equals("0")) { %>

                <li class="nav-item
                <% if (request.getServletPath().equals("/admin/admin_list.jsp")) { %>
                   active
                <% } %>"
                > <a href="${pageContext.request.contextPath}/user?method=adminList"><i class="mdi mdi-account"></i> <span>管理员管理</span></a> </li>
                <li class="nav-item
                <% if (request.getServletPath().equals("/admin/reader_list.jsp")) { %>
                    active
                <% } %>"
                > <a href="${pageContext.request.contextPath}/user?method=readerList"><i class="mdi mdi-account-multiple"></i> <span>读者管理</span></a> </li>
                <li class="nav-item
                <% if (request.getServletPath().equals("/admin/book_list.jsp")) { %>
                   active
                <% } %>"
                > <a href="${pageContext.request.contextPath}/book?method=bookList"><i class="mdi mdi-notebook"></i> <span>书籍管理</span></a> </li>
                <li class="nav-item
                <% if (request.getServletPath().equals("/admin/borrow_list.jsp")) { %>
                   active
                <% } %>"
                > <a href="${pageContext.request.contextPath}/borrow?method=borrowDetailList"><i class="mdi mdi-account-search"></i> <span>借阅记录</span></a> </li>

                <% } %>
                <% if (user.getType().equals("1")) { %>
                <li class="nav-item
                <% if (request.getServletPath().equals("/reader/book_list.jsp")) { %>
                   active
                <% } %>"> <a href="${pageContext.request.contextPath}/book?method=bookList"><i class="mdi mdi-notebook"></i> <span>书籍查询</span></a> </li>
                <li class="nav-item
                <% if (request.getServletPath().equals("/reader/borrow_list.jsp")) { %>
                   active
                <% } %>"> <a href="${pageContext.request.contextPath}/borrow?method=borrowDetailList&readerID=<%=user.getId()%>"><i class="mdi mdi-account-search"></i> <span>借阅查询</span></a> </li>
                <% } %>
                <li class="nav-item
                <% if (request.getServletPath().equals("admin/user_register.jsp")) { %>
                   active
                <% } %>"> <a href="${pageContext.request.contextPath}/user_register.jsp"><i class="mdi mdi-account-plus"></i> <span>用户注册</span></a> </li>
            </ul>
        </nav>
        <div class="sidebar-footer">
            <p class="copyright">Copyright &copy; 2025. <a target="_blank" href="#">xxx</a> All rights reserved.</p>
        </div>
    </div>
</aside>
