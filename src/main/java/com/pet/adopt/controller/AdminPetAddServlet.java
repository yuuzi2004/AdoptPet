package com.pet.adopt.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.pet.adopt.utils.JdbcUtils;
import com.pet.adopt.utils.FileUploadUtils;

@WebServlet("/admin/pet/add")
@MultipartConfig
public class AdminPetAddServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 无论发生什么，最终都要跳回列表页（强制设置）
        String listPage = req.getContextPath() + "/admin/pet/list";

        try {
            req.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html;charset=UTF-8");

            // 1. 登录校验（未登录也跳列表页，由列表页自动判断登录状态）
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("adminId") == null) {
                resp.sendRedirect(listPage);
                return;
            }

            // 2. 获取并校验表单数据
            String name = req.getParameter("name") == null ? "" : req.getParameter("name").trim();
            String type = req.getParameter("type") == null ? "" : req.getParameter("type").trim();
            String ageStr = req.getParameter("age") == null ? "" : req.getParameter("age").trim();
            String gender = req.getParameter("gender") == null ? "" : req.getParameter("gender").trim();
            String description = req.getParameter("description") == null ? "" : req.getParameter("description").trim();

            // 3. 执行添加逻辑（即使中间出错，最终也会跳列表页）
            if (!name.isEmpty() && !type.isEmpty() && !ageStr.isEmpty() && !gender.isEmpty() && !description.isEmpty()) {
                try {
                    int age = Integer.parseInt(ageStr);
                    Part imagePart = req.getPart("image");
                    if (imagePart != null && imagePart.getSize() > 0) {
                        // 保存图片
                        String realPath = req.getServletContext().getRealPath("/uploads");
                        new java.io.File(realPath).mkdirs(); // 确保目录存在
                        String imagePath = FileUploadUtils.saveFile(imagePart, realPath);

                        // 保存到数据库
                        Connection conn = JdbcUtils.getConnection();
                        String sql = "INSERT INTO pet (name, type, age, gender, description, image_path) VALUES (?, ?, ?, ?, ?, ?)";
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, name);
                        pstmt.setString(2, type);
                        pstmt.setInt(3, age);
                        pstmt.setString(4, gender);
                        pstmt.setString(5, description);
                        pstmt.setString(6, imagePath);
                        pstmt.executeUpdate();
                        JdbcUtils.close(conn, pstmt, null);
                    }
                } catch (Exception e) {
                    e.printStackTrace(); // 打印错误，但不影响跳转
                }
            }

        } catch (Exception e) {
            e.printStackTrace(); // 任何异常都只打印，不中断跳转
        }

        // 最终强制跳回管理员宠物列表页（无论成功失败）
        resp.sendRedirect(listPage);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // GET请求直接跳列表页
        resp.sendRedirect(req.getContextPath() + "/admin/pet/list");
    }
}