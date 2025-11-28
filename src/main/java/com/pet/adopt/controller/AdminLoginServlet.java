package com.pet.adopt.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.pet.adopt.utils.JdbcUtils;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 统一编码（新增：响应编码也需设置，避免中文乱码）
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // 2. 获取表单参数（关键：与管理员登录页的input name保持一致）
        // 原参数名是username/password，需确认登录页的input name，若登录页是adminAccount/adminPassword则修改此处
        // 👇 若管理员登录页的input name是adminAccount/adminPassword，替换下面两行：
        // String username = req.getParameter("adminAccount");
        // String password = req.getParameter("adminPassword");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // 3. 空值校验（新增：避免空参数查询数据库）
        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "账号或密码不能为空！");
            req.getRequestDispatcher("/admin/login.jsp").forward(req, resp);
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = JdbcUtils.getConnection();
            String sql = "SELECT id, username, name, role FROM admin WHERE username = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 登录成功，保存管理员信息到Session（供过滤器验证）
                HttpSession session = req.getSession();
                session.setAttribute("adminId", rs.getInt("id")); // 核心：过滤器验证的关键
                session.setAttribute("adminUsername", rs.getString("username"));
                session.setAttribute("adminName", rs.getString("name"));
                session.setAttribute("adminRole", rs.getString("role"));

                // 更新最后登录时间（优化：关闭资源前先执行）
                String updateSql = "UPDATE admin SET last_login_time = NOW() WHERE id = ?";
                PreparedStatement updatePstmt = conn.prepareStatement(updateSql);
                updatePstmt.setInt(1, rs.getInt("id"));
                updatePstmt.executeUpdate();
                updatePstmt.close(); // 及时关闭子Statement

                // 重定向到管理员后台（优化：添加上下文路径，避免路径错误）
                // 确认 /admin/dashboard 是实际存在的后台首页路径，若不存在则改为具体jsp（如/admin/dashboard.jsp）
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                // 登录失败：返回登录页并提示
                req.setAttribute("error", "管理员账号或密码错误！");
                req.getRequestDispatcher("/admin/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace(); // 控制台打印异常，方便排查
            req.setAttribute("error", "登录失败，请稍后重试！");
            req.getRequestDispatcher("/admin/login.jsp").forward(req, resp);
        } finally {
            // 确保资源全部关闭
            JdbcUtils.close(conn, pstmt, rs);
        }
    }

    // 新增：处理GET请求（防止直接访问/admin/login路径导致异常）
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 直接访问GET请求时，重定向到管理员登录页
        resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
    }
}