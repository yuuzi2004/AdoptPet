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
 * 领养申请成功页面Servlet
 */
@WebServlet("/pet/adopt/success")
public class AdoptionSuccessServlet extends HttpServlet {
    private PetService petService = new PetServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String petIdStr = req.getParameter("petId");
        
        if (petIdStr != null && !petIdStr.isEmpty()) {
            try {
                Integer petId = Integer.parseInt(petIdStr);
                Pet pet = petService.findPetById(petId);
                req.setAttribute("pet", pet);
            } catch (NumberFormatException e) {
                // 忽略
            }
        }
        
        req.getRequestDispatcher("/adopt-success.jsp").forward(req, resp);
    }
}

