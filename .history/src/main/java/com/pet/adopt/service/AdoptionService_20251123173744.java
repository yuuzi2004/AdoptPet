package com.pet.adopt.service;

import com.pet.adopt.entity.AdoptionApplication;
import java.util.List;

public interface AdoptionService {
    // 提交领养申请
    boolean submitApplication(AdoptionApplication application);
    
    // 根据用户ID查询申请列表
    List<AdoptionApplication> getApplicationsByUserId(Integer userId);
    
    // 根据宠物ID查询申请列表
    List<AdoptionApplication> getApplicationsByPetId(Integer petId);
    
    // 根据ID查询申请
    AdoptionApplication getApplicationById(Integer id);
    
    // 检查用户是否已经申请过该宠物
    boolean hasUserApplied(Integer userId, Integer petId);
}

