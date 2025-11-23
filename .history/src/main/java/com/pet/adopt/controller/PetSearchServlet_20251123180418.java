package com.pet.adopt.controller;

import com.pet.adopt.entity.PetSearch;
import com.pet.adopt.utils.FileUploadUtils;

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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import com.pet.adopt.utils.JdbcUtils;

@WebServlet("/pet/search")
@MultipartConfig(maxFileSize = 5242880, maxRequestSize = 10485760)
public class PetSearchServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        // 查询所有寻宠信息
        List<PetSearch> searchList = findAllPetSearches();
        req.setAttribute("searchList", searchList);
        req.getRequestDispatcher("/search.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        
        // 获取表单数据
        String name = req.getParameter("name");
        String type = req.getParameter("type");
        String location = req.getParameter("location");
        String lostTimeStr = req.getParameter("lostTime");
        String description = req.getParameter("description");
        String contact = req.getParameter("contact");
        
        // 处理文件上传
        String imagePath = null;
        try {
            Part filePart = req.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String realPath = req.getServletContext().getRealPath("");
                imagePath = FileUploadUtils.saveFile(filePart, realPath);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // 获取用户ID（如果已登录）
        HttpSession session = req.getSession(false);
        Integer userId = null;
        if (session != null) {
            userId = (Integer) session.getAttribute("userId");
        }
        
        // 转换时间
        LocalDateTime lostTime = null;
        if (lostTimeStr != null && !lostTimeStr.isEmpty()) {
            try {
                lostTime = LocalDateTime.parse(lostTimeStr.replace("T", " "), 
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        // 保存到数据库
        boolean success = addPetSearch(name, type, location, lostTime, description, contact, imagePath, userId);
        
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/pet/search?success=发布成功！");
        } else {
            req.setAttribute("error", "发布失败，请稍后重试！");
            doGet(req, resp);
        }
    }
    
    private boolean addPetSearch(String name, String type, String location, LocalDateTime lostTime,
                                 String description, String contact, String imagePath, Integer userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = JdbcUtils.getConnection();
            String sql = "INSERT INTO pet_search (name, type, location, lost_time, description, image_path, contact, user_id, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'searching')";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, type);
            pstmt.setString(3, location);
            if (lostTime != null) {
                pstmt.setTimestamp(4, java.sql.Timestamp.valueOf(lostTime));
            } else {
                pstmt.setTimestamp(4, null);
            }
            pstmt.setString(5, description);
            pstmt.setString(6, imagePath);
            pstmt.setString(7, contact);
            pstmt.setObject(8, userId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            JdbcUtils.close(conn, pstmt, null);
        }
    }
    
    private List<PetSearch> findAllPetSearches() {
        List<PetSearch> searchList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = JdbcUtils.getConnection();
            String sql = "SELECT id, name, type, location, lost_time, description, image_path, contact, user_id, status, create_time FROM pet_search WHERE status = 'searching' ORDER BY create_time DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                PetSearch search = new PetSearch();
                search.setId(rs.getInt("id"));
                search.setName(rs.getString("name"));
                search.setType(rs.getString("type"));
                search.setLocation(rs.getString("location"));
                
                java.sql.Timestamp lostTime = rs.getTimestamp("lost_time");
                if (lostTime != null) {
                    search.setLostTime(lostTime.toLocalDateTime());
                }
                
                search.setDescription(rs.getString("description"));
                search.setImagePath(rs.getString("image_path"));
                search.setContact(rs.getString("contact"));
                search.setUserId(rs.getObject("user_id") != null ? rs.getInt("user_id") : null);
                search.setStatus(rs.getString("status"));
                
                java.sql.Timestamp createTime = rs.getTimestamp("create_time");
                if (createTime != null) {
                    search.setCreateTime(createTime.toLocalDateTime());
                }
                
                searchList.add(search);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }
        
        return searchList;
    }
}

