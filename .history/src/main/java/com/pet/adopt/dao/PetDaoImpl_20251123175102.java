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
            // 1. 获取数据库连接
            conn = JdbcUtils.getConnection();
            // 2. 编写SQL语句，? 是占位符
            String sql = "INSERT INTO pet (name, type, age, gender, description, image_path) VALUES (?, ?, ?, ?, ?, ?)";
            // 3. 创建预处理语句对象
            pstmt = conn.prepareStatement(sql);
            // 4. 给占位符赋值
            pstmt.setString(1, pet.getName());
            pstmt.setString(2, pet.getType());
            pstmt.setInt(3, pet.getAge());
            pstmt.setString(4, pet.getGender());
            pstmt.setString(5, pet.getDescription());
            pstmt.setString(6, pet.getImagePath());
            // 5. 执行SQL，返回受影响的行数
            int rows = pstmt.executeUpdate();
            // 6. 判断是否添加成功
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            // 7. 关闭资源
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
            String sql = "SELECT id, name, type, age, gender, description FROM pet";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            // 遍历结果集，封装成Pet对象并加入集合
            while (rs.next()) {
                Pet pet = new Pet();
                pet.setId(rs.getInt("id"));
                pet.setName(rs.getString("name"));
                pet.setType(rs.getString("type"));
                pet.setAge(rs.getInt("age"));
                pet.setGender(rs.getString("gender"));
                pet.setDescription(rs.getString("description"));
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
            String sql = "SELECT id, name, type, age, gender, description FROM pet WHERE id = ?";
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
}