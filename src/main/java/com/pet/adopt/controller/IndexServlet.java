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

@WebServlet("/")
public class IndexServlet extends HttpServlet {
    private PetService petService = new PetServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 查询前4只宠物用于首页展示
        List<Pet> petList = petService.findAllPets();
        if (petList != null && petList.size() > 4) {
            petList = petList.subList(0, Math.min(4, petList.size()));
        }
        
        // 把查询结果存入 request 域
        req.setAttribute("petList", petList);
        
        // 转发到首页
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}

