package com.pet.adopt.service;

import com.pet.adopt.entity.AdoptionApplication;
import java.util.List;

public interface AdoptionService {
    // 已有的其他方法...
    boolean submitApplication(AdoptionApplication application);
    List<AdoptionApplication> getApplicationsByUserId(Integer userId);
    List<AdoptionApplication> getApplicationsByPetId(Integer petId);
    AdoptionApplication getApplicationById(Integer id);
    boolean hasUserApplied(Integer userId, Integer petId);
    List<AdoptionApplication> getAllApplications();
    boolean processApplication(Integer id, String status);

    // 新增：根据申请ID和用户ID删除申请（用于权限控制）
    int deleteByIdAndUserId(Integer applicationId, Integer userId);
}