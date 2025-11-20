package com.pet.adopt.entity;

public class Pet {
    private Integer id;
    private String name;
    private String type; // 如“猫”“狗”
    private Integer age;
    private String gender; // “公”“母”
    private String description; // 宠物描述

    // 构造方法（无参、有参）
    public Pet() {}
    public Pet(String name, String type, Integer age, String gender, String description) {
        this.name = name;
        this.type = type;
        this.age = age;
        this.gender = gender;
        this.description = description;
    }

    // Getter和Setter方法
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    // toString方法（方便调试）
    @Override
    public String toString() {
        return "Pet{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", age=" + age +
                ", gender='" + gender + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}