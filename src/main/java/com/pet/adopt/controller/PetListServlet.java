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
import java.util.List;

@WebServlet("/pet/list")
public class PetListServlet extends HttpServlet {
    private PetService petService = new PetServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 获取前端传递的筛选参数（类型、性别、年龄范围）
        String type = req.getParameter("type");
        String gender = req.getParameter("gender");
        String minAgeStr = req.getParameter("minAge");
        String maxAgeStr = req.getParameter("maxAge");

        // 2. 处理年龄参数：转换为Integer类型，空值则设为null
        Integer minAge = null;
        Integer maxAge = null;
        if (minAgeStr != null && !minAgeStr.trim().isEmpty()) {
            try {
                minAge = Integer.parseInt(minAgeStr.trim());
            } catch (NumberFormatException e) {
                minAge = null; // 转换失败则设为null，不参与筛选
            }
        }
        if (maxAgeStr != null && !maxAgeStr.trim().isEmpty()) {
            try {
                maxAge = Integer.parseInt(maxAgeStr.trim());
            } catch (NumberFormatException e) {
                maxAge = null; // 转换失败则设为null，不参与筛选
            }
        }

        // 3. 根据参数调用对应的查询方法
        List<Pet> petList;
        if ((type == null || type.trim().isEmpty())
                && (gender == null || gender.trim().isEmpty())
                && minAge == null
                && maxAge == null) {
            // 无筛选条件时查询所有
            petList = petService.findAllPets();
        } else {
            // 有筛选条件时调用带年龄的条件查询
            petList = petService.findPetsByCondition(type, gender, minAge, maxAge);
        }

        // 4. 把查询结果和筛选参数存入request域（供前端回显）
        req.setAttribute("petList", petList);
        req.setAttribute("selectedType", type);
        req.setAttribute("selectedGender", gender);
        req.setAttribute("selectedMinAge", minAgeStr);
        req.setAttribute("selectedMaxAge", maxAgeStr);

        // 5. 转发到宠物列表页面
        req.getRequestDispatcher("/list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp); // 兼容 POST 请求
    }
}