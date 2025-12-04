package com.pet.adopt.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// 管理员登录的访问路径：/admin/login
@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    // 这里暂时用固定的管理员账号密码做测试（后续你可以改成从数据库查询）
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "admin123";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 设置编码，避免中文乱码
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // 2. 获取登录表单提交的账号和密码
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // 3. 验证账号密码（实际项目中应从数据库查询）
        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            // 登录成功：创建session并存储管理员信息
            HttpSession session = req.getSession();
            session.setAttribute("adminId", 1); // 模拟管理员ID
            session.setAttribute("adminUsername", username); // 存储用户名

            // ========== 唯一修改：跳转到仪表盘Servlet（/admin/dashboard） ==========
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } else {
            // 登录失败：返回登录页并显示错误信息
            req.setAttribute("error", "管理员账号或密码错误！");
            req.getRequestDispatcher("/admin/login.jsp").forward(req, resp);
        }
    }

    // 处理GET请求（如果直接访问登录接口，跳转到登录页）
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
    }
}