package com.pet.adopt.service;

import com.pet.adopt.entity.PetSearch;
import java.util.List;

public interface PetSearchService {
    /**
     * 根据用户ID查询已发布的寻宠信息
     * @param userId 用户ID
     * @return 寻宠信息列表
     */
    List<PetSearch> getMyPetSearchList(Integer userId);

    /**
     * 根据ID和用户ID查询单条寻宠信息（权限验证）
     * @param id 寻宠信息ID
     * @param userId 用户ID
     * @return 寻宠信息
     */
    PetSearch getPetSearchByIdAndUserId(Integer id, Integer userId);

    /**
     * 更新寻宠信息
     * @param petSearch 寻宠信息对象
     * @return 是否更新成功
     */
    boolean updatePetSearch(PetSearch petSearch);

    /**
     * 删除寻宠信息
     * @param id 寻宠信息ID
     * @param userId 用户ID
     * @return 是否删除成功
     */
    boolean deletePetSearch(Integer id, Integer userId);
}