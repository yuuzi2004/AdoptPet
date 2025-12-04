<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加新宠物 - 管理员后台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        /* 复用管理员后台统一样式（和宠物管理列表页完全一致） */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        .container-fluid { display: flex; min-height: 100vh; background-color: #f8f9fa; }
        .sidebar { width: 200px; background-color: #e6f7ee; padding: 20px 0; border-right: 1px solid #b3e0cc; flex-shrink: 0; }
        .sidebar h3 { text-align: center; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 1px solid #b3e0cc; font-size: 18px; color: #2d5016; }
        .sidebar .nav { list-style: none; padding: 0 10px; }
        .sidebar .nav li { margin-bottom: 8px; }
        .sidebar .nav a { display: block; padding: 10px 15px; color: #333; text-decoration: none; border-radius: 4px; font-size: 14px; }
        .sidebar .nav a:hover, .sidebar .nav a.active { background-color: #b3e0cc; color: #000; font-weight: 500; }
        .main-content { flex: 1; padding: 25px; max-width: calc(100% - 200px); overflow-y: auto; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 1px solid #e9ecef; }
        .page-header h2 { font-size: 20px; font-weight: 600; margin: 0; }
        .card-container { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); margin-bottom: 20px; }
        .form-label { font-weight: 500; margin-bottom: 8px; font-size: 14px; }
        .form-control, .form-select { font-size: 14px; padding: 8px 12px; border-radius: 4px; border: 1px solid #ced4da; }
        .form-control:focus, .form-select:focus { border-color: #80bdff; box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25); outline: 0; }
        .btn { font-size: 14px; padding: 6px 12px; border-radius: 4px; }
        .form-text { font-size: 12px; color: #6c757d; margin-top: 4px; }
    </style>
</head>
<body>
<div class="container-fluid">
    <!-- 左侧导航栏（和宠物管理列表页完全一致） -->
    <div class="sidebar">
        <h3>管理员后台</h3>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="bi bi-speedometer2"></i> 仪表盘
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/pet/list">
                    <i class="bi bi-heart-pulse"></i> 宠物管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/user/list">
                    <i class="bi bi-people"></i> 用户管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/adoption">
                    <i class="bi bi-journal-check"></i> 领养申请
                </a>
            </li>
        </ul>
    </div>

    <!-- 右侧添加宠物表单 -->
    <div class="main-content">
        <div class="page-header">
            <h2><i class="bi bi-plus-circle me-2 text-primary"></i>添加新宠物</h2>
            <div>
                欢迎，管理员
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger btn-sm ms-2">退出</a>
            </div>
        </div>

        <div class="card-container">
            <!-- 表单提交到管理员添加宠物的Servlet（下一步会创建） -->
            <form action="${pageContext.request.contextPath}/admin/pet/add" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="name" class="form-label">宠物名称 *</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="type" class="form-label">宠物类型 *</label>
                        <input type="text" class="form-control" id="type" name="type" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="age" class="form-label">年龄 *</label>
                        <input type="number" class="form-control" id="age" name="age" required min="0">
                    </div>
                </div>

                <div class="mb-3">
                    <label for="gender" class="form-label">性别 *</label>
                    <select class="form-select" id="gender" name="gender" required>
                        <option value="公">公</option>
                        <option value="母">母</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">描述信息 *</label>
                    <textarea class="form-control" id="description" name="description" rows="5" required></textarea>
                </div>

                <div class="mb-3">
                    <label for="image" class="form-label">上传图片 *</label>
                    <input type="file" class="form-control" id="image" name="image" accept="image/*" required>
                    <div class="form-text">支持 JPG、PNG、GIF 格式，最大 5MB</div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check-circle me-1"></i>保存宠物
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/pet/list" class="btn btn-secondary">
                        <i class="bi bi-x-circle me-1"></i>取消
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>