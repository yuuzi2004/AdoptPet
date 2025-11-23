package com.pet.adopt.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.pet.adopt.utils.JdbcUtils;

@WebServlet("/user/register")
public class UserRegisterServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        
        // 验证密码是否一致
        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "两次输入的密码不一致！");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = JdbcUtils.getConnection();
            
            // 检查用户名是否已存在
            String checkSql = "SELECT id FROM user WHERE username = ? OR email = ?";
            PreparedStatement checkPstmt = conn.prepareStatement(checkSql);
            checkPstmt.setString(1, username);
            checkPstmt.setString(2, email);
            if (checkPstmt.executeQuery().next()) {
                req.setAttribute("error", "用户名或邮箱已存在！");
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
                checkPstmt.close();
                return;
            }
            checkPstmt.close();
            
            // 插入新用户
            String sql = "INSERT INTO user (username, email, phone, password) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, email);
            pstmt.setString(3, phone);
            pstmt.setString(4, password);
            
            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                req.setAttribute("success", "注册成功！请登录");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "注册失败，请稍后重试！");
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "注册失败：" + e.getMessage());
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        } finally {
            JdbcUtils.close(conn, pstmt);
        }
    }
}

