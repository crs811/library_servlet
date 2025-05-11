package com.crs811.library.util;

import jakarta.servlet.ServletRequest;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

public class WebUtils {

    /**
     * 获取所有以指定前缀开头的请求参数，并返回去除前缀后的参数Map。
     *
     * @param request ServletRequest 对象
     * @param prefix  参数前缀
     * @return Map<String, Object>，key为去除前缀后的参数名，value为参数值（String 或 String[]）
     */
    public static Map<String, Object> getParametersStartingWith(ServletRequest request, String prefix) {
        Map<String, Object> params = new HashMap<>();

        if (request == null || prefix == null) {
            return params;
        }

        Enumeration<String> paramNames = request.getParameterNames();

        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();

            if (paramName.startsWith(prefix)) {
                String unprefixedName = paramName.substring(prefix.length());
                String[] values = request.getParameterValues(paramName);

                if (values == null) {
                    // 忽略无值参数
                    continue;
                }

                if (values.length == 1) {
                    params.put(unprefixedName, values[0]);  // 单个值
                } else {
                    params.put(unprefixedName, values);     // 多个值
                }
            }
        }

        return params;
    }
}



