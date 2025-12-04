<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>编辑宠物信息 - 管理员后台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .container-fluid {
            display: flex;
            min-height: 100vh;
        }
        /* 左侧导航栏样式（匹配你的绿色背景） */
        .sidebar {
            width: 200px;
            background-color: #e6f7ee;
            padding: 20px 0;
            border-right: 1px solid #b3e0cc;
        }
        .sidebar h3 {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #b3e0cc;
        }
        .sidebar .nav {
            list-style: none;
            padding: 0 10px;
        }
        .sidebar .nav li {
            margin-bottom: 8px;
        }
        .sidebar .nav a {
            display: block;
            padding: 10px 15px;
            color: #333;
            text-decoration: none;
            border-radius: 4px;
        }
        .sidebar .nav a:hover {
            background-color: #b3e0cc;
        }
        .sidebar .nav a.active {
            background-color: #b3e0cc;
            font-weight: bold;
        }
        /* 右侧内容区 */
        .main-content {
            flex: 1;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .section {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <!-- 左侧导航栏 -->
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

    <!-- 右侧内容区 -->
    <div class="main-content">
        <div class="header">
            <h2><i class="bi bi-pencil me-2"></i>编辑宠物信息</h2>
            <div>
                欢迎，管理员
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger btn-sm ms-2">退出</a>
            </div>
        </div>

        <div class="section">
            <form action="${pageContext.request.contextPath}/admin/pet/update" method="post" enctype="multipart/form-data">
                <!-- 隐藏字段存储宠物ID -->
                <input type="hidden" name="id" value="${pet.id}">

                <div class="mb-3">
                    <label for="name" class="form-label">宠物名称 *</label>
                    <input type="text" class="form-control" id="name" name="name" value="${pet.name}" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="type" class="form-label">宠物类型 *</label>
                        <input type="text" class="form-control" id="type" name="type" value="${pet.type}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="age" class="form-label">年龄 *</label>
                        <input type="number" class="form-control" id="age" name="age" value="${pet.age}" required min="0">
                    </div>
                </div>

                <div class="mb-3">
                    <label for="gender" class="form-label">性别 *</label>
                    <select class="form-select" id="gender" name="gender" required>
                        <option value="公" ${pet.gender == '公' ? 'selected' : ''}>公</option>
                        <option value="母" ${pet.gender == '母' ? 'selected' : ''}>母</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">描述信息 *</label>
                    <textarea class="form-control" id="description" name="description" rows="5" required>${pet.description}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">当前图片</label><br>
                    <c:choose>
                        <c:when test="${not empty pet.imagePath}">
                            <c:choose>
                                <c:when test="${fn:startsWith(pet.imagePath, 'uploads/')}">
                                    <img src="${pageContext.request.contextPath}/uploads/${fn:substringAfter(pet.imagePath, 'uploads/')}" 
                                         width="200" 
                                         alt="${pet.name}"
                                         class="img-thumbnail"
                                         onerror="this.src='https://via.placeholder.com/200x200/a8e6cf/2d5016?text=暂无图片'">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/${pet.imagePath}" 
                                         width="200" 
                                         alt="${pet.name}"
                                         class="img-thumbnail"
                                         onerror="this.src='https://via.placeholder.com/200x200/a8e6cf/2d5016?text=暂无图片'">
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/200x200/a8e6cf/2d5016?text=暂无图片" 
                                 width="200" 
                                 alt="暂无图片"
                                 class="img-thumbnail">
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="mb-3">
                    <label for="image" class="form-label">更换图片（可选）</label>
                    <input type="file" class="form-control" id="image" name="image" accept="image/*">
                    <small class="form-text text-muted">支持 JPG、PNG、GIF 格式，最大 5MB</small>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check-circle me-1"></i>保存修改
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/pet/list" class="btn btn-secondary">
                        <i class="bi bi-x-circle me-1"></i>取消
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>

