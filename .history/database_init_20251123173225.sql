-- ============================================
-- 宠物领养系统数据库初始化脚本
-- ============================================

-- 1. 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS `pet_adopt` 
    DEFAULT CHARACTER SET utf8mb4 
    DEFAULT COLLATE utf8mb4_unicode_ci;

-- 2. 使用数据库
USE `pet_adopt`;

-- 3. 创建宠物表
DROP TABLE IF EXISTS `pet`;

CREATE TABLE `pet` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '宠物ID，主键',
  `name` VARCHAR(50) NOT NULL COMMENT '宠物名称',
  `type` VARCHAR(20) NOT NULL COMMENT '宠物类型（猫、狗等）',
  `age` INT(11) NOT NULL COMMENT '宠物年龄（单位：岁）',
  `gender` VARCHAR(10) NOT NULL COMMENT '宠物性别（公/母）',
  `description` TEXT COMMENT '宠物描述信息',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='宠物信息表';

-- 4. 插入一些测试数据（可选）
INSERT INTO `pet` (`name`, `type`, `age`, `gender`, `description`) VALUES
('小白', '猫', 2, '母', '温顺可爱的小白猫，已绝育，喜欢和人亲近'),
('旺财', '狗', 3, '公', '活泼好动的金毛，非常友好，适合有孩子的家庭'),
('小花', '猫', 1, '母', '活泼的小花猫，喜欢玩耍，需要耐心陪伴'),
('小黑', '狗', 4, '公', '忠诚的拉布拉多，训练有素，适合作为工作犬');

-- 5. 创建用户表
DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID，主键',
  `username` VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
  `email` VARCHAR(100) NOT NULL UNIQUE COMMENT '邮箱',
  `phone` VARCHAR(20) NOT NULL COMMENT '手机号',
  `password` VARCHAR(255) NOT NULL COMMENT '密码（加密存储）',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `last_login_time` DATETIME COMMENT '最后登录时间',
  PRIMARY KEY (`id`),
  INDEX `idx_username` (`username`),
  INDEX `idx_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 6. 创建管理员表
DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '管理员ID，主键',
  `username` VARCHAR(50) NOT NULL UNIQUE COMMENT '管理员账号',
  `password` VARCHAR(255) NOT NULL COMMENT '密码（加密存储）',
  `name` VARCHAR(50) COMMENT '管理员姓名',
  `role` VARCHAR(20) DEFAULT 'admin' COMMENT '角色（admin/super_admin）',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_login_time` DATETIME COMMENT '最后登录时间',
  PRIMARY KEY (`id`),
  INDEX `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员表';

-- 7. 创建寻宠信息表
DROP TABLE IF EXISTS `pet_search`;

CREATE TABLE `pet_search` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '寻宠信息ID，主键',
  `name` VARCHAR(50) NOT NULL COMMENT '宠物名称',
  `type` VARCHAR(20) NOT NULL COMMENT '宠物类型',
  `location` VARCHAR(200) NOT NULL COMMENT '丢失地点',
  `lost_time` DATETIME NOT NULL COMMENT '丢失时间',
  `description` TEXT COMMENT '宠物特征描述',
  `contact` VARCHAR(100) NOT NULL COMMENT '联系方式',
  `user_id` INT(11) COMMENT '发布用户ID（可选）',
  `status` VARCHAR(20) DEFAULT 'searching' COMMENT '状态（searching/found）',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  PRIMARY KEY (`id`),
  INDEX `idx_user_id` (`user_id`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='寻宠信息表';

-- 8. 创建领养申请表
DROP TABLE IF EXISTS `adoption_application`;

CREATE TABLE `adoption_application` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '申请ID，主键',
  `pet_id` INT(11) NOT NULL COMMENT '宠物ID',
  `user_id` INT(11) NOT NULL COMMENT '申请人ID',
  `reason` TEXT COMMENT '申请理由',
  `contact` VARCHAR(100) NOT NULL COMMENT '联系方式',
  `status` VARCHAR(20) DEFAULT 'pending' COMMENT '状态（pending/approved/rejected）',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
  `process_time` DATETIME COMMENT '处理时间',
  PRIMARY KEY (`id`),
  INDEX `idx_pet_id` (`pet_id`),
  INDEX `idx_user_id` (`user_id`),
  INDEX `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领养申请表';

-- 9. 插入默认管理员账号（密码：admin123，实际使用时需要加密）
-- 注意：实际部署时请修改默认密码！
INSERT INTO `admin` (`username`, `password`, `name`, `role`) VALUES
('admin', 'admin123', '系统管理员', 'admin');

-- 10. 插入测试用户（密码：123456，实际使用时需要加密）
INSERT INTO `user` (`username`, `email`, `phone`, `password`) VALUES
('testuser', 'test@example.com', '13800138000', '123456');

-- 11. 查询验证
SELECT * FROM `pet`;
SELECT * FROM `user`;
SELECT * FROM `admin`;

