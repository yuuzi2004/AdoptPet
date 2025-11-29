package com.pet.adopt.controller;

import com.pet.adopt.entity.Pet;
import com.pet.adopt.service.PetService;
import com.pet.adopt.service.PetServiceImpl;
import com.pet.adopt.utils.FileUploadUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

// 访问路径：/pet/add
@WebServlet("/pet/add")
@MultipartConfig(maxFileSize = 5242880, maxRequestSize = 10485760) // 5MB文件，10MB请求
public class PetAddServlet extends HttpServlet {
    private PetService petService = new PetServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // GET请求重定向到表单页面
        resp.sendRedirect(req.getContextPath() + "/add.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 1. 解决中文乱码（POST 请求必须加）
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        
        // 用于记录错误信息
        String errorMsg = null;

        // 2. 检查用户是否已登录
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            req.setAttribute("error", "请先登录后再提交信息！");
            req.getRequestDispatcher("/add.jsp").forward(req, resp);
            return;
        }

        // 3. 接收前端页面传递的参数
        String name = req.getParameter("name");
        String type = req.getParameter("type");
        String ageStr = req.getParameter("age");
        String gender = req.getParameter("gender");
        String description = req.getParameter("description");

        // 4. 参数验证
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "宠物名称不能为空！");
            req.getRequestDispatcher("/add.jsp").forward(req, resp);
            return;
        }

        if (type == null || type.trim().isEmpty()) {
            req.setAttribute("error", "请选择宠物类型！");
            req.getRequestDispatcher("/add.jsp").forward(req, resp);
            return;
        }

        if (ageStr == null || ageStr.trim().isEmpty()) {
            req.setAttribute("error", "请输入宠物年龄！");
            req.getRequestDispatcher("/add.jsp").forward(req, resp);
            return;
        }

        if (gender == null || gender.trim().isEmpty()) {
            req.setAttribute("error", "请选择宠物性别！");
            req.getRequestDispatcher("/add.jsp").forward(req, resp);
            return;
        }

        if (description == null || description.trim().isEmpty()) {
            req.setAttribute("error", "宠物描述不能为空！");
            req.getRequestDispatcher("/add.jsp").forward(req, resp);
            return;
        }

        if (description.trim().length() < 30) {
            req.setAttribute("error", "宠物描述至少需要30字，请详细描述！");
            req.getRequestDispatcher("/add.jsp").forward(req, resp);
            return;
        }

        // 5. 转换年龄
        Integer age;
        try {
            age = Integer.parseInt(ageStr.trim());
            if (age < 0 || age > 30) {
                req.setAttribute("error", "年龄必须在0-30岁之间！");
                req.getRequestDispatcher("/add.jsp").forward(req, resp);
                return;
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "请输入有效的年龄！");
            req.getRequestDispatcher("/add.jsp").forward(req, resp);
            return;
        }

        // 6. 处理文件上传
        String imagePath = null;
        try {
            Part filePart = req.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String realPath = req.getServletContext().getRealPath("");
                imagePath = FileUploadUtils.saveFile(filePart, realPath);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "图片上传失败：" + e.getMessage());
            req.getRequestDispatcher("/add.jsp").forward(req, resp);
            return;
        }

        // 7. 封装成 Pet 实体对象
        Pet pet = new Pet(name.trim(), type.trim(), age, gender.trim(), description.trim(), imagePath);

        // 8. 调用 Service 层新增宠物
        boolean success = petService.addPet(pet);

        // 9. 处理结果
        if (success) {
            // 新增成功，重定向到宠物列表页面（避免刷新重复提交）
            // 对中文消息进行URL编码
            String successMsg = URLEncoder.encode("提交成功！宠物信息已添加到领养列表。", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/pet/list?success=" + successMsg);
        } else {
            // 新增失败，返回错误信息
            req.setAttribute("error", "提交失败，请稍后重试！可能是网络问题或服务器错误。");
            req.getRequestDispatcher("/add.jsp").forward(req, resp);
        }
    }
}