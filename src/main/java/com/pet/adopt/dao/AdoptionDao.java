package com.pet.adopt.dao;

import com.pet.adopt.entity.AdoptionApplication;
import java.util.List;

public interface AdoptionDao {
    // 提交领养申请
    boolean addApplication(AdoptionApplication application);

    // 根据用户ID查询申请列表
    List<AdoptionApplication> findApplicationsByUserId(Integer userId);

    // 根据宠物ID查询申请列表
    List<AdoptionApplication> findApplicationsByPetId(Integer petId);

    // 根据ID查询申请
    AdoptionApplication findApplicationById(Integer id);

    // 检查用户是否已经申请过该宠物
    boolean hasUserApplied(Integer userId, Integer petId);

    // 新增：根据申请ID和用户ID删除申请（带权限校验）
    int deleteByIdAndUserId(Integer applicationId, Integer userId);
}