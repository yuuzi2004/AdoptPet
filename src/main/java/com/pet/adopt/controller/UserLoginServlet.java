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

@WebServlet("/user/login")
public class UserLoginServlet extends HttpServlet {
    
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
            String sql = "SELECT id, username, email, phone FROM user WHERE username = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // 登录成功，保存用户信息到Session
                HttpSession session = req.getSession();
                session.setAttribute("userId", rs.getInt("id"));
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("userEmail", rs.getString("email"));
                
                // 更新最后登录时间
                String updateSql = "UPDATE user SET last_login_time = NOW() WHERE id = ?";
                PreparedStatement updatePstmt = conn.prepareStatement(updateSql);
                updatePstmt.setInt(1, rs.getInt("id"));
                updatePstmt.executeUpdate();
                updatePstmt.close();
                
                // 检查是否有重定向URL
                String redirect = req.getParameter("redirect");
                if (redirect != null && !redirect.isEmpty()) {
                    // 重定向到原始请求的页面
                    resp.sendRedirect(redirect);
                } else {
                    // 重定向到首页
                    resp.sendRedirect(req.getContextPath() + "/");
                }
            } else {
                // 登录失败
                req.setAttribute("error", "用户名或密码错误！");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "登录失败，请稍后重试！");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }
    }
}

