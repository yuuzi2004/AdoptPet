package com.pet.adopt.controller;

import com.pet.adopt.entity.Pet;
import com.pet.adopt.entity.AdoptionApplication; // 新增：导入领养申请实体类
import com.pet.adopt.service.PetService;
import com.pet.adopt.service.PetServiceImpl;
import com.pet.adopt.service.AdoptionApplicationService; // 新增：导入领养申请Service
import com.pet.adopt.service.AdoptionApplicationServiceImpl; // 新增：导入领养申请Service实现类

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
    // 新增：创建领养申请Service对象
    private AdoptionApplicationService adoptionService = new AdoptionApplicationServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // 1. 检查用户是否已登录（你的原有逻辑，保留）
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?redirect=" +
                    req.getRequestURI());
            return;
        }

        // 2. 获取当前用户ID（你的原有逻辑，保留）
        Integer userId = (Integer) session.getAttribute("userId");

        // 3. 查询该用户发布的所有宠物信息（你的原有逻辑，保留）
        List<Pet> petList = petService.findPetsByUserId(userId);
        req.setAttribute("petList", petList);

        // 新增：4. 查询该用户的所有领养申请记录
        List<AdoptionApplication> applicationList = adoptionService.getApplicationsByUserId(userId);
        req.setAttribute("applicationList", applicationList); // 传递到JSP页面

        // 5. 转发到个人中心页面（你的原有逻辑，保留）
        req.getRequestDispatcher("/my-pets.jsp").forward(req, resp);
    }
}