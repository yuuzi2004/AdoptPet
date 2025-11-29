package com.pet.adopt.service;

import com.pet.adopt.entity.AdoptionApplication;
import java.util.List;

/**
 * 领养申请记录的业务逻辑接口
 */
public interface AdoptionApplicationService {

    /**
     * 根据用户ID查询该用户的所有领养申请记录
     * @param userId 当前登录用户的ID
     * @return 领养申请记录列表（包含关联的宠物信息）
     */
    List<AdoptionApplication> getApplicationsByUserId(Integer userId);
}