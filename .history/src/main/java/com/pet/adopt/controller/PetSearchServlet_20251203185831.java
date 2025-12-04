package com.pet.adopt.controller;

import com.pet.adopt.entity.PetSearch;
import com.pet.adopt.utils.FileUploadUtils;
import com.pet.adopt.utils.JdbcUtils;

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
import java.sql.Timestamp;
import java.util.Enumeration; // 用于遍历Session属性

@WebServlet("/pet/search")
@MultipartConfig(maxFileSize = 5242880, maxRequestSize = 10485760) // 5MB文件限制
public class PetSearchServlet extends HttpServlet {

    // ========== 处理GET请求（查询寻宠列表/个人寻宠列表） ==========
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String action = req.getParameter("action");

        // 分支1：个人中心我的寻宠列表（/user/my-pets.jsp）
        if ("myList".equals(action)) {
            HttpSession session = req.getSession(false);
            Integer userId = null;

            // 调试日志：打印Session信息
            System.out.println("===== [myList分支] 调试：Session信息 =====");
            System.out.println("Session是否存在：" + (session != null ? "是" : "否"));

            if (session != null) {
                // 遍历Session所有属性，确认userId是否存在
                Enumeration<String> attrNames = session.getAttributeNames();
                while (attrNames.hasMoreElements()) {
                    String attrName = attrNames.nextElement();
                    Object value = session.getAttribute(attrName);
                    System.out.println("Session属性：" + attrName + " = " + value);
                }
                // 获取用户ID（关键：与登录时存储的key保持一致）
                userId = (Integer) session.getAttribute("userId");
                System.out.println("从Session获取的userId：" + userId);
            }

            // 未登录跳登录页
            if (userId == null) {
                resp.sendRedirect(req.getContextPath() + "/login.jsp?error=请先登录查看个人发布");
                return;
            }

            // 查询当前用户的寻宠信息（仅查询1次）
            List<PetSearch> myPetSearchList = findPetSearchesByUserId(userId);
            System.out.println("===== [myList分支] 个人寻宠数量：" + myPetSearchList.size() + " =====");

            req.setAttribute("myPetSearchList", myPetSearchList);
            req.getRequestDispatcher("/user/my-pets.jsp").forward(req, resp);
            return;
        }

        // 分支2：默认请求（寻宠首页/search.jsp）
        // 1. 查询全局寻宠列表
        List<PetSearch> searchList = findAllPetSearches();
        req.setAttribute("searchList", searchList);

        // 2. 查询当前登录用户的个人寻宠列表
        HttpSession session = req.getSession(false);
        Integer userId = null;

        System.out.println("===== [默认分支] 调试：Session信息 =====");
        System.out.println("Session是否存在：" + (session != null ? "是" : "否"));

        if (session != null) {
            // 遍历Session属性，确认userId
            Enumeration<String> attrNames = session.getAttributeNames();
            while (attrNames.hasMoreElements()) {
                String attrName = attrNames.nextElement();
                Object value = session.getAttribute(attrName);
                System.out.println("Session属性：" + attrName + " = " + value);
            }
            userId = (Integer) session.getAttribute("userId");
            System.out.println("从Session获取的userId：" + userId);
        }

        // 已登录用户查询个人列表
        if (userId != null) {
            List<PetSearch> myPetSearchList = findPetSearchesByUserId(userId);
            System.out.println("===== [默认分支] 个人寻宠数量：" + myPetSearchList.size() + " =====");
            req.setAttribute("myPetSearchList", myPetSearchList);
        } else {
            System.out.println("===== [默认分支] 用户未登录，不查询个人列表 =====");
        }

