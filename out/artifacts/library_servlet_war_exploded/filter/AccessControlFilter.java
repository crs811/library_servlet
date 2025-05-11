package com.crs811.library.filter;

import com.crs811.library.entity.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AccessControlFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
        String servletPath = httpServletRequest.getServletPath();  //获取客户端所请求的脚本文件的文件路径


        //System.out.println(servletPath);

        //不过滤处理登录页面、JS和CSS文件
        if (!servletPath.equals("/login.jsp")
            && !servletPath.equals("/login")
            && !servletPath.endsWith(".js")
            && !servletPath.endsWith(".css")
            && !servletPath.endsWith(".jpg")
            && !servletPath.endsWith(".png")
            && !servletPath.endsWith(".ico")
            && !servletPath.endsWith(".gif")
            && !servletPath.endsWith(".svg")) {
            //判断 session
            HttpSession session = httpServletRequest.getSession();
            Object user =  session.getAttribute("USER_IN_SESSION");
            if (user instanceof User) {
                filterChain.doFilter(servletRequest, servletResponse);
            } else {
                // System.out.println(" ==== 用户未登录，跳转到登录页面");
                //跳转到登录页面
                HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;
                httpServletResponse.sendRedirect(httpServletRequest.getContextPath() +  "/login.jsp");
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
