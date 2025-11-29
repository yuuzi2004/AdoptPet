package com.pet.adopt.service;

import com.pet.adopt.dao.AdoptionApplicationDao;
import com.pet.adopt.dao.AdoptionApplicationDaoImpl;
import com.pet.adopt.entity.AdoptionApplication;
import java.util.List;

public class AdoptionApplicationServiceImpl implements AdoptionApplicationService {

    // 依赖DAO层的实现类（创建DAO对象，用于调用查询方法）
    private AdoptionApplicationDao adoptionApplicationDao = new AdoptionApplicationDaoImpl();

    /**
     * 调用DAO层方法，查询用户的领养申请记录
     */
    @Override
    public List<AdoptionApplication> getApplicationsByUserId(Integer userId) {
        // 直接调用DAO层的查询方法，返回结果（后续如果有业务逻辑，可在这里添加）
        return adoptionApplicationDao.findByUserId(userId);
    }
}