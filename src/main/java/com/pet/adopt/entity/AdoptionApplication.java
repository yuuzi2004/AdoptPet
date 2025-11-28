package com.pet.adopt.entity;

import java.time.LocalDateTime;

public class AdoptionApplication {
    private Integer id;
    private Integer petId;
    private Integer userId;
    private String reason;
    private String contact;
    private String status; // pending/approved/rejected（保持原有字符串状态，不修改）
    private LocalDateTime createTime;
    private LocalDateTime processTime;

    // 关联对象（用于显示申请人/宠物名称，原有保留）
    private Pet pet;
    private User user;

    // 原有空构造方法（保留）
    public AdoptionApplication() {}

    // 原有带参构造方法（保留，默认状态为pending）
    public AdoptionApplication(Integer petId, Integer userId, String reason, String contact) {
        this.petId = petId;
        this.userId = userId;
        this.reason = reason;
        this.contact = contact;
        this.status = "pending";
    }

    // ========== 新增：方便管理员页面显示的辅助方法（核心修改） ==========
    /**
     * 将英文状态转换为中文显示（供JSP页面调用）
     * pending → 待处理，approved → 已同意，rejected → 已拒绝
     */
    public String getStatusCN() {
        switch (status) {
            case "approved":
                return "已同意";
            case "rejected":
                return "已拒绝";
            case "pending":
            default:
                return "待处理";
        }
    }

    /**
     * 判断是否为待处理状态（供JSP页面控制「同意/拒绝」按钮是否显示）
     */
    public boolean isPending() {
        return "pending".equals(this.status);
    }

    // ========== 原有Getters and Setters（全部保留，补充pet/user的getName方法） ==========
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

    // ========== 新增：快捷获取宠物名称（避免JSP页面空指针） ==========
    public String getPetName() {
        return (pet != null && pet.getName() != null) ? pet.getName() : "未知宠物";
    }

    // ========== 新增：快捷获取申请人用户名（避免JSP页面空指针） ==========
    public String getUsername() {
        return (user != null && user.getUsername() != null) ? user.getUsername() : "未知用户";
    }

    // 原有toString方法（保留）
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