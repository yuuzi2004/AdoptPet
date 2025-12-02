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

@WebServlet("/admin/pet/list")
public class AdminPetListServlet extends HttpServlet {
    private PetService petService = new PetServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 检查管理员是否登录
        HttpSession session = req.getSession();
        if (session.getAttribute("adminId") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
            return;
        }

        // 查询所有宠物
        List<Pet> petList = petService.findAllPets();
        req.setAttribute("petList", petList);

        // 转发到管理员宠物管理页面（复用dashboard.jsp的表格样式，或创建独立页面）
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}

