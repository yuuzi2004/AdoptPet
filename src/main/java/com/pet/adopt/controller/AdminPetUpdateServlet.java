package com.pet.adopt.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; // 新增：用于查询原图片路径
import com.pet.adopt.utils.JdbcUtils;
import com.pet.adopt.utils.FileUploadUtils;

@WebServlet("/admin/pet/update")
@MultipartConfig // 支持文件上传
public class AdminPetUpdateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        // 定义列表页路径（核心：最终都跳这里）
        String listPage = req.getContextPath() + "/admin/pet-list";

        // 0. 检查管理员是否登录
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            resp.sendRedirect(listPage); // 未登录直接跳列表
            return;
        }

        try {
            // 1. 获取表单数据（增加异常捕获，避免id无效导致崩溃）
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            String type = req.getParameter("type");
            int age = Integer.parseInt(req.getParameter("age"));
            String gender = req.getParameter("gender");
            String description = req.getParameter("description");

            // 2. 处理图片上传（如果有新图片）
            Part imagePart = req.getPart("image");
            String imagePath = null;

            if (imagePart != null && imagePart.getSize() > 0) {
                try {
                    String realPath = req.getServletContext().getRealPath("");
                    imagePath = FileUploadUtils.saveFile(imagePart, realPath);
                } catch (Exception e) {
                    e.printStackTrace();
                    // 图片上传失败：跳列表页（可带错误参数）
                    resp.sendRedirect(listPage + "?error=图片上传失败");
                    return;
                }
            } else {
                // 无新图片：查询原图片路径（避免更新后图片丢失）
                Connection conn = JdbcUtils.getConnection();
                PreparedStatement pstmt = conn.prepareStatement("SELECT image_path FROM pet WHERE id=?");
                pstmt.setInt(1, id);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    imagePath = rs.getString("image_path");
                }
                JdbcUtils.close(conn, pstmt, rs);
            }

            // 3. 更新数据库
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                conn = JdbcUtils.getConnection();
                String sql;
                if (imagePath != null) {
                    sql = "UPDATE pet SET name=?, type=?, age=?, gender=?, description=?, image_path=? WHERE id=?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, name);
                    pstmt.setString(2, type);
                    pstmt.setInt(3, age);
                    pstmt.setString(4, gender);
                    pstmt.setString(5, description);
                    pstmt.setString(6, imagePath);
                    pstmt.setInt(7, id);
                } else {
                    sql = "UPDATE pet SET name=?, type=?, age=?, gender=?, description=? WHERE id=?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, name);
                    pstmt.setString(2, type);
                    pstmt.setInt(3, age);
                    pstmt.setString(4, gender);
                    pstmt.setString(5, description);
                    pstmt.setInt(6, id);
                }

                pstmt.executeUpdate();
                // 成功：跳列表页（带成功提示）
                resp.sendRedirect(listPage + "?success=更新成功");

            } catch (Exception e) {
                e.printStackTrace();
                // 数据库失败：跳列表页
                resp.sendRedirect(listPage + "?error=更新失败");
            } finally {
                JdbcUtils.close(conn, pstmt, null);
            }

        } catch (Exception e) {
            // 捕获所有异常（比如id格式错误），确保跳列表页
            e.printStackTrace();
            resp.sendRedirect(listPage + "?error=参数错误");
        }
    }
}