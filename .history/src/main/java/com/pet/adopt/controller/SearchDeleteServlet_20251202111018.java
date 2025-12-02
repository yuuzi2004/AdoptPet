package com.pet.adopt.controller;

import com.pet.adopt.dao.PetSearchDao;
import com.pet.adopt.dao.PetSearchDaoImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/user/search/delete")
public class SearchDeleteServlet extends HttpServlet {
    private PetSearchDao petSearchDao = new PetSearchDaoImpl();

    // 改为doGet方法，适配链接点击触发的删除请求
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // 1. 获取参数id
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            String errorMsg = URLEncoder.encode("参数错误，未选择寻宠信息", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
            return;
        }
        Integer id;
        try {
            id = Integer.parseInt(idStr.trim()); // 增加异常处理，防止非数字ID
        } catch (NumberFormatException e) {
            String errorMsg = URLEncoder.encode("寻宠信息ID格式错误", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
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

        // 4. 跳转结果页：重定向到个人中心页面，与其他删除功能保持一致
        if (rows > 0) {
            String successMsg = URLEncoder.encode("删除成功！寻宠信息已从列表中移除。", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/user/my-pets?success=" + successMsg);
        } else {
            String errorMsg = URLEncoder.encode("删除失败，未找到该信息或没有权限", StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
        }
    }

    // 如果需要支持POST请求（比如表单提交），可以保留doPost并调用doGet
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}