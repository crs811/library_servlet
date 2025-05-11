package com.crs811.library.servlet;

import com.crs811.library.util.CaptchaUtil;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/captcha")
public class captchaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Generate a new captcha image and store it in the session
        // 设置页面不缓存
        resp.setHeader("Pragma", "No-cache");
        resp.setHeader("Cache-Control", "no-cache");
        resp.setDateHeader("Expires", 0);
        resp.setContentType("image/gif");

        Object[] objs = CaptchaUtil.createImage();

        HttpSession session = req.getSession();
        session.setAttribute("captcha", objs[0]);

        BufferedImage image = (BufferedImage) objs[1];

        OutputStream out = resp.getOutputStream();
        ImageIO.write(image, "png", out);
        out.flush();
        out.close();
    }
}
