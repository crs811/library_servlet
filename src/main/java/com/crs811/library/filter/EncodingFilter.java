package com.crs811.library.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@WebFilter(filterName = "encodingFilter", urlPatterns = "/*")
public class EncodingFilter implements Filter {
    private String characterEncoding = null;
    FilterConfig fc;
    private Map<String, String> params = new HashMap<String, String>();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        for (Enumeration<String> e = filterConfig.getInitParameterNames(); e.hasMoreElements();) {
            String name = e.nextElement();
            String value = filterConfig.getInitParameter(name);
            params.put(name, value);
        }

        fc = filterConfig;
        if (null != fc.getInitParameter("encoding") && !"".equals(fc.getInitParameter("encoding"))) {
            characterEncoding = fc.getInitParameter("encoding");
        } else {
            characterEncoding = "utf-8";
        }
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        servletRequest.setCharacterEncoding(characterEncoding);
        servletResponse.setContentType("text/html;charset="+characterEncoding);
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {
        params=null;
        characterEncoding=null;
    }
}
