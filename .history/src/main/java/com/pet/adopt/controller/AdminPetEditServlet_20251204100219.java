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
import com.pet.adopt.entity.Pet;
import com.pet.adopt.utils.JdbcUtils;

@WebServlet("/admin/pet/edit")
public class AdminPetEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 获取要编辑的宠物ID
        String petIdStr = req.getParameter("id");
        if (petIdStr == null || petIdStr.isEmpty()) {
            req.setAttribute("error", "无效的宠物ID");
            req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
            return;
        }

        int petId = Integer.parseInt(petIdStr);
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Pet pet = null;

        try {
            // 2. 从数据库查询宠物信息
            conn = JdbcUtils.getConnection();
            String sql = "SELECT id, name, type, age, gender, description, image_path FROM pet WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, petId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                pet = new Pet();
                pet.setId(rs.getInt("id"));
                pet.setName(rs.getString("name"));
                pet.setType(rs.getString("type"));
                pet.setAge(rs.getInt("age"));
                pet.setGender(rs.getString("gender"));
                pet.setDescription(rs.getString("description"));
                pet.setImagePath(rs.getString("image_path"));
            }

            // 3. 检查管理员是否登录
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("adminId") == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
                return;
            }

            // 4. 将宠物信息传递到JSP页面（修改路径，添加admin目录前缀）
            req.setAttribute("pet", pet);
            req.getRequestDispatcher("/admin/edit-pet.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "加载宠物信息失败");
            req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }
    }
}