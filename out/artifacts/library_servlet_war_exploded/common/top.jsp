<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<header class="lyear-layout-header">

  <nav class="navbar">

    <div class="navbar-left">
      <div class="lyear-aside-toggler">
        <span class="lyear-toggler-bar"></span>
        <span class="lyear-toggler-bar"></span>
        <span class="lyear-toggler-bar"></span>
      </div>
    </div>

    <ul class="navbar-right d-flex align-items-center">
      <li class="dropdown dropdown-notice">
            <span data-toggle="dropdown" class="icon-item">
              <i class="mdi mdi-bell-outline"></i>
              <span class="badge badge-danger">10</span>
            </span>
        <div class="dropdown-menu dropdown-menu-right">
          <div class="lyear-notifications">

            <div class="lyear-notifications-title clearfix"  data-stopPropagation="true"><a href="#!" class="float-right">查看全部</a>你有 1 条未读消息</div>
            <div class="lyear-notifications-info lyear-scroll">
              <a href="#!" class="dropdown-item" title="树莓派销量猛增，疫情期间居家工作学习、医疗领域都需要它">树莓派销量猛增，疫情期间居家工作学习、医疗领域都需要它</a>
            </div>

          </div>
        </div>
      </li>
      <!--切换主题配色-->
      <li class="dropdown dropdown-skin">
        <span data-toggle="dropdown" class="icon-item"><i class="mdi mdi-palette"></i></span>
        <ul class="dropdown-menu dropdown-menu-right" data-stopPropagation="true">
          <li class="drop-title"><p>主题</p></li>
          <li class="drop-skin-li clearfix">
                <span class="inverse">
                  <input type="radio" name="site_theme" value="default" id="site_theme_1" checked>
                  <label for="site_theme_1"></label>
                </span>
            <span>
                  <input type="radio" name="site_theme" value="dark" id="site_theme_2">
                  <label for="site_theme_2"></label>
                </span>
            <span>
                  <input type="radio" name="site_theme" value="translucent" id="site_theme_3">
                  <label for="site_theme_3"></label>
                </span>
          </li>
          <li class="drop-title"><p>LOGO</p></li>
          <li class="drop-skin-li clearfix">
                <span class="inverse">
                  <input type="radio" name="logo_bg" value="default" id="logo_bg_1" checked>
                  <label for="logo_bg_1"></label>
                </span>
            <span>
                  <input type="radio" name="logo_bg" value="color_2" id="logo_bg_2">
                  <label for="logo_bg_2"></label>
                </span>
            <span>
                  <input type="radio" name="logo_bg" value="color_3" id="logo_bg_3">
                  <label for="logo_bg_3"></label>
                </span>
            <span>
                  <input type="radio" name="logo_bg" value="color_4" id="logo_bg_4">
                  <label for="logo_bg_4"></label>
                </span>
            <span>
                  <input type="radio" name="logo_bg" value="color_5" id="logo_bg_5">
                  <label for="logo_bg_5"></label>
                </span>
            <span>
                  <input type="radio" name="logo_bg" value="color_6" id="logo_bg_6">
                  <label for="logo_bg_6"></label>
                </span>
            <span>
                  <input type="radio" name="logo_bg" value="color_7" id="logo_bg_7">
                  <label for="logo_bg_7"></label>
                </span>
            <span>
                  <input type="radio" name="logo_bg" value="color_8" id="logo_bg_8">
                  <label for="logo_bg_8"></label>
                </span>
          </li>
          <li class="drop-title"><p>头部</p></li>
          <li class="drop-skin-li clearfix">
                <span class="inverse">
                  <input type="radio" name="header_bg" value="default" id="header_bg_1" checked>
                  <label for="header_bg_1"></label>
                </span>
            <span>
                  <input type="radio" name="header_bg" value="color_2" id="header_bg_2">
                  <label for="header_bg_2"></label>
                </span>
            <span>
                  <input type="radio" name="header_bg" value="color_3" id="header_bg_3">
                  <label for="header_bg_3"></label>
                </span>
            <span>
                  <input type="radio" name="header_bg" value="color_4" id="header_bg_4">
                  <label for="header_bg_4"></label>
                </span>
            <span>
                  <input type="radio" name="header_bg" value="color_5" id="header_bg_5">
                  <label for="header_bg_5"></label>
                </span>
            <span>
                  <input type="radio" name="header_bg" value="color_6" id="header_bg_6">
                  <label for="header_bg_6"></label>
                </span>
            <span>
                  <input type="radio" name="header_bg" value="color_7" id="header_bg_7">
                  <label for="header_bg_7"></label>
                </span>
            <span>
                  <input type="radio" name="header_bg" value="color_8" id="header_bg_8">
                  <label for="header_bg_8"></label>
                </span>
          </li>
          <li class="drop-title"><p>侧边栏</p></li>
          <li class="drop-skin-li clearfix">
                <span class="inverse">
                  <input type="radio" name="sidebar_bg" value="default" id="sidebar_bg_1" checked>
                  <label for="sidebar_bg_1"></label>
                </span>
            <span>
                  <input type="radio" name="sidebar_bg" value="color_2" id="sidebar_bg_2">
                  <label for="sidebar_bg_2"></label>
                </span>
            <span>
                  <input type="radio" name="sidebar_bg" value="color_3" id="sidebar_bg_3">
                  <label for="sidebar_bg_3"></label>
                </span>
            <span>
                  <input type="radio" name="sidebar_bg" value="color_4" id="sidebar_bg_4">
                  <label for="sidebar_bg_4"></label>
                </span>
            <span>
                  <input type="radio" name="sidebar_bg" value="color_5" id="sidebar_bg_5">
                  <label for="sidebar_bg_5"></label>
                </span>
            <span>
                  <input type="radio" name="sidebar_bg" value="color_6" id="sidebar_bg_6">
                  <label for="sidebar_bg_6"></label>
                </span>
            <span>
                  <input type="radio" name="sidebar_bg" value="color_7" id="sidebar_bg_7">
                  <label for="sidebar_bg_7"></label>
                </span>
            <span>
                  <input type="radio" name="sidebar_bg" value="color_8" id="sidebar_bg_8">
                  <label for="sidebar_bg_8"></label>
                </span>
          </li>
        </ul>
      </li>
      <!--切换主题配色-->
      <li class="dropdown dropdown-profile">
        <a href="javascript:void(0)" data-toggle="dropdown" class="dropdown-toggle">
          <img class="img-avatar img-avatar-48 m-r-10" src="../static/LightYearAdmin/images/users/<%=user.getAvatar()%>"/>
          <span><%=nickname%></span>
        </a>
        <ul class="dropdown-menu dropdown-menu-right">
          <li>
            <a class="dropdown-item" href="../user_info.jsp"><i class="mdi mdi-account"></i> 个人信息</a>
          </li>
          <li>
            <a class="dropdown-item" href="../user_pwd.jsp"><i class="mdi mdi-lock-outline"></i> 修改密码</a>
          </li>
          <li>
            <a class="dropdown-item" href="javascript:void(0)"><i class="mdi mdi-delete"></i> 清空缓存</a>
          </li>
          <li class="dropdown-divider"></li>
          <li>
            <a class="dropdown-item" href="user?method=logout"><i class="mdi mdi-logout-variant"></i> 退出登录</a>
          </li>
        </ul>
      </li>
    </ul>

  </nav>

</header>
<!--End 头部信息-->
