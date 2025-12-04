package com.pet.adopt.controller;

import com.pet.adopt.service.PetService;
import com.pet.adopt.service.PetServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/admin/pet/delete")
public class AdminPetDeleteServlet extends HttpServlet {
    private PetService petService = new PetServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // 1. 检查管理员是否登录
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
            return;
        }

        // 2. 获取宠物ID
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            String errorMsg = URLEncoder.encode("参数错误，未选择宠物", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/admin/pet/list?error=" + errorMsg);
            return;
        }

        Integer petId;
        try {
            petId = Integer.parseInt(idStr.trim());
        } catch (NumberFormatException e) {
            String errorMsg = URLEncoder.encode("宠物ID格式错误", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/admin/pet/list?error=" + errorMsg);
            return;
        }

        // 3. 管理员删除（不需要验证userId）
        boolean success = ((PetServiceImpl) petService).deletePetByAdmin(petId);

        // 4. 处理结果
        if (success) {
            String successMsg = URLEncoder.encode("删除成功！宠物信息已从列表中移除。", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/admin/pet/list?success=" + successMsg);
        } else {
            String errorMsg = URLEncoder.encode("删除失败，请稍后重试！", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/admin/pet/list?error=" + errorMsg);
        }
    }
}

