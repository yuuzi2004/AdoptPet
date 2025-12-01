package com.pet.adopt.controller;

import com.pet.adopt.dao.PetSearchDao;
import com.pet.adopt.dao.PetSearchDaoImpl;
import com.pet.adopt.entity.PetSearch;
import com.pet.adopt.utils.FileUploadUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/user/search/update")
@MultipartConfig // 支持文件上传
public class SearchUpdateServlet extends HttpServlet {
    private PetSearchDao petSearchDao = new PetSearchDaoImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 设置编码
        req.setCharacterEncoding("UTF-8");

        // 2. 获取表单参数
        Integer id = Integer.parseInt(req.getParameter("id"));
        Integer userId = Integer.parseInt(req.getParameter("userId"));
        String name = req.getParameter("name");
        String type = req.getParameter("type");
        String location = req.getParameter("location");
        // 转换前端传来的datetime-local格式（yyyy-MM-dd'T'HH:mm）为LocalDateTime
        LocalDateTime lostTime = LocalDateTime.parse(
                req.getParameter("lostTime"),
                DateTimeFormatter.ISO_LOCAL_DATE_TIME
        );
        String description = req.getParameter("description");
        String contact = req.getParameter("contact");
        String status = req.getParameter("status");

        // 3. 处理文件上传（如果有新图片）
        Part imagePart = req.getPart("image");
        String imagePath = null;
        if (imagePart != null && imagePart.getSize() > 0) {
            try {
                // 调用你的FileUploadUtils保存图片
                // 参数1：上传的文件Part
                // 参数2：项目真实路径（通过ServletContext获取）
                String realPath = req.getServletContext().getRealPath("");
                imagePath = FileUploadUtils.saveFile(imagePart, realPath);
            } catch (IllegalArgumentException e) {
                // 捕获文件类型/大小错误，返回提示
                resp.sendRedirect(req.getContextPath() + "/user/search/edit?id=" + id + "&error=" + e.getMessage());
                return;
            }
        }

        // 4. 构建PetSearch对象（如果有新图片才更新，否则保留原图片）
        PetSearch search = petSearchDao.findByIdAndUserId(id, userId); // 先查询原信息
        if (search == null) {
            resp.sendRedirect(req.getContextPath() + "/pet/search?action=default&error=未找到寻宠信息");
            return;
        }
        // 更新字段
        search.setName(name);
        search.setType(type);
        search.setLocation(location);
        search.setLostTime(lostTime);
        search.setDescription(description);
        search.setContact(contact);
        search.setStatus(status);
        if (imagePath != null) {
            // 如果上传了新图片，删除旧图片（可选，避免冗余文件）
            if (search.getImagePath() != null) {
                FileUploadUtils.deleteFile(search.getImagePath(), req.getServletContext().getRealPath(""));
            }
            search.setImagePath(imagePath); // 覆盖为新图片路径
        }

        // 5. 调用DAO更新数据
        int rows = petSearchDao.update(search);

        // 6. 跳转结果页
        if (rows > 0) {
            resp.sendRedirect(req.getContextPath() + "/pet/search?action=default&success=寻宠信息更新成功");
        } else {
            resp.sendRedirect(req.getContextPath() + "/pet/search?action=default&error=寻宠信息更新失败，请重试");
        }
    }
}