-- 为pet表添加图片字段
ALTER TABLE `pet` ADD COLUMN `image_path` VARCHAR(255) COMMENT '宠物图片路径' AFTER `description`;

-- 为adoption_application表添加图片字段（领养申请时也可以上传图片）
ALTER TABLE `adoption_application` ADD COLUMN `image_path` VARCHAR(255) COMMENT '申请相关图片路径' AFTER `contact`;

