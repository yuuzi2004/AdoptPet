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
}