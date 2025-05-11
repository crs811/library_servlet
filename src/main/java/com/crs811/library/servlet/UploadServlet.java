package com.crs811.library.servlet;

import com.crs811.library.util.JSONUtil;
import com.crs811.library.util.Result;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@WebServlet("/upload")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
public class UploadServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=utf-8");

        System.out.println("==== upload file ====");
        // 获取上传的文件
        Part filePart = req.getPart("imageFile");
        //String fileName = req.getParameter("imageName");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // 获取原始文件名
        // System.out.println("fileName1: " + fileName);

        String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1); // 获取文件扩展名

        fileName = generateImageName(fileExtension); // 生成新的文件名
        // System.out.println("fileName2: " + fileName);

        // 指定文件保存路径
        String savePath = getServletContext().getRealPath("static/LightYearAdmin/images/users/") + fileName; //保存的路径

        // System.out.println(savePath);

        // 保存文件到指定路径
        filePart.write(savePath);

        // 文件上传成功后的处理逻辑
        JSONUtil.toJSON(resp, Result.ok(fileName));
    }

    protected String generateImageName(String fileExtension) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String timestamp = dateFormat.format(new Date());

//        UUID uuid = UUID.randomUUID(); // 生成UUID
//        String imageName = "image_" + uuid + "." + fileExtension;

        return "image_" + timestamp + "." + fileExtension;
    }
}

