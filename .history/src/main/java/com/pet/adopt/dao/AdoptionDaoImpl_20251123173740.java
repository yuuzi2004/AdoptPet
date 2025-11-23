package com.pet.adopt.dao;

import com.pet.adopt.entity.AdoptionApplication;
import com.pet.adopt.entity.Pet;
import com.pet.adopt.entity.User;
import com.pet.adopt.utils.JdbcUtils;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AdoptionDaoImpl implements AdoptionDao {
    
    @Override
    public boolean addApplication(AdoptionApplication application) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = JdbcUtils.getConnection();
            String sql = "INSERT INTO adoption_application (pet_id, user_id, reason, contact, status, create_time) VALUES (?, ?, ?, ?, ?, NOW())";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, application.getPetId());
            pstmt.setInt(2, application.getUserId());
            pstmt.setString(3, application.getReason());
            pstmt.setString(4, application.getContact());
            pstmt.setString(5, application.getStatus());
            
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            JdbcUtils.close(conn, pstmt, null);
        }
    }
    
    @Override
    public List<AdoptionApplication> findApplicationsByUserId(Integer userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<AdoptionApplication> applications = new ArrayList<>();
        
        try {
            conn = JdbcUtils.getConnection();
            String sql = "SELECT a.*, p.name as pet_name, p.type as pet_type, u.username " +
                        "FROM adoption_application a " +
                        "LEFT JOIN pet p ON a.pet_id = p.id " +
                        "LEFT JOIN user u ON a.user_id = u.id " +
                        "WHERE a.user_id = ? ORDER BY a.create_time DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                applications.add(mapResultSetToApplication(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }
        
        return applications;
    }
    
    @Override
    public List<AdoptionApplication> findApplicationsByPetId(Integer petId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<AdoptionApplication> applications = new ArrayList<>();
        
        try {
            conn = JdbcUtils.getConnection();
            String sql = "SELECT a.*, p.name as pet_name, p.type as pet_type, u.username " +
                        "FROM adoption_application a " +
                        "LEFT JOIN pet p ON a.pet_id = p.id " +
                        "LEFT JOIN user u ON a.user_id = u.id " +
                        "WHERE a.pet_id = ? ORDER BY a.create_time DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, petId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                applications.add(mapResultSetToApplication(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }
        
        return applications;
    }
    
    @Override
    public AdoptionApplication findApplicationById(Integer id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = JdbcUtils.getConnection();
            String sql = "SELECT a.*, p.name as pet_name, p.type as pet_type, u.username " +
                        "FROM adoption_application a " +
                        "LEFT JOIN pet p ON a.pet_id = p.id " +
                        "LEFT JOIN user u ON a.user_id = u.id " +
                        "WHERE a.id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToApplication(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }
        
        return null;
    }
    
    @Override
    public boolean hasUserApplied(Integer userId, Integer petId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = JdbcUtils.getConnection();
            String sql = "SELECT COUNT(*) FROM adoption_application WHERE user_id = ? AND pet_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, petId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }
        
        return false;
    }
    
    private AdoptionApplication mapResultSetToApplication(ResultSet rs) throws SQLException {
        AdoptionApplication application = new AdoptionApplication();
        application.setId(rs.getInt("id"));
        application.setPetId(rs.getInt("pet_id"));
        application.setUserId(rs.getInt("user_id"));
        application.setReason(rs.getString("reason"));
        application.setContact(rs.getString("contact"));
        application.setStatus(rs.getString("status"));
        
        Timestamp createTime = rs.getTimestamp("create_time");
        if (createTime != null) {
            application.setCreateTime(createTime.toLocalDateTime());
        }
        
        Timestamp processTime = rs.getTimestamp("process_time");
        if (processTime != null) {
            application.setProcessTime(processTime.toLocalDateTime());
        }
        
        // 设置关联对象
        if (rs.getString("pet_name") != null) {
            Pet pet = new Pet();
            pet.setId(rs.getInt("pet_id"));
            pet.setName(rs.getString("pet_name"));
            pet.setType(rs.getString("pet_type"));
            application.setPet(pet);
        }
        
        if (rs.getString("username") != null) {
            User user = new User();
            user.setId(rs.getInt("user_id"));
            user.setUsername(rs.getString("username"));
            application.setUser(user);
        }
        
        return application;
    }
}

