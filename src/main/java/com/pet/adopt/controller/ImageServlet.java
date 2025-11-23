package com.pet.adopt.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * 图片访问Servlet
 * 用于安全地访问上传的图片
 */
@WebServlet("/uploads/*")
public class ImageServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        
        if (pathInfo == null || pathInfo.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // 获取文件路径
        String realPath = req.getServletContext().getRealPath("");
        String filePath = realPath + File.separator + "uploads" + File.separator + pathInfo.substring(1);
        
        File file = new File(filePath);
        
        if (!file.exists() || !file.isFile()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // 设置响应头
        String contentType = getServletContext().getMimeType(file.getName());
        if (contentType == null) {
            contentType = "image/jpeg";
        }
        
        resp.setContentType(contentType);
        resp.setContentLengthLong(file.length());
        resp.setHeader("Cache-Control", "public, max-age=31536000");
        
        // 输出文件
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = resp.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }
}

