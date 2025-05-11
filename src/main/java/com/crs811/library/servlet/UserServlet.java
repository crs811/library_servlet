package com.crs811.library.servlet;

import com.crs811.library.dao.IUserDao;
import com.crs811.library.dao.impl.UserDaoImpl;
import com.crs811.library.entity.Page;
import com.crs811.library.entity.StaticInfo;
import com.crs811.library.entity.User;
import com.crs811.library.util.JSONUtil;
import com.crs811.library.util.PageUtil;
import com.crs811.library.util.Result;
import com.crs811.library.util.WebUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    IUserDao userDao = new UserDaoImpl();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        switch (method) {
            case "staticInfo":
                try {
                    staticInfo(req, resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "logout":
                logout(req, resp);
                break;
            case "register":
                register(req,resp);
                break;
            case "adminSearch":
                adminSearch(req,resp);
                break;
            case "readerSearch":
                readerSearch(req,resp);
                break;
            case "deleteById":
                deleteById(req, resp);
                break;
            case "userEditPage":
                userEditPage(req, resp);
                break;
            case "userEdit":
                userEdit(req, resp);
                break;
            case "changePassword":
                changePassword(req,resp);
                break;
        }
    }

    private void adminSearch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 获取所有的查询条件参数（为了使用方便，所有查询条件的参数命名前缀都是"search_"）
        Map<String, Object> searchParams = WebUtils.getParametersStartingWith(req, "search_");
        // System.out.println("searchParams: " + searchParams);

        // 获取分页页码信息和每页条数
        int pageNum = PageUtil.getTargetPage(req);
        int pageSize = PageUtil.getPageSize(req);
        Page page = new Page(pageSize, pageNum);

        page.setTotalNumber(userDao.getUserCountByCondition(User.ADMIN, searchParams)); // 获取读者总数，用于分页其他参数设置
        page.setPathPrefix("method=adminSearch&"); // 点击分页按钮时，需要带上查询条件参数

        // 查询需要展示的内容
        List<User> userList = userDao.getUsersByPage(User.ADMIN, page, searchParams);

        req.setAttribute("adminList", userList);
        req.setAttribute("page", page);
        // 将搜索条件编码成字符串，用于排序，分页的URL
        req.setAttribute("searchParams", PageUtil.encodeParameterStringWithPrefix(searchParams, "search_"));

        req.getRequestDispatcher("/admin/admin_list.jsp").forward(req, resp);
    }

    private void readerSearch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 获取所有的查询条件参数（为了使用方便，所有查询条件的参数命名前缀都是"search_"）
        Map<String, Object> searchParams = WebUtils.getParametersStartingWith(req, "search_");
        //  System.out.println("searchParams: " + searchParams);

        // 获取分页页码信息和每页条数
        int pageNum = PageUtil.getTargetPage(req);
        int pageSize = PageUtil.getPageSize(req);
        Page page = new Page(pageSize, pageNum);

        page.setTotalNumber(userDao.getUserCountByCondition(User.READER, searchParams)); // 获取读者总数，用于分页其他参数设置
        page.setPathPrefix("method=readerSearch&"); // 点击分页按钮时，需要带上查询条件参数

        // 查询需要展示的内容
        List<User> userList = userDao.getUsersByPage(User.READER, page, searchParams);

        req.setAttribute("readerList", userList);
        req.setAttribute("page", page);
        // 将搜索条件编码成字符串，用于排序，分页的URL
        req.setAttribute("searchParams", PageUtil.encodeParameterStringWithPrefix(searchParams, "search_"));

        req.getRequestDispatcher("/admin/reader_list.jsp").forward(req, resp);
    }

    private void staticInfo(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        //System.out.println("UserServlet.staticInfo");
        StaticInfo staticInfo = userDao.getStaticInfo();
        if (staticInfo!= null) {
            JSONUtil.toJSON(resp, Result.ok(staticInfo));
        } else {
            JSONUtil.toJSON(resp, Result.error("查询失败"));
        }
    }

    private void logout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        //销毁session对象
        HttpSession session = req.getSession();
        session.invalidate();
        //重定向到登录页面
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }

    private void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 默认类型为普通人员注册
        String type = req.getParameter("type") == null ? User.READER : req.getParameter("type");

        // 默认状态为正常
        String status = req.getParameter("status") == null ? "0" : req.getParameter("status");

        User user = User.setUser(-1,
            req.getParameter("username"),
            req.getParameter("password"),
            req.getParameter("nickname"),
            req.getParameter("avatarImage"),
            req.getParameter("telephone"),
            req.getParameter("email"),
            type,
            status);

        if (userDao.register(user)){
            JSONUtil.toJSON(resp, Result.ok("注册成功"));
        } else {
            JSONUtil.toJSON(resp, Result.error("注册失败"));
        }
    }

    private void deleteById(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        //System.out.println("UserServlet.deleteById");
        int userId = Integer.parseInt(req.getParameter("id"));
        if(userDao.deleteUser(userId)){
            if (Objects.equals(req.getParameter("type"), User.ADMIN))
                adminSearch(req, resp);
            else
                readerSearch(req, resp);
        } else {
            resp.sendRedirect("index.jsp");
        }
    }

    private void userEditPage(HttpServletRequest req, HttpServletResponse resp) {
        int userId = Integer.parseInt(req.getParameter("id"));
        User user = userDao.getUserById(userId);
        if (user != null) {
            JSONUtil.toJSON(resp, Result.ok(user));
        } else {
            JSONUtil.toJSON(resp, Result.error("查询失败"));
        }
    }

    private void userEdit(HttpServletRequest req, HttpServletResponse resp) {
        // 默认类型为普通人员注册
        String type = req.getParameter("type") == null ? User.READER : req.getParameter("type");

        // 默认状态为正常
        String status = req.getParameter("status") == null ? "0" : req.getParameter("status");

        User user = User.setUser(
                Integer.parseInt(req.getParameter("id")),
                req.getParameter("username"),
                req.getParameter("password"),
                req.getParameter("nickname"),
                req.getParameter("avatarImage"),
                req.getParameter("telephone"),
                req.getParameter("email"),
                type,
                status);
        if (userDao.updateUser(user)) {
            JSONUtil.toJSON(resp, Result.ok("修改成功"));
        } else {
            JSONUtil.toJSON(resp, Result.error("修改失败"));
        }
    }

    private void changePassword(HttpServletRequest req, HttpServletResponse resp) {
        int id = Integer.parseInt(req.getParameter("id"));
        String oldPassword = req.getParameter("oldPassword");
        String newPassword = req.getParameter("newPassword");

        if (userDao.changePassword(id, oldPassword, newPassword)) {
            JSONUtil.toJSON(resp, Result.ok("修改成功"));
        } else {
            JSONUtil.toJSON(resp, Result.error("旧密码错误"));
        }
    }
}
