package com.pet.adopt.entity;

import java.time.LocalDateTime;

public class PetSearch {
    private Integer id;
    private String name;
    private String type;
    private String location;
    private LocalDateTime lostTime;
    private String description;
    private String imagePath;
    private String contact;
    private Integer userId;
    private String status; // searching/found
    private LocalDateTime createTime;

    public PetSearch() {}

    public PetSearch(String name, String type, String location, LocalDateTime lostTime, 
                     String description, String contact, String imagePath) {
        this.name = name;
        this.type = type;
        this.location = location;
        this.lostTime = lostTime;
        this.description = description;
        this.contact = contact;
        this.imagePath = imagePath;
        this.status = "searching";
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public LocalDateTime getLostTime() { return lostTime; }
    public void setLostTime(LocalDateTime lostTime) { this.lostTime = lostTime; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
    
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
    
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(LocalDateTime createTime) { this.createTime = createTime; }
}

