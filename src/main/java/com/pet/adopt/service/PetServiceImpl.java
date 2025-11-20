package com.pet.adopt.service;

import com.pet.adopt.dao.PetDao;
import com.pet.adopt.dao.PetDaoImpl;
import com.pet.adopt.entity.Pet;
import java.util.List;

public class PetServiceImpl implements PetService {
    // 依赖注入 Dao 层对象（这里用 new 手动创建，后续可优化为工厂或框架注入）
    private PetDao petDao = new PetDaoImpl();

    @Override
    public boolean addPet(Pet pet) {
        // 可在此处添加业务规则，比如“宠物名字不能为空”
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
}