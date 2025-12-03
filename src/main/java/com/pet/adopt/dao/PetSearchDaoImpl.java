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
        // 新增 age 字段查询
        String sql = "SELECT id, name, type, location, lost_time, description, image_path, " +
                "contact, user_id, status, create_time, age, gender " +  // 新增gender
                "FROM pet_search WHERE user_id = ?";

        try (Connection conn = JdbcUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                PetSearch petSearch = new PetSearch();
                petSearch.setId(rs.getInt("id"));
                petSearch.setName(rs.getString("name"));
                petSearch.setType(rs.getString("type"));
                petSearch.setLocation(rs.getString("location"));
                // 处理时间字段（添加空值检查，避免NullPointerException）
                java.sql.Timestamp lostTime = rs.getTimestamp("lost_time");
                if (lostTime != null) {
                    petSearch.setLostTime(lostTime.toLocalDateTime());
                }
                petSearch.setDescription(rs.getString("description"));
                petSearch.setImagePath(rs.getString("image_path"));
                petSearch.setContact(rs.getString("contact"));
                petSearch.setUserId(rs.getInt("user_id"));
                petSearch.setStatus(rs.getString("status"));
                petSearch.setGender(rs.getString("gender"));
                // 处理创建时间（添加空值检查）
                java.sql.Timestamp createTime = rs.getTimestamp("create_time");
                if (createTime != null) {
                    petSearch.setCreateTime(createTime.toLocalDateTime());
                }
                // 新增：设置年龄字段
                petSearch.setAge(rs.getInt("age"));
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
        // 新增 age 字段查询
        String sql = "SELECT id, name, type, location, lost_time, description, image_path, " +
                "contact, user_id, status, create_time, age, gender " +  // 新增gender
                "FROM pet_search WHERE user_id = ?";

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
                // 处理时间字段（添加空值检查）
                java.sql.Timestamp lostTime = rs.getTimestamp("lost_time");
                if (lostTime != null) {
                    petSearch.setLostTime(lostTime.toLocalDateTime());
                }
                petSearch.setDescription(rs.getString("description"));
                petSearch.setImagePath(rs.getString("image_path"));
                petSearch.setContact(rs.getString("contact"));
                petSearch.setUserId(rs.getInt("user_id"));
                petSearch.setStatus(rs.getString("status"));
                petSearch.setGender(rs.getString("gender"));

                // 处理创建时间（添加空值检查）
                java.sql.Timestamp createTime = rs.getTimestamp("create_time");
                if (createTime != null) {
                    petSearch.setCreateTime(createTime.toLocalDateTime());
                }
                // 新增：设置年龄字段
                petSearch.setAge(rs.getInt("age"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return petSearch;
    }
    // 3. 更新寻宠信息
    @Override
    public int update(PetSearch petSearch) {
        // 新增 age 字段的更新
        String sql = "UPDATE pet_search SET name = ?, type = ?, location = ?, lost_time = ?, " +
                "description = ?, image_path = ?, contact = ?, status = ?, age = ?, " +
                "gender = ? WHERE id = ? AND user_id = ?";  // 新增gender=?
        int rows = 0;

        try (Connection conn = JdbcUtils.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, petSearch.getName());
            pstmt.setString(2, petSearch.getType());
            pstmt.setString(3, petSearch.getLocation());
            // 处理时间字段（添加空值检查）
            LocalDateTime lostTime = petSearch.getLostTime();
            if (lostTime != null) {
                pstmt.setTimestamp(4, java.sql.Timestamp.valueOf(lostTime));
            } else {
                pstmt.setNull(4, java.sql.Types.TIMESTAMP);
            }
            pstmt.setString(5, petSearch.getDescription());
            pstmt.setString(6, petSearch.getImagePath());
            pstmt.setString(7, petSearch.getContact());
            pstmt.setString(8, petSearch.getStatus());
            // 新增：设置年龄参数
// 替换原有的 pstmt.setInt(9, petSearch.getAge());
            Integer age = petSearch.getAge();
            if (age != null) {
                pstmt.setInt(9, age);
            } else {
                pstmt.setNull(9, java.sql.Types.INTEGER);
            }
            pstmt.setString(10, petSearch.getGender());
            pstmt.setInt(11, petSearch.getId());
            pstmt.setInt(12, petSearch.getUserId());
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