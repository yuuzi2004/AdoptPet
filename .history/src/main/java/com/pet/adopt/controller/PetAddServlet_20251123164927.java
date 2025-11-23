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

// 访问路径：/pet/add
@WebServlet("/pet/add")
public class PetAddServlet extends HttpServlet {
    private PetService petService = new PetServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 解决中文乱码（POST 请求必须加）
        req.setCharacterEncoding("UTF-8");

        // 2. 接收前端页面传递的参数（name/type/age/gender/description）
        String name = req.getParameter("name");
        String type = req.getParameter("type");
        Integer age = Integer.parseInt(req.getParameter("age")); // 转换为整数
        String gender = req.getParameter("gender");
        String description = req.getParameter("description");

        // 3. 封装成 Pet 实体对象
        Pet pet = new Pet(name, type, age, gender, description);

        // 4. 调用 Service 层新增宠物
        boolean success = petService.addPet(pet);

        // 5. 新增成功后，重定向到宠物列表页面（避免刷新重复提交）
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/pet/list");
        } else {
            // 新增失败，跳转回新增页面并提示（后续优化）
            resp.sendRedirect(req.getContextPath() + "/add.jsp");
        }
    }
}