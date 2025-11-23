package com.pet.adopt.service;

import com.pet.adopt.dao.AdoptionDao;
import com.pet.adopt.dao.AdoptionDaoImpl;
import com.pet.adopt.entity.AdoptionApplication;

import java.util.List;

public class AdoptionServiceImpl implements AdoptionService {
    private AdoptionDao adoptionDao = new AdoptionDaoImpl();
    
    @Override
    public boolean submitApplication(AdoptionApplication application) {
        // 检查是否已经申请过
        if (adoptionDao.hasUserApplied(application.getUserId(), application.getPetId())) {
            return false; // 已经申请过，不允许重复申请
        }
        return adoptionDao.addApplication(application);
    }
    
    @Override
    public List<AdoptionApplication> getApplicationsByUserId(Integer userId) {
        return adoptionDao.findApplicationsByUserId(userId);
    }
    
    @Override
    public List<AdoptionApplication> getApplicationsByPetId(Integer petId) {
        return adoptionDao.findApplicationsByPetId(petId);
    }
    
    @Override
    public AdoptionApplication getApplicationById(Integer id) {
        return adoptionDao.findApplicationById(id);
    }
    
    @Override
    public boolean hasUserApplied(Integer userId, Integer petId) {
        return adoptionDao.hasUserApplied(userId, petId);
    }
}

