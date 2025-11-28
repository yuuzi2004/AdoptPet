package com.pet.adopt.controller;

import com.pet.adopt.entity.Pet;
import com.pet.adopt.service.PetService;
import com.pet.adopt.service.PetServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 宠物详情页控制器：根据宠物ID查询详情并转发到详情页面
 */
@WebServlet("/pet/detail")
public class PetDetailServlet extends HttpServlet {
    // 注入PetService服务
    private PetService petService = new PetServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 获取前端传递的宠物ID参数
        String petIdStr = req.getParameter("id");
        Integer petId = null;

        // 2. 校验并转换ID参数
        if (petIdStr == null || petIdStr.trim().isEmpty()) {
            // ID为空，重定向回列表页并提示错误
            resp.sendRedirect(req.getContextPath() + "/pet/list?error=参数错误，未选择宠物");
            return;
        }

        try {
            petId = Integer.parseInt(petIdStr.trim());
        } catch (NumberFormatException e) {
            // ID不是数字，重定向回列表页
            resp.sendRedirect(req.getContextPath() + "/pet/list?error=宠物ID格式错误");
            return;
        }

        // 3. 调用Service层查询宠物详情
        Pet pet = petService.findPetById(petId);
        if (pet == null) {
            // 未找到该宠物，重定向回列表页
            resp.sendRedirect(req.getContextPath() + "/pet/list?error=未找到该宠物信息");
            return;
        }

        // 4. 将宠物信息存入request域，供详情页展示
        req.setAttribute("pet", pet);

        // 5. 转发到宠物详情页面
        req.getRequestDispatcher("/detail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp); // 兼容POST请求
    }
}