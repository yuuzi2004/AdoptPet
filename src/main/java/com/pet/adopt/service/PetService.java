package com.pet.adopt.service;

import com.pet.adopt.entity.Pet;
import java.util.List;

public interface PetService {
    // 新增宠物
    boolean addPet(Pet pet);

    // 查询所有宠物
    List<Pet> findAllPets();

    // 根据ID查询宠物
    Pet findPetById(Integer id);

    // 新增：根据类型、性别和年龄范围筛选宠物
    List<Pet> findPetsByCondition(String type, String gender, Integer minAge, Integer maxAge);
}