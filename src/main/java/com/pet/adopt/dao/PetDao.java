package com.pet.adopt.dao;

import com.pet.adopt.entity.Pet;
import java.util.List;

public interface PetDao {
    // 1. 新增宠物（添加到数据库）
    boolean addPet(Pet pet);

    // 2. 查询所有宠物（用于展示宠物列表）
    List<Pet> findAllPets();

    // 3. 根据ID查询单个宠物（后续详情页用）
    Pet findPetById(Integer id);

    // 新增：根据类型、性别和年龄范围筛选宠物
    List<Pet> findPetsByCondition(String type, String gender, Integer minAge, Integer maxAge);
}