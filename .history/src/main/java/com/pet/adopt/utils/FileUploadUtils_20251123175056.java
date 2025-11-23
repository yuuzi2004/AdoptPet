package com.pet.adopt.utils;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

/**
 * 文件上传工具类
 */
public class FileUploadUtils {
    
    // 上传目录（相对于webapp目录）
    private static final String UPLOAD_DIR = "uploads";
    
    // 允许的图片类型
    private static final String[] ALLOWED_TYPES = {"image/jpeg", "image/jpg", "image/png", "image/gif", "image/webp"};
    
    // 最大文件大小（5MB）
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024;
    
    /**
     * 保存上传的文件
     * @param part 文件Part对象
     * @param realPath 应用的真实路径（通过request.getServletContext().getRealPath("")获取）
     * @return 保存后的文件路径（相对于webapp）
     */
    public static String saveFile(Part part, String realPath) throws IOException {
        if (part == null || part.getSize() == 0) {
            return null;
        }
        
        // 验证文件类型
        String contentType = part.getContentType();
        if (!isAllowedType(contentType)) {
            throw new IllegalArgumentException("不支持的文件类型：" + contentType);
        }
        
        // 验证文件大小
        if (part.getSize() > MAX_FILE_SIZE) {
            throw new IllegalArgumentException("文件大小超过限制（最大5MB）");
        }
        
        // 创建上传目录
        String uploadPath = realPath + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // 生成唯一文件名
        String originalFileName = getFileName(part);
        String extension = getFileExtension(originalFileName);
        String newFileName = UUID.randomUUID().toString() + extension;
        
        // 保存文件
        File file = new File(uploadDir, newFileName);
        try (InputStream input = part.getInputStream()) {
            Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        
        // 返回相对路径
        return UPLOAD_DIR + "/" + newFileName;
    }
    
    /**
     * 删除文件
     */
    public static boolean deleteFile(String filePath, String realPath) {
        if (filePath == null || filePath.isEmpty()) {
            return false;
        }
        
        File file = new File(realPath + File.separator + filePath);
        if (file.exists() && file.isFile()) {
            return file.delete();
        }
        return false;
    }
    
    /**
     * 检查文件类型是否允许
     */
    private static boolean isAllowedType(String contentType) {
        if (contentType == null) {
            return false;
        }
        for (String type : ALLOWED_TYPES) {
            if (contentType.equalsIgnoreCase(type)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * 从Part中获取文件名
     */
    private static String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "unknown";
    }
    
    /**
     * 获取文件扩展名
     */
    private static String getFileExtension(String fileName) {
        int lastDot = fileName.lastIndexOf('.');
        if (lastDot > 0 && lastDot < fileName.length() - 1) {
            return fileName.substring(lastDot);
        }
        return ".jpg"; // 默认扩展名
    }
}

