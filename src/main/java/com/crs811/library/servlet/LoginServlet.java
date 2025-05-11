package com.crs811.library.servlet;

import com.crs811.library.dao.IUserDao;
import com.crs811.library.dao.impl.UserDaoImpl;
import com.crs811.library.entity.User;
import com.crs811.library.util.JSONUtil;
import com.crs811.library.util.Result;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // super.service(req, resp);
        String method = req.getParameter("method");

        switch (method) {
            case "login":
                login(req, resp);
                break;
            case "visitorLogin":
                visitorLogin(req, resp);
                break;
            default:
                break;
        }
    }

    //登录
    private void login(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // System.out.println(" ==== login");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String captcha = req.getParameter("captcha");
        String remember = req.getParameter("remember");

        System.out.println( "username: " + username + ", password: " + password + ", remember: " + remember);

        // 验证码校验， 验证码不区分大小写
        String sessionCaptcha = (String) req.getSession().getAttribute("captcha");
        if (!captcha.equalsIgnoreCase(sessionCaptcha)) {
            JSONUtil.toJSON(resp, Result.error("验证码错误"));
            return;
        }

        IUserDao userDao = new UserDaoImpl();
        User user = userDao.login(username, password);

        // 判断用户是否存在，存在则登录成功
        if ( user != null) {

            //保存 Session,保存用户信息
            HttpSession session = req.getSession();
            session.setAttribute("USER_IN_SESSION", user);

            // 如果用户勾选了记住密码，则保存 cookie 信息
            if (remember != null && remember.equals("on")) {
                // 设置 cookie 有效期为 5 天
                int maxAge = 60 * 60 * 24 * 5;
                // 设置 cookie 内容
                String value = user.getUsername() + "-" + user.getPassword();
                // 设置 cookie 名称
                String cookieName = "user_cookie";
                // 设置 cookie 路径
                String path = "/";
                Cookie cookie = new Cookie(cookieName, value);
                cookie.setMaxAge(maxAge);
                cookie.setPath(path);
                // 添加 cookie
                resp.addCookie(cookie);
            }
            JSONUtil.toJSON(resp, Result.ok("登录成功"));
        } else {
             JSONUtil.toJSON(resp, Result.error("用户名或密码错误"));
        }
    }

    // 游客登录,为游客用户创建 Session 信息
    private void visitorLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println(" ===== visitor Login");

        // 创建游客用户 Session 信息
        User user = new User();
        user.setAvatar("avatar.jpg");
        user.setNickname("游客");
        user.setType("-1"); // 类型为 -1 表示游客

        // 保存 Session, 并跳转到首页
        HttpSession session = req.getSession();
        session.setAttribute("USER_IN_SESSION", user);
        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }
}
