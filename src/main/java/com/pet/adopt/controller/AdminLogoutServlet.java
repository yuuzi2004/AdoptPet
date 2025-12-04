package com.pet.adopt.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/logout")
public class AdminLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 统一编码，避免乱码
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // 2. 获取session（不创建新session）
        HttpSession session = req.getSession(false);
        if (session != null) {
            // 3. 手动清空所有管理员相关属性
            session.removeAttribute("adminId");
            session.removeAttribute("adminUsername");
            session.removeAttribute("adminName");
            session.removeAttribute("adminRole");
            // 4. 销毁session
            session.invalidate();
        }

        // 5. 跳转到【登录类型选择页】（核心！替换成你实际的选择页路径）
        // 示例路径：/login-type.jsp （你需要改成自己的文件路径，比如 /pages/select-login.jsp）
        resp.sendRedirect(req.getContextPath() + "/login_choice.jsp?logout=success");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}