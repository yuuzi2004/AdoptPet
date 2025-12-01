package com.pet.adopt.controller;

import com.pet.adopt.dao.PetSearchDao;
import com.pet.adopt.dao.PetSearchDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/search/delete")
public class SearchDeleteServlet extends HttpServlet {
    private PetSearchDao petSearchDao = new PetSearchDaoImpl();

    // 改为doGet方法，适配链接点击触发的删除请求
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 获取参数id
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/pet/search?action=default&error=参数错误：缺少寻宠信息ID");
            return;
        }
        Integer id;
        try {
            id = Integer.parseInt(idStr); // 增加异常处理，防止非数字ID
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/pet/search?action=default&error=参数错误：无效的ID格式");
            return;
        }

        // 2. 获取当前用户ID（权限验证：只能删除自己的发布）
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 3. 调用DAO删除（根据id和userId，避免越权删除）
        int rows = petSearchDao.deleteByIdAndUserId(id, userId);

        // 4. 跳转结果页（建议跳回"我的发布"页面，而不是默认页）
        if (rows > 0) {
            resp.sendRedirect(req.getContextPath() + "/pet/search?action=myList&success=寻宠信息删除成功");
        } else {
            resp.sendRedirect(req.getContextPath() + "/pet/search?action=myList&error=删除失败，未找到该信息或没有权限");
        }
    }

    // 如果需要支持POST请求（比如表单提交），可以保留doPost并调用doGet
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}