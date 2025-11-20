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

// 注解配置 Servlet 访问路径：前端通过 /pet/list 访问这个 Servlet
@WebServlet("/pet/list")
public class PetListServlet extends HttpServlet {
    // 依赖 Service 层对象
    private PetService petService = new PetServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 调用 Service 层查询所有宠物
        List<Pet> petList = petService.findAllPets();

        // 2. 把查询结果存入 request 域（供前端页面读取）
        req.setAttribute("petList", petList);

        // 3. 转发到宠物列表页面（后续创建）
        req.getRequestDispatcher("/pages/pet/list.jsp").forward(req, resp);
    }

    // 兼容 POST 请求（直接调用 doGet 方法）
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}