        // 转发到寻宠首页
        req.getRequestDispatcher("/search.jsp").forward(req, resp);
    }

    // ========== 处理POST请求（发布寻宠信息） ==========
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // 获取表单参数
        String name = req.getParameter("name");
        String type = req.getParameter("type");
        String location = req.getParameter("location");
        String lostTimeStr = req.getParameter("lostTime");
        String description = req.getParameter("description");
        String contact = req.getParameter("contact");

        // 接收并验证 age 参数
        Integer age = null;
        String ageStr = req.getParameter("age");
        if (ageStr == null || ageStr.trim().isEmpty()) {
            req.setAttribute("error", "请填写宠物年龄");
            doGet(req, resp);
            return;
        }
        try {
            age = Integer.parseInt(ageStr.trim());
            if (age < 0) {
                req.setAttribute("error", "年龄不能为负数");
                doGet(req, resp);
                return;
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "年龄必须为整数");
            doGet(req, resp);
            return;
        }

        // 接收并验证性别参数（核心修复1：添加性别参数处理）
        String gender = req.getParameter("gender");
        if (gender == null || gender.trim().isEmpty()) {
            req.setAttribute("error", "请选择宠物性别");
            doGet(req, resp);
            return;
        }

        // 处理图片上传
        String imagePath = null;
        try {
            Part filePart = req.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String realPath = req.getServletContext().getRealPath("/uploads/");
                imagePath = FileUploadUtils.saveFile(filePart, realPath);
                imagePath = "uploads/" + imagePath;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "图片上传失败：" + e.getMessage());
            doGet(req, resp);
            return;
        }

        // 获取登录用户ID
        HttpSession session = req.getSession(false);
        Integer userId = null;
        if (session != null) {
            userId = (Integer) session.getAttribute("userId");
        }
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=请先登录再发布");
            return;
        }

        // 转换丢失时间
        LocalDateTime lostTime = null;
        if (lostTimeStr != null && !lostTimeStr.isEmpty()) {
            try {
                lostTime = LocalDateTime.parse(lostTimeStr.replace("T", " "),
                        DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "时间格式错误，请重新输入");
                doGet(req, resp);
                return;
            }
        }

        // 保存到数据库（传递gender参数）
        boolean success = addPetSearch(name, type, location, lostTime, description, contact,
                imagePath, userId, age, gender);

        // ========== 根据是否为 Ajax 请求，选择返回方式 ==========
        String requestedWith = req.getHeader("X-Requested-With");
        boolean isAjax = requestedWith != null && "XMLHttpRequest".equalsIgnoreCase(requestedWith);

        if (isAjax) {
            // Ajax 提交：返回 JSON，前端在当前页弹窗，不整页跳转
            resp.setContentType("application/json;charset=UTF-8");
            String json;
            if (success) {
                json = "{\"success\":true,\"message\":\"寻宠信息发布成功！\"}";
            } else {
                json = "{\"success\":false,\"message\":\"发布失败，请稍后重试！\"}";
            }
            resp.getWriter().write(json);
        } else {
            // 普通表单提交：保持原来的重定向逻辑
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/pet/search?successMsg=寻宠信息发布成功！");
            } else {
                resp.sendRedirect(req.getContextPath() + "/pet/search?error=发布失败，请稍后重试！");
            }
        }
    }

    // ========== 私有方法：新增寻宠信息到数据库 ==========
    // 修复方法参数，增加gender参数（核心修复2：完善方法定义）
    private boolean addPetSearch(String name, String type, String location, LocalDateTime lostTime,
                                 String description, String contact, String imagePath, Integer userId,
                                 Integer age, String gender) {  // 新增gender参数
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = JdbcUtils.getConnection();
            // SQL 中增加 gender 字段（核心修复3：完善SQL语句）
            String sql = "INSERT INTO pet_search (name, type, location, lost_time, description, " +
                    "contact, user_id, status, create_time, image_path, age, gender) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, 'searching', NOW(), ?, ?, ?)";

            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, name);
            pstmt.setString(2, type);
            pstmt.setString(3, location);
            pstmt.setTimestamp(4, Timestamp.valueOf(lostTime));
            pstmt.setString(5, description);
            pstmt.setString(6, contact);
            pstmt.setInt(7, userId);
            pstmt.setString(8, imagePath);
            pstmt.setInt(9, age);
            pstmt.setString(10, gender);  // 核心修复4：设置性别参数

            int result = pstmt.executeUpdate();
            System.out.println("发布寻宠结果：" + (result > 0 ? "成功" : "失败") +
                    "，名称：" + name + "，性别：" + gender + "，用户ID：" + userId);
            return result > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("发布失败：" + e.getMessage() + "，用户ID：" + userId);
            return false;
        } finally {
            JdbcUtils.close(conn, pstmt, null);
        }
    }

    // ========== 私有方法：查询所有寻宠信息（全局列表） ==========
    private List<PetSearch> findAllPetSearches() {
        List<PetSearch> searchList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = JdbcUtils.getConnection();
            // 补充查询 gender 字段（核心修复5：查询时包含性别）
            String sql = "SELECT id, name, type, location, lost_time, description, contact, " +
                    "user_id, image_path, status, create_time, age, gender " +
                    "FROM pet_search WHERE status = 'searching' ORDER BY create_time DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                PetSearch search = new PetSearch();
                search.setId(rs.getInt("id"));
                search.setName(rs.getString("name"));
                search.setType(rs.getString("type"));
                search.setLocation(rs.getString("location"));
                search.setGender(rs.getString("gender"));  // 核心修复6：设置性别属性

                Timestamp lostTime = rs.getTimestamp("lost_time");
                if (lostTime != null) {
                    search.setLostTime(lostTime.toLocalDateTime());
                }

                search.setDescription(rs.getString("description"));
                search.setContact(rs.getString("contact"));
                search.setUserId(rs.getInt("user_id"));
                search.setImagePath(rs.getString("image_path"));
                search.setStatus(rs.getString("status"));
                search.setCreateTime(rs.getTimestamp("create_time").toLocalDateTime());
                search.setAge(rs.getInt("age"));

                searchList.add(search);
            }
            System.out.println("全局寻宠列表数量：" + searchList.size());

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("查询全局列表失败：" + e.getMessage());
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }

        return searchList;
    }

    // ========== 私有方法：根据用户ID查询个人寻宠信息 ==========
    private List<PetSearch> findPetSearchesByUserId(Integer userId) {
        List<PetSearch> myList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = JdbcUtils.getConnection();
            // 补充查询 gender 和 age 字段（核心修复7：个人查询包含性别）
            String sql = "SELECT id, name, type, location, lost_time, description, contact, " +
                    "image_path, status, age, gender " +
                    "FROM pet_search WHERE user_id = ? AND status = 'searching' ORDER BY create_time DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                PetSearch search = new PetSearch();
                search.setId(rs.getInt("id"));
                search.setName(rs.getString("name"));
                search.setType(rs.getString("type"));
                search.setLocation(rs.getString("location"));
                search.setGender(rs.getString("gender"));  // 核心修复8：设置性别属性
                search.setAge(rs.getInt("age"));

                Timestamp lostTime = rs.getTimestamp("lost_time");
                if (lostTime != null) {
                    search.setLostTime(lostTime.toLocalDateTime());
                }

                search.setDescription(rs.getString("description"));
                search.setContact(rs.getString("contact"));
                search.setUserId(userId);
                search.setImagePath(rs.getString("image_path"));
                search.setStatus(rs.getString("status"));

                myList.add(search);
            }
            System.out.println("个人寻宠列表数量：" + myList.size() + "，用户ID：" + userId);

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("查询个人列表失败：" + e.getMessage());
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }

        return myList;
    }
}