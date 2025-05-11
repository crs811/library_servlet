package com.crs811.library.util;

import jakarta.servlet.ServletRequest;
import org.apache.commons.lang3.StringUtils;

import java.io.Serial;
import java.io.Serializable;
import java.util.Iterator;
import java.util.Map;

public class PageUtil implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 获取目标页码
     * @return
     */
    public static int getTargetPage(ServletRequest request){
        int pageNum = 0;
        String pageNumStr = request.getParameter("pageNum");
        if(StringUtils.isNotBlank(pageNumStr)){
            pageNum = Integer.parseInt(pageNumStr);
        }
        return pageNum;
    }

    /**
     * 获取每页条数
     * @return
     */
    public static int getPageSize(ServletRequest request){
        int pageSize = 10;
        String pageSizeStr = request.getParameter("pageSize");
        if(StringUtils.isNotBlank(pageSizeStr)){
            pageSize = Integer.parseInt(pageSizeStr);
        }
        return pageSize;
    }

    /**
     * 将Map中的查询条件，加上前缀，以&拼接
     * @param map
     * @param prefix 每个参数的前缀
     * @return
     */
    public static String encodeParameterStringWithPrefix(Map<String,Object> map, String prefix){
        if(null == map || map.isEmpty()){
            return "";
        }

        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, Object> stringObjectEntry : map.entrySet()) {
            if (StringUtils.isNotEmpty(sb.toString())) {
                sb.append("&");
            }
            sb.append(prefix);
            sb.append(stringObjectEntry.getKey());
            sb.append("=");
            sb.append(stringObjectEntry.getValue());
        }
        return sb.toString();
    }
}
