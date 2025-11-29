-- ============================================
-- 为pet表添加user_id字段，关联发布用户
-- ============================================

USE `pet_adopt`;

-- 为pet表添加user_id字段
ALTER TABLE `pet` ADD COLUMN `user_id` INT(11) COMMENT '发布用户ID，关联user表' AFTER `image_path`;

-- 添加外键约束（可选，如果希望数据库层面保证数据完整性）
-- ALTER TABLE `pet` ADD CONSTRAINT `fk_pet_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

-- 为user_id字段添加索引，提高查询性能
ALTER TABLE `pet` ADD INDEX `idx_user_id` (`user_id`);

-- 验证表结构
DESC `pet`;

