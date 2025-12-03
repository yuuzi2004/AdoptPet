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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import com.pet.adopt.utils.JdbcUtils;

@WebServlet("/admin/user/list")
public class AdminUserListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 强制统一编码，解决中文乱码
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // 2. 严格校验管理员登录状态
        HttpSession session = req.getSession(false); // 不创建新session
        if (session == null || session.getAttribute("adminId") == null) {
            req.setAttribute("error", "请先登录管理员账号！");
            resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
            return;
        }

        // 3. 初始化用户列表（空列表兜底，避免空指针）
        List<User> userList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = JdbcUtils.getConnection();
            // 查询所有用户，按创建时间倒序（最新注册的用户在最前）
            String sql = "SELECT id, username, email, phone, create_time FROM user ORDER BY create_time DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            // 4. 遍历结果集，封装用户对象（逐个校验字段，避免null值）
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));

                // 字段非空兜底：避免数据库字段为null导致前端展示异常
                user.setUsername(rs.getString("username") == null ? "未设置" : rs.getString("username"));
                user.setEmail(rs.getString("email") == null ? "未绑定" : rs.getString("email"));
                user.setPhone(rs.getString("phone") == null ? "未填写" : rs.getString("phone"));

                // 处理创建时间：Timestamp转LocalDateTime（避免类型转换异常）
                Timestamp createTime = rs.getTimestamp("create_time");
                if (createTime != null) {
                    user.setCreateTime(createTime.toLocalDateTime());
                }

                userList.add(user);
            }

            // 5. 绑定数据到请求（即使无数据，也是空列表，不会为null）
            req.setAttribute("userList", userList);
            req.setAttribute("totalUsers", userList.size()); // 传递用户总数，方便页面展示

            // 6. 转发到独立的用户列表页面（不再复用dashboard.jsp）
            req.getRequestDispatcher("/admin/user-list.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            // 异常时返回友好提示，保留用户列表页面
            req.setAttribute("error", "加载用户列表失败：" + e.getMessage());
            req.setAttribute("userList", userList); // 空列表兜底
            req.setAttribute("totalUsers", 0);
            req.getRequestDispatcher("/admin/user-list.jsp").forward(req, resp);
        } finally {
            // 7. 统一关闭资源，避免泄漏
            JdbcUtils.close(conn, pstmt, rs);
        }
    }
}