package com.pet.adopt.controller;

import com.pet.adopt.entity.PetSearch;
import com.pet.adopt.service.PetSearchService;
import com.pet.adopt.service.PetSearchServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/center")
public class UserCenterServlet extends HttpServlet {
    // 只保留寻宠信息服务
    private PetSearchService petSearchService = new PetSearchServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 获取当前登录用户ID
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // 调试日志
        System.out.println("===== UserCenterServlet 调试 =====");
        System.out.println("Session是否存在：" + (session != null ? "是" : "否"));

        if (session != null) {
            userId = (Integer) session.getAttribute("userId");
            System.out.println("当前登录用户ID：" + (userId == null ? "未获取到" : userId));
        }

        // 未登录跳转到登录页
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=请先登录查看个人中心");
            return;
        }

        // 2. 核心：只查询用户发布的寻宠信息
        List<PetSearch> myPetSearchList = petSearchService.getMyPetSearchList(userId);
        req.setAttribute("myPetSearchList", myPetSearchList);
        System.out.println("用户发布的寻宠信息数量：" + myPetSearchList.size()); // 关键日志

        // 3. 重定向到个人中心页面（使用MyPetsServlet的完整功能）
        resp.sendRedirect(req.getContextPath() + "/user/my-pets");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}