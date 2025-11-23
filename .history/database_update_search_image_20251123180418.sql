-- 为pet_search表添加图片字段
ALTER TABLE `pet_search` ADD COLUMN `image_path` VARCHAR(255) COMMENT '宠物图片路径' AFTER `description`;

