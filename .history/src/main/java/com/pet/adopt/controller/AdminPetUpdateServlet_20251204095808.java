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
import com.pet.adopt.utils.JdbcUtils;
import com.pet.adopt.utils.FileUploadUtils;

@WebServlet("/admin/pet/update")
@MultipartConfig // 支持文件上传
public class AdminPetUpdateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 0. 检查管理员是否登录
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
            return;
        }

        // 1. 获取表单数据
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
                // 调用文件上传工具类保存图片
                // getRealPath("")返回webapp目录的真实路径
                String realPath = req.getServletContext().getRealPath("");
                imagePath = FileUploadUtils.saveFile(imagePart, realPath);
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "图片上传失败：" + e.getMessage());
                req.getRequestDispatcher("/admin/edit-pet.jsp").forward(req, resp);
                return;
            }
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = JdbcUtils.getConnection();

            // 3. 根据是否有新图片构建不同的SQL语句
            String sql;
            if (imagePath != null) {
                // 有新图片，更新包括图片在内的所有字段
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
                // 没有新图片，不更新图片字段
                sql = "UPDATE pet SET name=?, type=?, age=?, gender=?, description=? WHERE id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setString(2, type);
                pstmt.setInt(3, age);
                pstmt.setString(4, gender);
                pstmt.setString(5, description);
                pstmt.setInt(6, id);
            }

            // 4. 执行更新操作
            pstmt.executeUpdate();

            // 5. 更新成功，重定向回宠物管理列表
            resp.sendRedirect(req.getContextPath() + "/admin/pet/list?success=更新成功");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "更新宠物信息失败");
            req.getRequestDispatcher("/admin/edit-pet.jsp").forward(req, resp);
        } finally {
            JdbcUtils.close(conn, pstmt, null);
        }
    }
}