package com.pet.adopt.dao;

import com.pet.adopt.entity.PetSearch;
import java.util.List;

public interface PetSearchDao {
    // 已有的方法保持不变，添加以下新方法
    /**
     * 根据用户ID查询发布的寻宠信息
     * @param userId 用户ID
     * @return 寻宠信息列表
     */
    List<PetSearch> findByUserId(Integer userId);

    /**
     * 根据ID和用户ID查询寻宠信息（权限验证）
     * @param id 寻宠信息ID
     * @param userId 用户ID
     * @return 寻宠信息
     */
    PetSearch findByIdAndUserId(Integer id, Integer userId);

    /**
     * 更新寻宠信息
     * @param petSearch 寻宠信息对象
     * @return 影响行数
     */
    int update(PetSearch petSearch);

    /**
     * 删除寻宠信息
     * @param id 寻宠信息ID
     * @param userId 用户ID
     * @return 影响行数
     */
    int deleteByIdAndUserId(Integer id, Integer userId);
}