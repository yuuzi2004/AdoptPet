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

@WebServlet("/user/pet/update")
@MultipartConfig(maxFileSize = 5242880, maxRequestSize = 10485760)
public class UserPetUpdateServlet extends HttpServlet {
    private PetService petService = new PetServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // 1. 检查用户是否已登录
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        String errorMsg = null;

        try {
            // 2. 获取表单数据
            String idStr = req.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                errorMsg = URLEncoder.encode("参数错误，未选择宠物", StandardCharsets.UTF_8);
                resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
                return;
            }

            Integer petId;
            try {
                petId = Integer.parseInt(idStr.trim());
            } catch (NumberFormatException e) {
                errorMsg = URLEncoder.encode("宠物ID格式错误", StandardCharsets.UTF_8);
                resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
                return;
            }

            // 3. 验证权限：确保该宠物属于当前用户
            Pet existingPet = petService.findPetByIdAndUserId(petId, userId);
            if (existingPet == null) {
                errorMsg = URLEncoder.encode("未找到该宠物信息或您没有权限修改", StandardCharsets.UTF_8);
                resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
                return;
            }

            // 4. 接收表单参数
            String name = req.getParameter("name");
            String type = req.getParameter("type");
            String ageStr = req.getParameter("age");
            String gender = req.getParameter("gender");
            String description = req.getParameter("description");

            // 5. 参数验证
            if (name == null || name.trim().isEmpty()) {
                req.setAttribute("error", "宠物名称不能为空！");
                req.setAttribute("pet", existingPet);
                req.getRequestDispatcher("/user-edit-pet.jsp").forward(req, resp);
                return;
            }

            if (type == null || type.trim().isEmpty()) {
                req.setAttribute("error", "请选择宠物类型！");
                req.setAttribute("pet", existingPet);
                req.getRequestDispatcher("/user-edit-pet.jsp").forward(req, resp);
                return;
            }

            if (ageStr == null || ageStr.trim().isEmpty()) {
                req.setAttribute("error", "请输入宠物年龄！");
                req.setAttribute("pet", existingPet);
                req.getRequestDispatcher("/user-edit-pet.jsp").forward(req, resp);
                return;
            }

            if (gender == null || gender.trim().isEmpty()) {
                req.setAttribute("error", "请选择宠物性别！");
                req.setAttribute("pet", existingPet);
                req.getRequestDispatcher("/user-edit-pet.jsp").forward(req, resp);
                return;
            }

            if (description == null || description.trim().isEmpty()) {
                req.setAttribute("error", "宠物描述不能为空！");
                req.setAttribute("pet", existingPet);
                req.getRequestDispatcher("/user-edit-pet.jsp").forward(req, resp);
                return;
            }

            if (description.trim().length() < 30) {
                req.setAttribute("error", "宠物描述至少需要30字，请详细描述！");
                req.setAttribute("pet", existingPet);
                req.getRequestDispatcher("/user-edit-pet.jsp").forward(req, resp);
                return;
            }

            // 6. 转换年龄
            Integer age;
            try {
                age = Integer.parseInt(ageStr.trim());
                if (age < 0 || age > 30) {
                    req.setAttribute("error", "年龄必须在0-30岁之间！");
                    req.setAttribute("pet", existingPet);
                    req.getRequestDispatcher("/user-edit-pet.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error", "请输入有效的年龄！");
                req.setAttribute("pet", existingPet);
                req.getRequestDispatcher("/user-edit-pet.jsp").forward(req, resp);
                return;
            }

            // 7. 处理文件上传（如果有新图片）
            String imagePath = existingPet.getImagePath(); // 默认使用原图片
            try {
                Part filePart = req.getPart("image");
                if (filePart != null && filePart.getSize() > 0) {
                    String realPath = req.getServletContext().getRealPath("");
                    imagePath = FileUploadUtils.saveFile(filePart, realPath);
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "图片上传失败：" + e.getMessage());
                req.setAttribute("pet", existingPet);
                req.getRequestDispatcher("/user-edit-pet.jsp").forward(req, resp);
                return;
            }

            // 8. 封装成 Pet 实体对象
            Pet pet = new Pet();
            pet.setId(petId);
            pet.setName(name.trim());
            pet.setType(type.trim());
            pet.setAge(age);
            pet.setGender(gender.trim());
            pet.setDescription(description.trim());
            pet.setImagePath(imagePath);
            pet.setUserId(userId);

            // 9. 更新宠物信息
            boolean success = petService.updatePet(pet);

            // 10. 处理结果
            if (success) {
                String successMsg = URLEncoder.encode("修改成功！宠物信息已更新。", StandardCharsets.UTF_8);
                resp.sendRedirect(req.getContextPath() + "/user/my-pets?success=" + successMsg);
            } else {
                errorMsg = URLEncoder.encode("修改失败，请稍后重试！", StandardCharsets.UTF_8);
                resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = URLEncoder.encode("系统错误：" + e.getMessage(), StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
        }
    }
}

