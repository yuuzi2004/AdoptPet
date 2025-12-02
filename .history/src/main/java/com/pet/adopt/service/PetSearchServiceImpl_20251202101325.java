package com.pet.adopt.service;

import com.pet.adopt.dao.PetSearchDao;
import com.pet.adopt.dao.PetSearchDaoImpl;
import com.pet.adopt.entity.PetSearch;

import java.util.ArrayList;
import java.util.List;

public class PetSearchServiceImpl implements PetSearchService {

    // 实例化Dao层对象（如果是Spring项目，建议用注解注入，后续可优化）
    private PetSearchDao petSearchDao = new PetSearchDaoImpl();

    /**
     * 查询当前用户的所有寻宠信息
     */
    @Override
    public List<PetSearch> getMyPetSearchList(Integer userId) {
        if (userId == null || userId <= 0) {
            return new ArrayList<>(); // 防止空指针，返回空列表
        }
        try {
            return petSearchDao.findByUserId(userId);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>(); // 发生异常时返回空列表，避免页面崩溃
        }
    }

    /**
     * 权限验证后查询单条信息
     */
    @Override
    public PetSearch getPetSearchByIdAndUserId(Integer id, Integer userId) {
        if (id == null || id <= 0 || userId == null || userId <= 0) {
            return null;
        }
        return petSearchDao.findByIdAndUserId(id, userId);
    }

    /**
     * 更新寻宠信息
     */
    @Override
    public boolean updatePetSearch(PetSearch petSearch) {
        if (petSearch == null || petSearch.getId() == null || petSearch.getUserId() == null) {
            return false;
        }
        // 先验证权限：确保该信息属于当前用户
        PetSearch existPetSearch = petSearchDao.findByIdAndUserId(petSearch.getId(), petSearch.getUserId());
        if (existPetSearch == null) {
            return false; // 无权限修改
        }
        int rows = petSearchDao.update(petSearch);
        return rows > 0;
    }

    /**
     * 删除寻宠信息
     */
    @Override
    public boolean deletePetSearch(Integer id, Integer userId) {
        if (id == null || id <= 0 || userId == null || userId <= 0) {
            return false;
        }
        // 先验证权限
        PetSearch existPetSearch = petSearchDao.findByIdAndUserId(id, userId);
        if (existPetSearch == null) {
            return false; // 无权限删除
        }
        int rows = petSearchDao.deleteByIdAndUserId(id, userId);
        return rows > 0;
    }
}