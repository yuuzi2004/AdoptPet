package com.pet.adopt.controller;

import com.pet.adopt.service.PetService;
import com.pet.adopt.service.PetServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/user/pet/delete")
public class UserPetDeleteServlet extends HttpServlet {
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
            // 2. 获取宠物ID
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
            // 通过查询验证权限
            if (petService.findPetByIdAndUserId(petId, userId) == null) {
                errorMsg = URLEncoder.encode("未找到该宠物信息或您没有权限删除", StandardCharsets.UTF_8);
                resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
                return;
            }

            // 4. 删除宠物信息
            boolean success = petService.deletePet(petId, userId);

            // 5. 处理结果
            if (success) {
                String successMsg = URLEncoder.encode("删除成功！宠物信息已从列表中移除。", StandardCharsets.UTF_8);
                resp.sendRedirect(req.getContextPath() + "/user/my-pets?success=" + successMsg);
            } else {
                errorMsg = URLEncoder.encode("删除失败，请稍后重试！", StandardCharsets.UTF_8);
                resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = URLEncoder.encode("系统错误：" + e.getMessage(), StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
        }
    }
}

