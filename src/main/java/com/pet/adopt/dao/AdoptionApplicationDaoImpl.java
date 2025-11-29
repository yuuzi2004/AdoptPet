package com.pet.adopt.dao;

import com.pet.adopt.entity.AdoptionApplication;
import com.pet.adopt.entity.Pet;
import com.pet.adopt.utils.JdbcUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class AdoptionApplicationDaoImpl implements AdoptionApplicationDao {

    /**
     * 根据用户ID查询领养申请记录（关联宠物表，获取宠物名称等信息）
     */
    @Override
    public List<AdoptionApplication> findByUserId(Integer userId) {
        List<AdoptionApplication> applications = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 1. 获取数据库连接
            conn = JdbcUtils.getConnection();

            // 2. 编写SQL：查询用户的申请记录，并关联pet表获取宠物信息
            String sql = "SELECT " +
                    "aa.id, aa.pet_id, aa.user_id, aa.reason, aa.contact, aa.status, " +
                    "aa.create_time, aa.process_time, " +
                    "p.id AS pet_id, p.name AS pet_name, p.type AS pet_type, p.age AS pet_age " +
                    "FROM adoption_application aa " +
                    "LEFT JOIN pet p ON aa.pet_id = p.id " +
                    "WHERE aa.user_id = ? " +
                    "ORDER BY aa.create_time DESC";

            // 3. 预编译SQL
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId); // 传入当前用户ID

            // 4. 执行查询
            rs = pstmt.executeQuery();

            // 5. 处理查询结果，封装成AdoptionApplication对象
            while (rs.next()) {
                AdoptionApplication application = new AdoptionApplication();
                // 设置申请记录基本信息
                application.setId(rs.getInt("id"));
                application.setPetId(rs.getInt("pet_id"));
                application.setUserId(rs.getInt("user_id"));
                application.setReason(rs.getString("reason"));
                application.setContact(rs.getString("contact"));
                application.setStatus(rs.getString("status"));
                application.setCreateTime(rs.getObject("create_time", LocalDateTime.class));
                application.setProcessTime(rs.getObject("process_time", LocalDateTime.class));

                // 关联宠物信息（封装到Pet对象中）
                Pet pet = new Pet();
                pet.setId(rs.getInt("pet_id"));
                pet.setName(rs.getString("pet_name"));
                pet.setType(rs.getString("pet_type"));
                pet.setAge(rs.getInt("pet_age"));
                application.setPet(pet); // 将宠物信息设置到申请记录中

                // 添加到列表
                applications.add(application);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // 实际项目中可替换为日志输出
        } finally {
            // 6. 关闭数据库连接（工具类封装，确保资源释放）
            JdbcUtils.close(conn, pstmt, rs);
        }

        return applications;
    }
}