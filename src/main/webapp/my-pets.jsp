<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心 - 毛孩子领养平台</title>
    <!-- 引入 Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入图标库 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #a8e6cf;
            --secondary-color: #ffd3d3;
            --accent-color: #c7ecee;
            --success-color: #a8e6cf;
            --danger-color: #ffaaa5;
            --card-shadow: 0 2px 8px rgba(0,0,0,0.08);
            --card-shadow-hover: 0 8px 24px rgba(0,0,0,0.12);
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background: linear-gradient(135deg, #e8f5e9 0%, #f1f8e9 50%, #fff9c4 100%);
        }

        .section {
            padding: 60px 0;
            min-height: calc(100vh - 200px);
        }

        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            background: linear-gradient(135deg, #a8e6cf 0%, #c7ecee 50%, #ffd3d3 100%) !important;
        }

        .navbar-brand, .nav-link {
            color: #2d5016 !important;
            font-weight: 600;
        }

        .nav-link:hover {
            color: #1a3009 !important;
            background-color: rgba(255, 255, 255, 0.3);
            border-radius: 8px;
        }

        .nav-link.active {
            background-color: rgba(255, 255, 255, 0.4);
            border-radius: 8px;
        }

        .page-header {
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 0;
        }

        .pet-card {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .pet-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--card-shadow-hover);
        }

        .pet-card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .pet-card:hover img {
            transform: scale(1.05);
        }

        .pet-card .card-body {
            flex: 1;
            padding: 1.25rem;
        }

        .pet-card .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 0.75rem;
        }

        .pet-card .card-text {
            font-size: 0.9rem;
            line-height: 1.6;
            color: #6b7280;
        }

        .pet-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.75rem;
            flex-wrap: wrap;
        }

        .pet-info-item {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            font-size: 0.85rem;
            color: #6b7280;
        }

        .pet-description {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            margin-bottom: 1rem;
        }

        .card-footer {
            padding: 1rem 1.25rem;
            background-color: #f9fafb;
            border-top: 1px solid #e5e7eb;
        }

        .btn-action {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: all 0.2s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 50%, var(--secondary-color) 100%);
            border: none;
            color: #2d5016;
            font-weight: 600;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(168, 230, 207, 0.6);
            color: #1a3009;
        }

        .btn-danger {
            background: linear-gradient(135deg, #ffaaa5 0%, #ffd3d3 100%);
            border: none;
            color: #721c24;
            font-weight: 600;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 170, 165, 0.6);
            background: linear-gradient(135deg, #ff6b6b 0%, #ffaaa5 100%);
        }

        .badge-type {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 500;
            background-color: rgba(168, 230, 207, 0.3);
            color: #2d5016;
        }

        .empty-state {
            padding: 4rem 2rem;
            text-align: center;
        }

        .empty-state-icon {
            font-size: 4rem;
            color: #d1d5db;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
<!-- 导航栏 -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="bi bi-paw-fill me-2"></i>毛孩子领养
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">首页</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/pet/list">领养列表</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/add.jsp">发布信息</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/search.jsp">寻找宠物</a></li>
                <c:choose>
                    <c:when test="${not empty sessionScope.userId}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle me-1"></i>${sessionScope.username}
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/my-pets">
                                    <i class="bi bi-list-ul me-2"></i>个人中心</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">退出登录</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">登录</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- 列表区 -->
<section class="section">
    <div class="container">
        <!-- 成功提示 -->
        <c:if test="${not empty param.success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle me-2"></i>${param.success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- 错误提示 -->
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-circle me-2"></i>${param.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- 页面标题和操作按钮 -->
        <div class="page-header d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-3">
            <div>
                <h1 class="page-title">
                    <i class="bi bi-list-ul text-primary me-2" style="font-size: 1.5rem;"></i>
                    个人中心
                </h1>
                <p class="text-muted mb-0 mt-2">
                    <c:choose>
                        <c:when test="${not empty petList}">
                            共发布了 <strong>${petList.size()}</strong> 条领养信息
                        </c:when>
                        <c:otherwise>
                            您还没有发布任何领养信息
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            <a href="${pageContext.request.contextPath}/add.jsp" class="btn btn-primary btn-action">
                <i class="bi bi-plus-circle me-2"></i>发布新信息
            </a>
        </div>

        <!-- 宠物列表卡片 -->
        <c:choose>
            <c:when test="${not empty petList}">
                <div class="row g-4">
                    <c:forEach items="${petList}" var="pet">
                        <div class="col-6 col-md-4 col-lg-3">
                            <div class="pet-card">
                                <!-- 宠物图片 -->
                                <div class="position-relative" style="overflow: hidden;">
                                    <c:choose>
                                        <c:when test="${not empty pet.imagePath}">
                                            <c:choose>
                                                <c:when test="${fn:startsWith(pet.imagePath, 'uploads/')}">
                                                    <img src="${pageContext.request.contextPath}/uploads/${fn:substringAfter(pet.imagePath, 'uploads/')}"
                                                         class="card-img-top"
                                                         alt="${pet.name}"
                                                         loading="lazy"
                                                         onerror="this.src='https://via.placeholder.com/600x400/a8e6cf/2d5016?text=暂无图片'"
                                                         style="object-fit: cover;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/${pet.imagePath}"
                                                         class="card-img-top"
                                                         alt="${pet.name}"
                                                         loading="lazy"
                                                         onerror="this.src='https://via.placeholder.com/600x400/a8e6cf/2d5016?text=暂无图片'"
                                                         style="object-fit: cover;">
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <img src="https://via.placeholder.com/600x400/a8e6cf/2d5016?text=暂无图片"
                                                 class="card-img-top"
                                                 alt="${pet.name}"
                                                 loading="lazy"
                                                 style="object-fit: cover;">
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="badge-type position-absolute top-0 end-0 m-2">
                                            ${pet.type}
                                    </span>
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <i class="bi bi-heart-fill text-danger me-1" style="font-size: 0.875rem;"></i>
                                            ${pet.name}
                                    </h5>
                                    <div class="pet-info">
                                        <span class="pet-info-item">
                                            <i class="bi bi-calendar-check"></i>
                                            ${pet.age}岁
                                        </span>
                                        <span class="pet-info-item">
                                            <i class="bi bi-venus-mars"></i>
                                            ${pet.gender}
                                        </span>
                                    </div>
                                    <p class="pet-description">${pet.description}</p>
                                </div>
                                <div class="card-footer">
                                    <div class="d-flex flex-column gap-2">
                                        <a href="${pageContext.request.contextPath}/pet/detail?id=${pet.id}"
                                           class="btn btn-sm btn-outline-primary btn-action">
                                            <i class="bi bi-info-circle me-1"></i>查看详情
                                        </a>
                                        <div class="d-flex gap-2">
                                            <a href="${pageContext.request.contextPath}/user/pet/edit?id=${pet.id}"
                                               class="btn btn-sm btn-primary btn-action flex-grow-1">
                                                <i class="bi bi-pencil me-1"></i>编辑
                                            </a>
                                            <button type="button" 
                                                    class="btn btn-sm btn-danger btn-action"
                                                    onclick="confirmDelete(${pet.id}, '${pet.name}')">
                                                <i class="bi bi-trash me-1"></i>删除
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 空状态 -->
                <div class="empty-state">
                    <div class="empty-state-icon">
                        <i class="bi bi-paw"></i>
                    </div>
                    <h4>还没有发布任何信息</h4>
                    <p>快来发布第一条领养信息吧！</p>
                    <a href="${pageContext.request.contextPath}/add.jsp" class="btn btn-primary btn-action">
                        <i class="bi bi-plus-circle me-2"></i>发布信息
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- 页脚 -->
<footer class="bg-dark text-white py-5 mt-5">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <h5 class="mb-3">
                    <i class="bi bi-paw-fill me-2"></i>毛孩子领养平台
                </h5>
                <p class="text-white-50 mb-0">用爱终止流浪，让每个生命都有归宿</p>
            </div>
            <div class="col-md-4">
                <h5 class="footer-title">快速链接</h5>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/" class="footer-link">首页</a></li>
                    <li><a href="${pageContext.request.contextPath}/pet/list" class="footer-link">领养列表</a></li>
                    <li><a href="${pageContext.request.contextPath}/add.jsp" class="footer-link">发布信息</a></li>
                    <li><a href="${pageContext.request.contextPath}/search.jsp" class="footer-link">寻找宠物</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5 class="footer-title">联系我们</h5>
                <ul class="list-unstyled">
                    <li style="color: rgba(255,255,255,0.7); margin-bottom: 0.75rem;">
                        <i class="bi bi-phone me-2"></i>19967849558
                    </li>
                    <li style="color: rgba(255,255,255,0.7); margin-bottom: 0.75rem;">
                        <i class="bi bi-envelope me-2"></i>2180392550@qq.com
                    </li>
                    <li style="color: rgba(255,255,255,0.7);">
                        <i class="bi bi-geo-alt me-2"></i>湖南省长沙市芙蓉区农大路1号
                    </li>
                </ul>
            </div>
        </div>
        <div class="border-top border-secondary mt-4 pt-4 text-center text-white-50">
            <p class="mb-0">© 2025 毛孩子领养平台 版权所有 | 用爱心点亮每一个生命</p>
        </div>
    </div>
</footer>

<!-- 引入 Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 确认删除
    function confirmDelete(petId, petName) {
        if (confirm('确定要删除 "' + petName + '" 的领养信息吗？删除后无法恢复！')) {
            // 创建表单提交删除请求
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/user/pet/delete';
            
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'id';
            input.value = petId;
            
            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>
</body>
</html>

