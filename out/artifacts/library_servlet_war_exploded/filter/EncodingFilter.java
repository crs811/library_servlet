package com.crs811.library.filter;

import jakarta.servlet.*;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

public class EncodingFilter implements Filter {
    private String characterEncoding = null;
    FilterConfig fc;
    private Map<String, String> params = new HashMap<String, String>();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        for (Enumeration e = filterConfig.getInitParameterNames(); e.hasMoreElements();) {
            String name = (String) e.nextElement();
            String value = filterConfig.getInitParameter(name);
            params.put(name, value);
        }

        fc = filterConfig;
        if (null != fc && null != fc.getInitParameter("encoding") && !"".equals(fc.getInitParameter("encoding"))) {
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
