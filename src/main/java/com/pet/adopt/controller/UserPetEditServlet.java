package com.pet.adopt.controller;

import com.pet.adopt.entity.Pet;
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

@WebServlet("/user/pet/edit")
public class UserPetEditServlet extends HttpServlet {
    private PetService petService = new PetServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // 1. 检查用户是否已登录
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?redirect=" + 
                req.getRequestURI() + "?" + req.getQueryString());
            return;
        }

        // 2. 获取宠物ID
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            String errorMsg = URLEncoder.encode("参数错误，未选择宠物", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
            return;
        }

        Integer petId;
        try {
            petId = Integer.parseInt(idStr.trim());
        } catch (NumberFormatException e) {
            String errorMsg = URLEncoder.encode("宠物ID格式错误", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
            return;
        }

        // 3. 获取当前用户ID
        Integer userId = (Integer) session.getAttribute("userId");

        // 4. 查询宠物信息（验证权限：只能编辑自己发布的）
        Pet pet = petService.findPetByIdAndUserId(petId, userId);
        if (pet == null) {
            String errorMsg = URLEncoder.encode("未找到该宠物信息或您没有权限编辑", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
            return;
        }

        // 5. 将宠物信息传递到编辑页面
        req.setAttribute("pet", pet);
        req.getRequestDispatcher("/user-edit-pet.jsp").forward(req, resp);
    }
}

