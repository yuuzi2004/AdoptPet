-- ============================================
-- 更新宠物图片路径脚本
-- 将photo文件夹中的图片关联到数据库中的宠物记录
-- ============================================

USE `pet_adopt`;

-- 根据宠物名称更新图片路径
-- 注意：图片路径是相对于webapp目录的路径

UPDATE `pet` SET `image_path` = 'uploads/小白.jpg' WHERE `name` = '小白';
UPDATE `pet` SET `image_path` = 'uploads/旺财.jpg' WHERE `name` = '旺财';
UPDATE `pet` SET `image_path` = 'uploads/小花.jpg' WHERE `name` = '小花';
UPDATE `pet` SET `image_path` = 'uploads/小黑.jpg' WHERE `name` = '小黑';

-- 验证更新结果
SELECT id, name, type, image_path FROM `pet` ORDER BY id;

