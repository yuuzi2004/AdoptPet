<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pet.name} - 详情页 - 毛孩子领养平台</title>
    <!-- 引入 Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入图标库 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root {
            /* 你的原有薄巧色马卡龙配色 */
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

        .detail-container {
            padding: 60px 0;
            min-height: calc(100vh - 200px);
        }

        .detail-card {
            background: white;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }

        .pet-image-wrapper {
            height: 400px;
            overflow: hidden;
            position: relative;
        }

        .pet-image-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .pet-image-wrapper:hover img {
            transform: scale(1.05);
        }

        .pet-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 12px;
            padding: 8px 16px;
            font-weight: 600;
            color: #2d5016;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .pet-info-section {
            padding: 2rem;
        }

        .pet-name {
            font-size: 2rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 1rem;
        }

        .pet-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1.5rem;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1.1rem;
            color: #6b7280;
        }

        .meta-item i {
            color: var(--primary-color);
            font-size: 1.2rem;
        }

        .pet-description {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #374151;
            margin-bottom: 2rem;
        }

        .btn-action {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
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

        footer {
            margin-top: 4rem;
        }

        @media (max-width: 768px) {
            .detail-container {
                padding: 30px 0;
            }

            .pet-image-wrapper {
                height: 280px;
            }

            .pet-name {
                font-size: 1.5rem;
            }

            .pet-info-section {
                padding: 1.5rem;
            }
        }

        /* 爱心按钮样式（和列表页一致） */
        .btn-adopt-heart {
            width: 48px;
            height: 48px;
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

        .btn-adopt-heart i {
            font-size: 1.5rem;
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
    </style>
</head>
<body>
<!-- 导航栏（和列表页完全一致） -->
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

<!-- 宠物详情区 -->
<section class="detail-container">
    <div class="container">
        <!-- 错误提示（如果宠物不存在） -->
        <c:if test="${empty pet}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-circle me-2"></i>未找到该宠物的信息，请返回列表页重新选择
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-primary btn-action">
                    <i class="bi bi-arrow-left me-2"></i>返回领养列表
                </a>
            </div>
        </c:if>

        <!-- 宠物详情卡片 -->
        <c:if test="${not empty pet}">
            <div class="detail-card">
                <div class="row g-0">
                    <!-- 宠物图片列 -->
                    <div class="col-md-6 pet-image-wrapper">
                        <c:choose>
                            <c:when test="${not empty pet.imagePath}">
                                <c:choose>
                                    <c:when test="${fn:startsWith(pet.imagePath, 'uploads/')}">
                                        <img src="${pageContext.request.contextPath}/uploads/${fn:substringAfter(pet.imagePath, 'uploads/')}"
                                             alt="${pet.name}"
                                             onerror="this.src='https://via.placeholder.com/800x600/a8e6cf/2d5016?text=暂无图片'">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/${pet.imagePath}"
                                             alt="${pet.name}"
                                             onerror="this.src='https://via.placeholder.com/800x600/a8e6cf/2d5016?text=暂无图片'">
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <img src="https://via.placeholder.com/800x600/a8e6cf/2d5016?text=暂无图片"
                                     alt="${pet.name}">
                            </c:otherwise>
                        </c:choose>
                        <span class="pet-badge">${pet.type}</span>
                    </div>

                    <!-- 宠物信息列 -->
                    <div class="col-md-6 pet-info-section">
                        <h1 class="pet-name">
                            <i class="bi bi-heart-fill text-danger me-2"></i>${pet.name}
                        </h1>

                        <div class="pet-meta">
                            <div class="meta-item">
                                <i class="bi bi-calendar-check"></i>
                                <span>${pet.age}岁</span>
                            </div>
                            <div class="meta-item">
                                <i class="bi bi-venus-mars"></i>
                                <span>${pet.gender}</span>
                            </div>
                        </div>

                        <div class="pet-description">
                            <h5 class="mb-2 text-muted"><i class="bi bi-book me-2"></i>宠物介绍：</h5>
                            <p>${pet.description}</p>
                        </div>

                        <!-- 操作按钮 -->
                        <div class="d-flex gap-3 align-items-center">
                            <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-outline-primary btn-action">
                                <i class="bi bi-arrow-left me-2"></i>返回列表
                            </a>

                            <c:choose>
                                <c:when test="${not empty sessionScope.userId}">
                                    <a href="${pageContext.request.contextPath}/pet/adopt/form?petId=${pet.id}"
                                       class="btn-adopt-heart"
                                       title="申请领养${pet.name}">
                                        <i class="bi bi-heart-fill"></i>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/login.jsp?redirect=${pageContext.request.contextPath}/pet/adopt/form?petId=${pet.id}"
                                       class="btn-adopt-heart"
                                       title="登录后申请领养${pet.name}">
                                        <i class="bi bi-heart"></i>
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</section>

<!-- 页脚（和列表页完全一致） -->
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
    // 图片加载失败处理
    document.addEventListener('DOMContentLoaded', function() {
        const petImg = document.querySelector('.pet-image-wrapper img');
        if (petImg) {
            petImg.addEventListener('error', function() {
                this.src = 'https://via.placeholder.com/800x600/e5e7eb/9ca3af?text=暂无图片';
                this.onerror = null;
            });
        }
    });
</script>
</body>
</html>