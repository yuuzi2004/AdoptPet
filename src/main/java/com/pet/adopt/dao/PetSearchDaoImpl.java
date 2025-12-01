package com.pet.adopt.dao;

import com.pet.adopt.entity.PetSearch;
import com.pet.adopt.utils.JdbcUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class PetSearchDaoImpl implements PetSearchDao {

    // 1. 根据用户ID查询发布的寻宠信息
    @Override
    public List<PetSearch> findByUserId(Integer userId) {
        List<PetSearch> list = new ArrayList<>();
        // 字段完全匹配你的PetSearch实体类和数据库表（重点：name/type/location/lostTime等）
        String sql = "SELECT id, name, type, location, lost_time, description, image_path, contact, user_id, status, create_time FROM pet_search WHERE user_id = ?";

        try (Connection conn = JdbcUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                PetSearch petSearch = new PetSearch();
                petSearch.setId(rs.getInt("id"));
                petSearch.setName(rs.getString("name")); // 对应实体类name字段
                petSearch.setType(rs.getString("type")); // 对应实体类type字段
                petSearch.setLocation(rs.getString("location")); // 对应实体类location字段
                // 转换SQL的datetime为LocalDateTime（适配你的实体类类型）
                petSearch.setLostTime(rs.getTimestamp("lost_time").toLocalDateTime());
                petSearch.setDescription(rs.getString("description"));
                petSearch.setImagePath(rs.getString("image_path"));
                petSearch.setContact(rs.getString("contact"));
                petSearch.setUserId(rs.getInt("user_id"));
                petSearch.setStatus(rs.getString("status"));
                petSearch.setCreateTime(rs.getTimestamp("create_time").toLocalDateTime());
                list.add(petSearch);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. 根据ID和用户ID查询寻宠信息（权限验证）
    @Override
    public PetSearch findByIdAndUserId(Integer id, Integer userId) {
        PetSearch petSearch = null;
        String sql = "SELECT id, name, type, location, lost_time, description, image_path, contact, user_id, status, create_time FROM pet_search WHERE id = ? AND user_id = ?";

        try (Connection conn = JdbcUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.setInt(2, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                petSearch = new PetSearch();
                petSearch.setId(rs.getInt("id"));
                petSearch.setName(rs.getString("name"));
                petSearch.setType(rs.getString("type"));
                petSearch.setLocation(rs.getString("location"));
                petSearch.setLostTime(rs.getTimestamp("lost_time").toLocalDateTime());
                petSearch.setDescription(rs.getString("description"));
                petSearch.setImagePath(rs.getString("image_path"));
                petSearch.setContact(rs.getString("contact"));
                petSearch.setUserId(rs.getInt("user_id"));
                petSearch.setStatus(rs.getString("status"));
                petSearch.setCreateTime(rs.getTimestamp("create_time").toLocalDateTime());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return petSearch;
    }

    // 3. 更新寻宠信息
    @Override
    public int update(PetSearch petSearch) {
        String sql = "UPDATE pet_search SET name = ?, type = ?, location = ?, lost_time = ?, description = ?, image_path = ?, contact = ?, status = ? WHERE id = ? AND user_id = ?";
        int rows = 0;

        try (Connection conn = JdbcUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, petSearch.getName());
            pstmt.setString(2, petSearch.getType());
            pstmt.setString(3, petSearch.getLocation());
            // 转换LocalDateTime为Timestamp（适配数据库datetime类型）
            pstmt.setTimestamp(4, java.sql.Timestamp.valueOf(petSearch.getLostTime()));
            pstmt.setString(5, petSearch.getDescription());
            pstmt.setString(6, petSearch.getImagePath());
            pstmt.setString(7, petSearch.getContact());
            pstmt.setString(8, petSearch.getStatus());
            pstmt.setInt(9, petSearch.getId());
            pstmt.setInt(10, petSearch.getUserId());
            rows = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rows;
    }

    // 4. 删除寻宠信息
    @Override
    public int deleteByIdAndUserId(Integer id, Integer userId) {
        String sql = "DELETE FROM pet_search WHERE id = ? AND user_id = ?";
        int rows = 0;

        try (Connection conn = JdbcUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.setInt(2, userId);
            rows = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rows;
    }
}