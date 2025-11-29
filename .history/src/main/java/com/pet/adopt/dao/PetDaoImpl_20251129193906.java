package com.pet.adopt.dao;

import com.pet.adopt.entity.Pet;
import com.pet.adopt.utils.JdbcUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PetDaoImpl implements PetDao {

    @Override
    public boolean addPet(Pet pet) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtils.getConnection();
            String sql = "INSERT INTO pet (name, type, age, gender, description, image_path, user_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, pet.getName());
            pstmt.setString(2, pet.getType());
            pstmt.setInt(3, pet.getAge());
            pstmt.setString(4, pet.getGender());
            pstmt.setString(5, pet.getDescription());
            pstmt.setString(6, pet.getImagePath());
            pstmt.setObject(7, pet.getUserId()); // user_id可以为null（兼容旧数据）
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            JdbcUtils.close(conn, pstmt);
        }
    }

    @Override
    public List<Pet> findAllPets() {
        List<Pet> petList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtils.getConnection();
            String sql = "SELECT id, name, type, age, gender, description, image_path, user_id FROM pet";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setId(rs.getInt("id"));
                pet.setName(rs.getString("name"));
                pet.setType(rs.getString("type"));
                pet.setAge(rs.getInt("age"));
                pet.setGender(rs.getString("gender"));
                pet.setDescription(rs.getString("description"));
                pet.setImagePath(rs.getString("image_path"));
                pet.setUserId(rs.getObject("user_id") != null ? rs.getInt("user_id") : null);
                petList.add(pet);
            }
            return petList;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }
    }

    @Override
    public Pet findPetById(Integer id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtils.getConnection();
            String sql = "SELECT id, name, type, age, gender, description, image_path, user_id FROM pet WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Pet pet = new Pet();
                pet.setId(rs.getInt("id"));
                pet.setName(rs.getString("name"));
                pet.setType(rs.getString("type"));
                pet.setAge(rs.getInt("age"));
                pet.setGender(rs.getString("gender"));
                pet.setDescription(rs.getString("description"));
                pet.setImagePath(rs.getString("image_path"));
                pet.setUserId(rs.getObject("user_id") != null ? rs.getInt("user_id") : null);
                return pet;
            }
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }
    }

    // 实现带类型、性别、年龄范围的条件查询
    @Override
    public List<Pet> findPetsByCondition(String type, String gender, Integer minAge, Integer maxAge) {
        List<Pet> petList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtils.getConnection();
            // 动态构建SQL查询条件
            StringBuilder sql = new StringBuilder("SELECT id, name, type, age, gender, description, image_path, user_id FROM pet WHERE 1=1");
            List<Object> params = new ArrayList<>();

            // 类型筛选条件
            if (type != null && !type.trim().isEmpty()) {
                sql.append(" AND type = ?");
                params.add(type.trim());
            }

            // 性别筛选条件
            if (gender != null && !gender.trim().isEmpty()) {
                sql.append(" AND gender = ?");
                params.add(gender.trim());
            }

            // 最小年龄筛选条件（年龄 >= minAge）
            if (minAge != null && minAge >= 0) {
                sql.append(" AND age >= ?");
                params.add(minAge);
            }

            // 最大年龄筛选条件（年龄 <= maxAge）
            if (maxAge != null && maxAge >= 0) {
                sql.append(" AND age <= ?");
                params.add(maxAge);
            }

            pstmt = conn.prepareStatement(sql.toString());
            // 设置参数（按添加顺序）
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }

            rs = pstmt.executeQuery();
            // 封装查询结果
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setId(rs.getInt("id"));
                pet.setName(rs.getString("name"));
                pet.setType(rs.getString("type"));
                pet.setAge(rs.getInt("age"));
                pet.setGender(rs.getString("gender"));
                pet.setDescription(rs.getString("description"));
                pet.setImagePath(rs.getString("image_path"));
                petList.add(pet);
            }
            return petList;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            JdbcUtils.close(conn, pstmt, rs);
        }
    }
}