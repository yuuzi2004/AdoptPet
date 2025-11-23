package com.pet.adopt.entity;

import java.time.LocalDateTime;

public class AdoptionApplication {
    private Integer id;
    private Integer petId;
    private Integer userId;
    private String reason;
    private String contact;
    private String status; // pending/approved/rejected
    private LocalDateTime createTime;
    private LocalDateTime processTime;
    
    // 关联对象（用于显示）
    private Pet pet;
    private User user;

    public AdoptionApplication() {}

    public AdoptionApplication(Integer petId, Integer userId, String reason, String contact) {
        this.petId = petId;
        this.userId = userId;
        this.reason = reason;
        this.contact = contact;
        this.status = "pending";
    }

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public Integer getPetId() { return petId; }
    public void setPetId(Integer petId) { this.petId = petId; }
    
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
    
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public LocalDateTime getCreateTime() { return createTime; }
    public void setCreateTime(LocalDateTime createTime) { this.createTime = createTime; }
    
    public LocalDateTime getProcessTime() { return processTime; }
    public void setProcessTime(LocalDateTime processTime) { this.processTime = processTime; }
    
    public Pet getPet() { return pet; }
    public void setPet(Pet pet) { this.pet = pet; }
    
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    @Override
    public String toString() {
        return "AdoptionApplication{" +
                "id=" + id +
                ", petId=" + petId +
                ", userId=" + userId +
                ", reason='" + reason + '\'' +
                ", contact='" + contact + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}

