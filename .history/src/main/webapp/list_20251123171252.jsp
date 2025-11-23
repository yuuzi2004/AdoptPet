<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>宠物领养列表 - 毛孩子领养平台</title>
    <!-- 引入 Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入图标库 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #6366f1;
            --secondary-color: #8b5cf6;
            --success-color: #10b981;
            --card-shadow: 0 2px 8px rgba(0,0,0,0.08);
            --card-shadow-hover: 0 8px 24px rgba(0,0,0,0.12);
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: #f8f9fa;
        }
        
        .section {
            padding: 60px 0;
            min-height: calc(100vh - 200px);
        }
        
        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .navbar-brand {
            font-weight: 600;
            font-size: 1.25rem;
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
        
        .filter-card {
            background: white;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            padding: 1.5rem;
            margin-bottom: 2rem;
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
        
        .pet-info-item i {
            color: var(--primary-color);
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
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            border: none;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.4);
        }
        
        .btn-outline-primary {
            border-color: var(--primary-color);
            color: var(--primary-color);
        }
        
        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            transform: translateY(-2px);
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
        
        .empty-state h4 {
            color: #6b7280;
            margin-bottom: 0.5rem;
        }
        
        .empty-state p {
            color: #9ca3af;
            margin-bottom: 1.5rem;
        }
        
        footer {
            margin-top: 4rem;
        }
        
        .form-label {
            font-weight: 500;
            color: #374151;
            margin-bottom: 0.5rem;
        }
        
        .form-select {
            border-radius: 8px;
            border: 1px solid #d1d5db;
            padding: 0.625rem 1rem;
        }
        
        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }
        
        @media (max-width: 768px) {
            .section {
                padding: 30px 0;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
            
            .filter-card {
                padding: 1rem;
            }
            
            .pet-card img {
                height: 180px;
            }
        }
        
        .badge-type {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 500;
            background-color: #eef2ff;
            color: var(--primary-color);
        }
    </style>
</head>
<body>
<!-- 导航栏（和首页一致） -->
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/pet/list">领养列表</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/add.jsp">提交领养信息</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- 列表区 -->
<section class="section">
    <div class="container">
        <!-- 页面标题和操作按钮 -->
        <div class="page-header d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-3">
            <div>
                <h1 class="page-title">
                    <i class="bi bi-heart-fill text-danger me-2" style="font-size: 1.5rem;"></i>
                    可领养宠物列表
                </h1>
                <p class="text-muted mb-0 mt-2">
                    <c:choose>
                        <c:when test="${not empty petList}">
                            共找到 <strong>${petList.size()}</strong> 只可爱的毛孩子等待领养
                        </c:when>
                        <c:otherwise>
                            暂无待领养的宠物
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            <a href="${pageContext.request.contextPath}/add.jsp" class="btn btn-primary btn-action">
                <i class="bi bi-plus-circle me-2"></i>新增可领养宠物
            </a>
        </div>

        <!-- 筛选栏 -->
        <c:if test="${not empty petList}">
        <div class="filter-card">
            <h5 class="mb-3 fw-semibold">
                <i class="bi bi-funnel me-2"></i>筛选条件
            </h5>
            <form id="filterForm" class="row g-3" method="get" action="${pageContext.request.contextPath}/pet/list">
                <div class="col-md-3">
                    <label class="form-label">宠物类型</label>
                    <select name="type" class="form-select">
                        <option value="">全部类型</option>
                        <option value="猫" ${param.type == '猫' ? 'selected' : ''}>🐱 猫</option>
                        <option value="狗" ${param.type == '狗' ? 'selected' : ''}>🐶 狗</option>
                        <option value="其他" ${param.type == '其他' ? 'selected' : ''}>其他</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">性别</label>
                    <select name="gender" class="form-select">
                        <option value="">不限性别</option>
                        <option value="公" ${param.gender == '公' ? 'selected' : ''}>♂ 公</option>
                        <option value="母" ${param.gender == '母' ? 'selected' : ''}>♀ 母</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">年龄范围</label>
                    <select name="ageRange" class="form-select">
                        <option value="">不限年龄</option>
                        <option value="0-1" ${param.ageRange == '0-1' ? 'selected' : ''}>1岁以下</option>
                        <option value="1-3" ${param.ageRange == '1-3' ? 'selected' : ''}>1-3岁</option>
                        <option value="3+" ${param.ageRange == '3+' ? 'selected' : ''}>3岁以上</option>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end gap-2">
                    <button type="submit" class="btn btn-primary btn-action flex-grow-1">
                        <i class="bi bi-search me-2"></i>筛选
                    </button>
                    <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-clockwise"></i>
                    </a>
                </div>
            </form>
        </div>
        </c:if>

        <!-- 宠物列表卡片 -->
        <c:choose>
            <c:when test="${not empty petList}">
                <div class="row g-4">
                    <c:forEach items="${petList}" var="pet">
                        <div class="col-6 col-md-4 col-lg-3">
                            <div class="pet-card">
                                <!-- 宠物图片 -->
                                <div class="position-relative" style="overflow: hidden;">
                                    <img 
                                        src="https://picsum.photos/id/${pet.id + 100}/600/400" 
                                        class="card-img-top" 
                                        alt="${pet.name}"
                                        loading="lazy"
                                        onerror="this.src='https://via.placeholder.com/600x400/e5e7eb/9ca3af?text=暂无图片'">
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
                                    <div class="d-flex gap-2">
                                        <a href="${pageContext.request.contextPath}/pet/detail?id=${pet.id}" 
                                           class="btn btn-sm btn-outline-primary btn-action flex-grow-1">
                                            <i class="bi bi-info-circle me-1"></i>查看详情
                                        </a>
                                        <button class="btn btn-sm btn-outline-danger" 
                                                data-pet-id="${pet.id}"
                                                data-pet-name="${fn:escapeXml(pet.name)}"
                                                onclick="handleAdoptClick(this)"
                                                title="申请领养">
                                            <i class="bi bi-heart"></i>
                                        </button>
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
                    <h4>暂无可领养宠物</h4>
                    <p>目前还没有待领养的毛孩子，快来添加第一个吧！</p>
                    <a href="${pageContext.request.contextPath}/add.jsp" class="btn btn-primary btn-action">
                        <i class="bi bi-plus-circle me-2"></i>新增宠物信息
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
                <h5 class="mb-3">快速链接</h5>
                <ul class="list-unstyled">
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/" class="text-white-50 text-decoration-none">
                            <i class="bi bi-house me-2"></i>首页
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/pet/list" class="text-white-50 text-decoration-none">
                            <i class="bi bi-list-ul me-2"></i>领养列表
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/add.jsp" class="text-white-50 text-decoration-none">
                            <i class="bi bi-plus-circle me-2"></i>提交信息
                        </a>
                    </li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5 class="mb-3">联系我们</h5>
                <ul class="list-unstyled">
                    <li class="mb-2 text-white-50">
                        <i class="bi bi-phone me-2"></i>123-4567-8910
                    </li>
                    <li class="mb-2 text-white-50">
                        <i class="bi bi-envelope me-2"></i>adopt@maohaizi.com
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
    // 申请领养处理函数
    function handleAdopt(petId, petName) {
        if (confirm('您确定要申请领养 "' + petName + '" 吗？\n\n我们会在收到申请后尽快与您联系！')) {
            // 这里可以添加实际的领养申请逻辑
            // 例如：window.location.href = '${pageContext.request.contextPath}/pet/adopt?id=' + petId;
            alert('申请已提交！我们会尽快与您联系。');
        }
    }
    
    // 更安全的点击处理函数
    function handleAdoptClick(button) {
        const petId = button.getAttribute('data-pet-id');
        const petName = button.getAttribute('data-pet-name');
        handleAdopt(petId, petName);
    }
    
    // 图片加载失败处理
    document.addEventListener('DOMContentLoaded', function() {
        const images = document.querySelectorAll('.pet-card img');
        images.forEach(img => {
            img.addEventListener('error', function() {
                this.src = 'https://via.placeholder.com/600x400/e5e7eb/9ca3af?text=暂无图片';
                this.onerror = null; // 防止无限循环
            });
        });
    });
    
    // 平滑滚动
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
</script>
</body>
</html>