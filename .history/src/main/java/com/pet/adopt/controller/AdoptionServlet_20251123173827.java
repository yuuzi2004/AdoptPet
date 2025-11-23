package com.pet.adopt.controller;

import com.pet.adopt.entity.AdoptionApplication;
import com.pet.adopt.entity.Pet;
import com.pet.adopt.service.AdoptionService;
import com.pet.adopt.service.AdoptionServiceImpl;
import com.pet.adopt.service.PetService;
import com.pet.adopt.service.PetServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 领养申请Servlet
 * 处理领养申请的显示和提交
 */
@WebServlet("/pet/adopt/*")
public class AdoptionServlet extends HttpServlet {
    private AdoptionService adoptionService = new AdoptionServiceImpl();
    private PetService petService = new PetServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        
        // 如果是 /pet/adopt/form，显示申请表单
        if (pathInfo != null && pathInfo.equals("/form")) {
            String petIdStr = req.getParameter("petId");
            if (petIdStr == null || petIdStr.isEmpty()) {
                req.setAttribute("error", "请选择要领养的宠物！");
                req.getRequestDispatcher("/pet/list").forward(req, resp);
                return;
            }
            
            try {
                Integer petId = Integer.parseInt(petIdStr);
                Pet pet = petService.findPetById(petId);
                
                if (pet == null) {
                    req.setAttribute("error", "宠物不存在！");
                    req.getRequestDispatcher("/pet/list").forward(req, resp);
                    return;
                }
                
                // 检查用户是否已经申请过
                HttpSession session = req.getSession();
                Integer userId = (Integer) session.getAttribute("userId");
                if (userId != null && adoptionService.hasUserApplied(userId, petId)) {
                    req.setAttribute("error", "您已经申请过领养该宠物了！");
                    req.setAttribute("pet", pet);
                    req.getRequestDispatcher("/adopt.jsp").forward(req, resp);
                    return;
                }
                
                req.setAttribute("pet", pet);
                req.getRequestDispatcher("/adopt.jsp").forward(req, resp);
            } catch (NumberFormatException e) {
                req.setAttribute("error", "无效的宠物ID！");
                req.getRequestDispatcher("/pet/list").forward(req, resp);
            }
        } else {
            // 其他情况重定向到列表页
            resp.sendRedirect(req.getContextPath() + "/pet/list");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            req.setAttribute("error", "请先登录！");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
        
        String petIdStr = req.getParameter("petId");
        String reason = req.getParameter("reason");
        String contact = req.getParameter("contact");
        
        // 验证参数
        if (petIdStr == null || petIdStr.isEmpty() || 
            reason == null || reason.trim().isEmpty() ||
            contact == null || contact.trim().isEmpty()) {
            req.setAttribute("error", "请填写完整的申请信息！");
            if (petIdStr != null && !petIdStr.isEmpty()) {
                try {
                    Integer petId = Integer.parseInt(petIdStr);
                    Pet pet = petService.findPetById(petId);
                    req.setAttribute("pet", pet);
                } catch (NumberFormatException e) {
                    // 忽略
                }
            }
            req.getRequestDispatcher("/adopt.jsp").forward(req, resp);
            return;
        }
        
        try {
            Integer petId = Integer.parseInt(petIdStr);
            
            // 检查是否已经申请过
            if (adoptionService.hasUserApplied(userId, petId)) {
                req.setAttribute("error", "您已经申请过领养该宠物了！");
                Pet pet = petService.findPetById(petId);
                req.setAttribute("pet", pet);
                req.getRequestDispatcher("/adopt.jsp").forward(req, resp);
                return;
            }
            
            // 创建申请对象
            AdoptionApplication application = new AdoptionApplication(
                petId, userId, reason.trim(), contact.trim()
            );
            
            // 提交申请
            boolean success = adoptionService.submitApplication(application);
            
            if (success) {
                // 申请成功，重定向到成功页面或列表页
                resp.sendRedirect(req.getContextPath() + "/pet/adopt/success?petId=" + petId);
            } else {
                req.setAttribute("error", "申请提交失败，请稍后重试！");
                Pet pet = petService.findPetById(petId);
                req.setAttribute("pet", pet);
                req.getRequestDispatcher("/adopt.jsp").forward(req, resp);
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "无效的宠物ID！");
            req.getRequestDispatcher("/pet/list").forward(req, resp);
        }
    }
}

