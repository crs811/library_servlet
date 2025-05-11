package com.crs811.library.filter;

import com.crs811.library.entity.User;

import com.crs811.library.util.CaptchaUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Objects;

@WebFilter(filterName = "AccessControlFilter", urlPatterns = "/*")
public class AccessControlFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
        String servletPath = httpServletRequest.getServletPath();  //获取客户端所请求的脚本文件的文件路径

        // System.out.println("AccessControlFilter ==== Path:" + servletPath);

        //不过滤处理登录页面、JS和CSS文件
        if (!servletPath.equals("/login.jsp")
            && !servletPath.equals("/login")
            && !servletPath.equals("/captcha")
            && !servletPath.endsWith(".js")
            && !servletPath.endsWith(".css")
            && !servletPath.endsWith(".jpg")
            && !servletPath.endsWith(".png")
            && !servletPath.endsWith(".ico")
            && !servletPath.endsWith(".gif")
            && !servletPath.endsWith(".svg")
            && !servletPath.endsWith(".woff")
            && !servletPath.endsWith(".woff2")
            && !servletPath.endsWith(".ttf")
            && !servletPath.endsWith(".eot")) {
            //判断 session
            HttpSession session = httpServletRequest.getSession();
            User user =  (User)session.getAttribute("USER_IN_SESSION");

            if (user != null) {
                // 非管理员用户访问后台管理页面(/admin/*)，跳转到登录页面
                if (!user.getType().equals(User.ADMIN) && servletPath.startsWith("/admin")) {
                    //跳转到登录页面
                    HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;
                    httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/login.jsp");
                }
                filterChain.doFilter(servletRequest, servletResponse);
            } else { // 用户未登录，跳转到登录页面
                // System.out.println(" ==== No Login");
                //跳转到登录页面
                HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;
                httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/login.jsp");
            }
        }
        else
        {
            // 传递给下一过滤器
            filterChain.doFilter(servletRequest, servletResponse);
        }
    }

    @Override
    public void destroy() {
    }
}
