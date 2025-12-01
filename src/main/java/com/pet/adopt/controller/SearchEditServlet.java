package com.pet.adopt.controller;

import com.pet.adopt.dao.PetSearchDao;
import com.pet.adopt.dao.PetSearchDaoImpl;
import com.pet.adopt.entity.PetSearch;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/search/edit")
public class SearchEditServlet extends HttpServlet {
    private PetSearchDao petSearchDao = new PetSearchDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 获取参数id
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            req.setAttribute("error", "参数错误：缺少寻宠信息ID");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
            return;
        }
        Integer id = Integer.parseInt(idStr);

        // 2. 获取当前用户ID（权限验证：只能编辑自己的发布）
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 3. 查询该id且属于当前用户的寻宠信息
        PetSearch search = petSearchDao.findByIdAndUserId(id, userId);
        if (search == null) {
            req.setAttribute("error", "未找到该寻宠信息或没有权限编辑");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
            return;
        }

        // 4. 存入request，转发到编辑页面
        req.setAttribute("search", search);
        req.getRequestDispatcher("/user/edit-search.jsp").forward(req, resp);
    }
}