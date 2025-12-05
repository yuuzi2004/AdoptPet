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

        // 0. 检查管理员是否登录
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
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
                    forwardWithMessage(req, resp, id, "图片上传失败", false);
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
                // 成功：回到编辑页并弹窗提示
                forwardWithMessage(req, resp, id, "更新成功", true);

            } catch (Exception e) {
                e.printStackTrace();
                // 数据库失败：回编辑页提示
                forwardWithMessage(req, resp, id, "更新失败", false);
            } finally {
                JdbcUtils.close(conn, pstmt, null);
            }

        } catch (Exception e) {
            // 捕获所有异常（比如id格式错误），回编辑页提示
            e.printStackTrace();
            forwardWithMessage(req, resp, null, "参数错误", false);
        }
    }

    /**
     * 统一带消息转发回编辑页，避免空白页或跳转。
     */
    private void forwardWithMessage(HttpServletRequest req, HttpServletResponse resp, Integer petId,
                                    String message, boolean success) throws ServletException, IOException {
        // 查询最新宠物数据，保证页面回显最新内容
        if (petId != null) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = JdbcUtils.getConnection();
                pstmt = conn.prepareStatement("SELECT id, name, type, age, gender, description, image_path FROM pet WHERE id = ?");
                pstmt.setInt(1, petId);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    com.pet.adopt.entity.Pet pet = new com.pet.adopt.entity.Pet();
                    pet.setId(rs.getInt("id"));
                    pet.setName(rs.getString("name"));
                    pet.setType(rs.getString("type"));
                    pet.setAge(rs.getInt("age"));
                    pet.setGender(rs.getString("gender"));
                    pet.setDescription(rs.getString("description"));
                    pet.setImagePath(rs.getString("image_path"));
                    req.setAttribute("pet", pet);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                JdbcUtils.close(conn, pstmt, rs);
            }
        }

        if (success) {
            req.setAttribute("successMessage", message);
        } else {
            req.setAttribute("errorMessage", message);
        }
        req.getRequestDispatcher("/admin/edit-pet.jsp").forward(req, resp);
    }
}