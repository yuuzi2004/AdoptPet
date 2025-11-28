package com.pet.adopt.service;

import com.pet.adopt.dao.PetDao;
import com.pet.adopt.dao.PetDaoImpl;
import com.pet.adopt.entity.Pet;
import java.util.List;

public class PetServiceImpl implements PetService {
    // 依赖注入 Dao 层对象
    private PetDao petDao = new PetDaoImpl();

    @Override
    public boolean addPet(Pet pet) {
        if (pet.getName() == null || pet.getName().trim().isEmpty()) {
            return false;
        }
        return petDao.addPet(pet);
    }

    @Override
    public List<Pet> findAllPets() {
        return petDao.findAllPets();
    }

    @Override
    public Pet findPetById(Integer id) {
        if (id == null || id <= 0) {
            return null;
        }
        return petDao.findPetById(id);
    }

    // 实现带年龄筛选的条件查询
    @Override
    public List<Pet> findPetsByCondition(String type, String gender, Integer minAge, Integer maxAge) {
        // 参数过滤：去除首尾空格，空值处理
        String filteredType = (type != null) ? type.trim() : null;
        String filteredGender = (gender != null) ? gender.trim() : null;
        // 调用 Dao 层的条件查询方法（下一步会实现 Dao 层的该方法）
        return petDao.findPetsByCondition(filteredType, filteredGender, minAge, maxAge);
    }
}