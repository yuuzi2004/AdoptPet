package com.pet.adopt.controller;

import com.pet.adopt.entity.User;
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
import java.util.ArrayList;
import java.util.List;
import com.pet.adopt.utils.JdbcUtils;

@WebServlet("/admin/user/list")
public class AdminUserListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 检查管理员是否登录
        HttpSession session = req.getSession();
        if (session.getAttribute("adminId") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
            return;
        }

        // 查询所有用户
        List<User> userList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = JdbcUtils.getConnection();
            String sql = "SELECT id, username, email, phone, create_time FROM user ORDER BY create_time DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                if (rs.getTimestamp("create_time") != null) {
                    user.setCreateTime(rs.getTimestamp("create_time").toLocalDateTime());
                }
                userList.add(user);
            }

            req.setAttribute("userList", userList);
            req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }
    }
}

