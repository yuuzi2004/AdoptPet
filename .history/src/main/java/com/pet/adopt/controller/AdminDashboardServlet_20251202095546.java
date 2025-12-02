package com.pet.adopt.controller;

import com.pet.adopt.entity.Pet;
import com.pet.adopt.entity.AdoptionApplication;
import com.pet.adopt.service.PetService;
import com.pet.adopt.service.PetServiceImpl;
import com.pet.adopt.service.AdoptionService;
import com.pet.adopt.service.AdoptionServiceImpl;
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
import java.util.List;
import java.util.stream.Collectors;
import com.pet.adopt.utils.JdbcUtils;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private PetService petService = new PetServiceImpl();
    private AdoptionService adoptionService = new AdoptionServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 检查管理员是否登录
        HttpSession session = req.getSession();
        if (session.getAttribute("adminId") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
            return;
        }
        
        Connection conn = null;
        try {
            conn = JdbcUtils.getConnection();
            
            // 获取统计数据
            int totalPets = getCount(conn, "SELECT COUNT(*) FROM pet");
            int totalUsers = getCount(conn, "SELECT COUNT(*) FROM user");
            int pendingApplications = getCount(conn, "SELECT COUNT(*) FROM adoption_application WHERE status = 'pending'");
            int adoptedPets = getCount(conn, "SELECT COUNT(*) FROM adoption_application WHERE status = 'approved'");
            
            // 获取最近添加的宠物（最多5条）
            List<Pet> recentPets = petService.findAllPets();
            if (recentPets != null && recentPets.size() > 5) {
                recentPets = recentPets.subList(0, 5);
            }
            
            // 获取待处理申请列表（用于快捷审核显示）
            List<AdoptionApplication> allApplications = adoptionService.getAllApplications();
            List<AdoptionApplication> pendingApplicationsList = allApplications.stream()
                    .filter(app -> "pending".equals(app.getStatus()))
                    .collect(Collectors.toList());
            
            // 设置属性
            req.setAttribute("totalPets", totalPets);
            req.setAttribute("totalUsers", totalUsers);
            req.setAttribute("pendingApplications", pendingApplications);
            req.setAttribute("adoptedPets", adoptedPets);
            req.setAttribute("recentPets", recentPets);
            req.setAttribute("pendingApplicationsList", pendingApplicationsList);
            
            // 转发到管理员后台页面
            req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    private int getCount(Connection conn, String sql) {
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}

