package com.pet.adopt.service;

import com.pet.adopt.entity.AdoptionApplication;
import java.util.List;

public interface AdoptionService {
    // 提交领养申请（原有方法保留）
    boolean submitApplication(AdoptionApplication application);

    // 根据用户ID查询申请列表（原有方法保留）
    List<AdoptionApplication> getApplicationsByUserId(Integer userId);

    // 根据宠物ID查询申请列表（原有方法保留）
    List<AdoptionApplication> getApplicationsByPetId(Integer petId);

    // 根据ID查询申请（原有方法保留）
    AdoptionApplication getApplicationById(Integer id);

    // 检查用户是否已经申请过该宠物（原有方法保留）
    boolean hasUserApplied(Integer userId, Integer petId);

    // ========== 新增管理员功能方法 ==========
    /**
     * 查询所有领养申请（供管理员查看）
     * @return 所有申请列表（按创建时间倒序）
     */
    List<AdoptionApplication> getAllApplications();

    /**
     * 处理领养申请（同意/拒绝）
     * @param id 申请ID
     * @param status 处理后的状态（pending/approved/rejected）
     * @return 是否处理成功
     */
    boolean processApplication(Integer id, String status);
}