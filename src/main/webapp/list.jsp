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
            /* 薄巧色（薄荷绿）马卡龙配色 */
            --primary-color: #a8e6cf; /* 薄荷绿 */
            --secondary-color: #ffd3d3; /* 粉红 */
            --accent-color: #c7ecee; /* 淡蓝 */
            --purple-color: #e8d5ff; /* 淡紫 */
            --yellow-color: #fff9c4; /* 淡黄 */
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

        .btn-outline-primary {
            border-color: var(--primary-color);
            color: #2d5016;
        }

        .btn-outline-primary:hover {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            border-color: var(--primary-color);
            transform: translateY(-2px);
            color: #1a3009;
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
            background-color: rgba(168, 230, 207, 0.3);
            color: #2d5016;
        }

        /* 爱心按钮样式 */
        .btn-adopt-heart {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: linear-gradient(135deg, #ffaaa5 0%, #ffd3d3 100%);
            border: 2px solid #ffaaa5;
            color: white;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 2px 8px rgba(255, 170, 165, 0.3);
            position: relative;
            overflow: hidden;
        }

        .btn-adopt-heart::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .btn-adopt-heart:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-adopt-heart:hover {
            transform: translateY(-3px) scale(1.1);
            box-shadow: 0 6px 20px rgba(255, 170, 165, 0.5);
            background: linear-gradient(135deg, #ff6b6b 0%, #ffaaa5 100%);
            border-color: #ff6b6b;
        }

        .btn-adopt-heart:active {
            transform: translateY(-1px) scale(1.05);
        }

        .btn-adopt-heart i {
            font-size: 1.2rem;
            position: relative;
            z-index: 1;
            transition: all 0.3s ease;
        }

        .btn-adopt-heart:hover i {
            transform: scale(1.2);
            animation: heartbeat 0.6s ease-in-out;
        }

        @keyframes heartbeat {
            0%, 100% { transform: scale(1.2); }
            50% { transform: scale(1.4); }
        }

        .btn-adopt-heart .bi-heart {
            color: #ffaaa5;
        }

        .btn-adopt-heart:hover .bi-heart {
            color: white;
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
                        <select name="ageRange" class="form-select" onchange="setAgeParams(this)">
                            <option value="">不限年龄</option>
                            <option value="0-1" ${param.ageRange == '0-1' ? 'selected' : ''}>1岁以下</option>
                            <option value="1-3" ${param.ageRange == '1-3' ? 'selected' : ''}>1-3岁</option>
                            <option value="3+" ${param.ageRange == '3+' ? 'selected' : ''}>3岁以上</option>
                        </select>
                        <!-- 隐藏域：传递minAge和maxAge给后端 -->
                        <input type="hidden" id="minAge" name="minAge" value="${param.minAge}">
                        <input type="hidden" id="maxAge" name="maxAge" value="${param.maxAge}">
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
                                    <div class="pet-info" style="margin: 10px 0; padding: 8px; background-color: #f8f9fa; border-radius: 8px;">
    <span class="pet-info-item" style="margin-right: 15px; font-weight: 500;">
        <i class="bi bi-calendar-check text-primary"></i>
        年龄：${pet.age}岁
    </span>
                                        <span class="pet-info-item" style="font-weight: 500;">
        <i class="bi bi-venus-mars text-primary"></i>
        性别：${pet.gender}
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
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.userId}">
                                                <a href="${pageContext.request.contextPath}/pet/adopt/form?petId=${pet.id}"
                                                   class="btn-adopt-heart"
                                                   title="申请领养">
                                                    <i class="bi bi-heart-fill"></i>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/login.jsp?redirect=${pageContext.request.contextPath}/pet/adopt/form?petId=${pet.id}"
                                                   class="btn-adopt-heart"
                                                   title="申请领养（需登录）">
                                                    <i class="bi bi-heart"></i>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
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
    // 年龄范围选择：自动设置minAge和maxAge隐藏域的值
    function setAgeParams(select) {
        const minAgeInput = document.getElementById('minAge');
        const maxAgeInput = document.getElementById('maxAge');

        switch(select.value) {
            case '0-1':
                minAgeInput.value = 0;
                maxAgeInput.value = 1;
                break;
            case '1-3':
                minAgeInput.value = 1;
                maxAgeInput.value = 3;
                break;
            case '3+':
                minAgeInput.value = 3;
                maxAgeInput.value = 99; // 设为超大值代表3岁以上
                break;
            default:
                minAgeInput.value = '';
                maxAgeInput.value = '';
                break;
        }
    }

    // 页面加载时初始化年龄隐藏域（回显筛选状态）
    document.addEventListener('DOMContentLoaded', function() {
        const ageRangeSelect = document.querySelector('select[name="ageRange"]');
        if (ageRangeSelect && ageRangeSelect.value) {
            setAgeParams(ageRangeSelect);
        }

        // 图片加载失败处理
        const images = document.querySelectorAll('.pet-card img');
        images.forEach(img => {
            img.addEventListener('error', function() {
                this.src = 'https://via.placeholder.com/600x400/e5e7eb/9ca3af?text=暂无图片';
                this.onerror = null; // 防止无限循环
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
    });
</script>
</body>
</html>