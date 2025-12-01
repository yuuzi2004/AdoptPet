package com.pet.adopt.service;

import com.pet.adopt.dao.AdoptionDao;
import com.pet.adopt.dao.AdoptionDaoImpl;
import com.pet.adopt.entity.AdoptionApplication;
import com.pet.adopt.entity.Pet;
import com.pet.adopt.entity.User;
import com.pet.adopt.utils.JdbcUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdoptionServiceImpl implements AdoptionService {
    private AdoptionDao adoptionDao = new AdoptionDaoImpl();

    @Override
    public boolean submitApplication(AdoptionApplication application) {
        // 原有逻辑保留，不修改
        if (adoptionDao.hasUserApplied(application.getUserId(), application.getPetId())) {
            return false; // 已经申请过，不允许重复申请
        }
        return adoptionDao.addApplication(application);
    }

    @Override
    public List<AdoptionApplication> getApplicationsByUserId(Integer userId) {
        // 原有逻辑保留
        return adoptionDao.findApplicationsByUserId(userId);
    }

    @Override
    public List<AdoptionApplication> getApplicationsByPetId(Integer petId) {
        // 原有逻辑保留
        return adoptionDao.findApplicationsByPetId(petId);
    }

    @Override
    public AdoptionApplication getApplicationById(Integer id) {
        // 原有逻辑保留
        return adoptionDao.findApplicationById(id);
    }

    @Override
    public boolean hasUserApplied(Integer userId, Integer petId) {
        // 原有逻辑保留
        return adoptionDao.hasUserApplied(userId, petId);
    }

    // ========== 新增：管理员查询所有领养申请（核心方法） ==========
    @Override
    public List<AdoptionApplication> getAllApplications() {
        List<AdoptionApplication> applications = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 获取数据库连接（复用项目工具类）
            conn = JdbcUtils.getConnection();
            // 关联查询申请、宠物、用户表，获取完整信息
            String sql = "SELECT a.*, p.id as pet_id, p.name as pet_name, u.id as user_id, u.username as user_name " +
                    "FROM adoption_application a " +
                    "LEFT JOIN pet p ON a.pet_id = p.id " +
                    "LEFT JOIN user u ON a.user_id = u.id " +
                    "ORDER BY a.create_time DESC"; // 按申请时间倒序

            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            // 遍历结果集，封装申请对象（含关联的宠物/用户信息）
            while (rs.next()) {
                AdoptionApplication app = new AdoptionApplication();
                // 封装申请基础信息
                app.setId(rs.getInt("a.id"));
                app.setPetId(rs.getInt("a.pet_id"));
                app.setUserId(rs.getInt("a.user_id"));
                app.setReason(rs.getString("a.reason"));
                app.setContact(rs.getString("a.contact"));
                app.setStatus(rs.getString("a.status")); // 字符串状态（pending/approved/rejected）
                app.setCreateTime(rs.getTimestamp("a.create_time") != null ?
                        rs.getTimestamp("a.create_time").toLocalDateTime() : null);
                app.setProcessTime(rs.getTimestamp("a.process_time") != null ?
                        rs.getTimestamp("a.process_time").toLocalDateTime() : null);

                // 封装关联的宠物信息（避免空指针）
                Pet pet = new Pet();
                pet.setId(rs.getInt("pet_id"));
                pet.setName(rs.getString("pet_name") != null ? rs.getString("pet_name") : "未知宠物");
                app.setPet(pet);

                // 封装关联的用户信息（避免空指针）
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setUsername(rs.getString("user_name") != null ? rs.getString("user_name") : "未知用户");
                app.setUser(user);

                applications.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // 打印异常，便于调试
        } finally {
            // 关闭数据库连接（复用项目工具类）
            JdbcUtils.close(conn, pstmt, rs);
        }
        return applications;
    }

    // ========== 新增：管理员处理领养申请（同意/拒绝） ==========
    @Override
    public boolean processApplication(Integer id, String status) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = JdbcUtils.getConnection();
            // 更新申请状态和处理时间
            String sql = "UPDATE adoption_application " +
                    "SET status = ?, process_time = NOW() " +
                    "WHERE id = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status); // 字符串状态（approved/rejected）
            pstmt.setInt(2, id);

            // 执行更新，影响行数>0则表示处理成功
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            JdbcUtils.close(conn, pstmt, null);
        }
    }

    // ========== 新增：实现根据申请ID和用户ID删除申请 ==========
    // 新增：根据申请ID和用户ID删除申请（确保用户只能删除自己的申请）
    @Override
    public int deleteByIdAndUserId(Integer applicationId, Integer userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = JdbcUtils.getConnection();
            // 仅允许删除当前用户的申请（通过 WHERE 条件限制 user_id = ?）
            String sql = "DELETE FROM adoption_application " +
                    "WHERE id = ? AND user_id = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, applicationId); // 申请ID
            pstmt.setInt(2, userId);        // 用户ID（权限控制）

            // 执行删除，返回受影响的行数（1表示成功，0表示未找到或无权限）
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0; // 异常时返回0表示失败
        } finally {
            JdbcUtils.close(conn, pstmt, null);
        }
    }
}