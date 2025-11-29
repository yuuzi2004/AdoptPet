package com.pet.adopt.dao;

import com.pet.adopt.entity.AdoptionApplication;
import java.util.List;

/**
 * 领养申请记录的数据访问接口
 */
public interface AdoptionApplicationDao {

    /**
     * 根据用户ID查询该用户的所有领养申请记录（关联宠物信息）
     * @param userId 当前登录用户的ID
     * @return 该用户的所有领养申请列表（包含宠物信息）
     */
    List<AdoptionApplication> findByUserId(Integer userId);
}