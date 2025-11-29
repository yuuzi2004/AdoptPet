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
import java.util.List;

@WebServlet("/user/my-pets")
public class MyPetsServlet extends HttpServlet {
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
                req.getRequestURI());
            return;
        }

        // 2. 获取当前用户ID
        Integer userId = (Integer) session.getAttribute("userId");

        // 3. 查询该用户发布的所有宠物信息
        List<Pet> petList = petService.findPetsByUserId(userId);

        // 4. 将结果存入request域
        req.setAttribute("petList", petList);

        // 5. 转发到我的发布页面
        req.getRequestDispatcher("/my-pets.jsp").forward(req, resp);
    }
}

