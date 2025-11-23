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

-- 5. 查询验证
SELECT * FROM `pet`;

