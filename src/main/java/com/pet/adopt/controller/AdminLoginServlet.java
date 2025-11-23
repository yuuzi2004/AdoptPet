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
        req.setCharacterEncoding("UTF-8");
        
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
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
                // 登录成功，保存管理员信息到Session
                HttpSession session = req.getSession();
                session.setAttribute("adminId", rs.getInt("id"));
                session.setAttribute("adminUsername", rs.getString("username"));
                session.setAttribute("adminName", rs.getString("name"));
                session.setAttribute("adminRole", rs.getString("role"));
                
                // 更新最后登录时间
                String updateSql = "UPDATE admin SET last_login_time = NOW() WHERE id = ?";
                PreparedStatement updatePstmt = conn.prepareStatement(updateSql);
                updatePstmt.setInt(1, rs.getInt("id"));
                updatePstmt.executeUpdate();
                updatePstmt.close();
                
                // 重定向到管理员后台
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                // 登录失败
                req.setAttribute("error", "管理员账号或密码错误！");
                req.getRequestDispatcher("/admin/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "登录失败，请稍后重试！");
            req.getRequestDispatcher("/admin/login.jsp").forward(req, resp);
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }
    }
}

