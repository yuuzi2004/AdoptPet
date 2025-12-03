package com.pet.adopt.controller;

import com.pet.adopt.entity.Pet;
import com.pet.adopt.service.PetService;
import com.pet.adopt.service.PetServiceImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// 访问路径保持为"/petManage"（或根据你的URL设计调整）
@WebServlet("/petManage")
public class PetManageController extends HttpServlet {
    private PetService petService = new PetServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 获取宠物数据
        List<Pet> petList = petService.findAllPets();

        // 2. 传递数据到页面
        request.setAttribute("petList", petList);
        request.setAttribute("totalPets", petList != null ? petList.size() : 0);

        // 3. 转发到宠物列表页面
        request.getRequestDispatcher("/pet-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}