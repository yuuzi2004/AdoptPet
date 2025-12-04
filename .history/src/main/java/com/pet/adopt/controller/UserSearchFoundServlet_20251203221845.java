package com.pet.adopt.controller;

import com.pet.adopt.entity.PetSearch;
import com.pet.adopt.service.PetSearchService;
import com.pet.adopt.service.PetSearchServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * 用户在个人中心将寻宠信息标记为“已找回”的处理 Servlet
 */
@WebServlet("/user/search/found")
public class UserSearchFoundServlet extends HttpServlet {

    private final PetSearchService petSearchService = new PetSearchServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // 1. 校验登录状态
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=请先登录后再操作");
            return;
        }
        Integer userId = (Integer) session.getAttribute("userId");

        // 2. 获取并校验参数
        String idStr = req.getParameter("id");
        Integer searchId = null;
        try {
            searchId = Integer.parseInt(idStr);
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=非法的寻宠信息ID");
            return;
        }

        // 3. 根据ID和当前用户查询寻宠信息（做权限校验）
        PetSearch petSearch = petSearchService.getPetSearchByIdAndUserId(searchId, userId);
        if (petSearch == null) {
            resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=未找到对应的寻宠信息或无操作权限");
            return;
        }

        // 4. 标记为“已找回”
        petSearch.setStatus("found");
        boolean success = petSearchService.updatePetSearch(petSearch);

        // 5. 根据结果重定向回个人中心
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/user/my-pets?success=已将「" + petSearch.getName() + "」标记为已找回");
        } else {
            resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=标记失败，请稍后重试");
        }
    }
}


