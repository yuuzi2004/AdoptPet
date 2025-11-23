<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>毛孩子领养平台 - 用爱终止流浪</title>
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
            --warning-color: #ffd3a5;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            overflow-x: hidden;
        }
        
        /* 导航栏样式 */
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%) !important;
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
        }
        
        .nav-link {
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .nav-link:hover {
            color: #fbbf24 !important;
            transform: translateY(-2px);
        }
        
        /* 英雄区域（Hero Section） */
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 120px 0 80px;
            position: relative;
            overflow: hidden;
        }
        
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><circle cx="50" cy="50" r="2" fill="rgba(255,255,255,0.1)"/></svg>');
            opacity: 0.3;
        }
        
        .hero-content {
            position: relative;
            z-index: 1;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }
        
        .hero-subtitle {
            font-size: 1.25rem;
            margin-bottom: 2rem;
            opacity: 0.95;
        }
        
        .hero-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .btn-hero {
            padding: 0.875rem 2rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s ease;
            border: none;
        }
        
        .btn-hero-primary {
            background: white;
            color: var(--primary-color);
        }
        
        .btn-hero-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255,255,255,0.3);
        }
        
        .btn-hero-outline {
            background: transparent;
            color: white;
            border: 2px solid white;
        }
        
        .btn-hero-outline:hover {
            background: white;
            color: var(--primary-color);
            transform: translateY(-3px);
        }
        
        /* 功能卡片区域 */
        .features-section {
            padding: 80px 0;
            background: #f8f9fa;
        }
        
        .section-title {
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 1rem;
            color: #1e293b;
        }
        
        .section-subtitle {
            text-align: center;
            color: #64748b;
            font-size: 1.1rem;
            margin-bottom: 4rem;
        }
        
        .feature-card {
            background: white;
            border-radius: 20px;
            padding: 2.5rem;
            text-align: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            height: 100%;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }
        
        .feature-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 20px;
            font-size: 2.5rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
        }
        
        .feature-card:nth-child(2) .feature-icon {
            background: linear-gradient(135deg, var(--success-color), #059669);
        }
        
        .feature-card:nth-child(3) .feature-icon {
            background: linear-gradient(135deg, var(--warning-color), #d97706);
        }
        
        .feature-card:nth-child(4) .feature-icon {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
        }
        
        .feature-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: #1e293b;
        }
        
        .feature-description {
            color: #64748b;
            line-height: 1.8;
        }
        
        /* 热门宠物区域 */
        .pets-section {
            padding: 80px 0;
            background: white;
        }
        
        .pet-card {
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border: none;
            height: 100%;
        }
        
        .pet-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }
        
        .pet-card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        
        .pet-card:hover img {
            transform: scale(1.1);
        }
        
        .pet-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255,255,255,0.95);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--primary-color);
        }
        
        /* 统计区域 */
        .stats-section {
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            color: white;
            padding: 60px 0;
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-number {
            font-size: 3rem;
            font-weight: 800;
            color: #fbbf24;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        /* 页脚 */
        footer {
            background: #1e293b;
            color: white;
            padding: 60px 0 30px;
        }
        
        .footer-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
        }
        
        .footer-link {
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-block;
            margin-bottom: 0.75rem;
        }
        
        .footer-link:hover {
            color: #fbbf24;
            transform: translateX(5px);
        }
        
        /* 响应式设计 */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .hero-subtitle {
                font-size: 1rem;
            }
            
            .section-title {
                font-size: 2rem;
            }
            
            .feature-card {
                margin-bottom: 2rem;
            }
        }
        
        /* 动画效果 */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .fade-in-up {
            animation: fadeInUp 0.6s ease-out;
        }
    </style>
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="bi bi-paw-fill me-2"></i>毛孩子领养平台
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/">首页</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/pet/list">领养列表</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/add.jsp">发布信息</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/search.jsp">寻找宠物</a>
                    </li>
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
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">
                                    <i class="bi bi-person-circle me-1"></i>登录
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/login.jsp">
                            <i class="bi bi-shield-lock me-1"></i>管理员
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- 英雄区域 -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 hero-content fade-in-up">
                    <h1 class="hero-title">用爱终止流浪<br>让每个生命都有归宿</h1>
                    <p class="hero-subtitle">
                        我们致力于为流浪动物找到温暖的家，为有爱心的您提供便捷的领养平台。
                        每一个毛孩子都值得被温柔以待。
                    </p>
                    <div class="hero-buttons">
                        <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-hero btn-hero-primary">
                            <i class="bi bi-heart-fill me-2"></i>立即领养
                        </a>
                        <a href="${pageContext.request.contextPath}/add.jsp" class="btn btn-hero btn-hero-outline">
                            <i class="bi bi-plus-circle me-2"></i>发布信息
                        </a>
                    </div>
                </div>
                <div class="col-lg-6 text-center fade-in-up" style="animation-delay: 0.2s;">
                    <img src="https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=800" 
                         alt="宠物领养" 
                         class="img-fluid rounded-4 shadow-lg"
                         style="max-height: 500px; object-fit: cover;">
                </div>
            </div>
        </div>
    </section>

    <!-- 功能特色区域 -->
    <section class="features-section">
        <div class="container">
            <h2 class="section-title">平台功能</h2>
            <p class="section-subtitle">一站式宠物领养服务平台，让领养更简单</p>
            <div class="row g-4">
                <div class="col-md-6 col-lg-3">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="bi bi-heart-pulse"></i>
                        </div>
                        <h3 class="feature-title">宠物领养</h3>
                        <p class="feature-description">
                            浏览待领养的可爱毛孩子，找到您心仪的宠物伙伴，开启美好的领养之旅。
                        </p>
                        <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-outline-primary mt-3">
                            查看列表 <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="bi bi-file-earmark-plus"></i>
                        </div>
                        <h3 class="feature-title">发布信息</h3>
                        <p class="feature-description">
                            为需要帮助的流浪动物发布领养信息，让更多爱心人士看到并伸出援手。
                        </p>
                        <a href="${pageContext.request.contextPath}/add.jsp" class="btn btn-outline-success mt-3">
                            立即发布 <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="bi bi-search"></i>
                        </div>
                        <h3 class="feature-title">寻找宠物</h3>
                        <p class="feature-description">
                            丢失了心爱的宠物？发布寻宠信息，让更多人帮助您找回走失的毛孩子。
                        </p>
                        <a href="${pageContext.request.contextPath}/search.jsp" class="btn btn-outline-warning mt-3">
                            开始寻找 <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="bi bi-people"></i>
                        </div>
                        <h3 class="feature-title">社区互动</h3>
                        <p class="feature-description">
                            加入我们的爱心社区，分享领养故事，交流养宠经验，传递温暖与关爱。
                        </p>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-danger mt-3">
                            加入我们 <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 热门宠物区域 -->
    <section class="pets-section">
        <div class="container">
            <h2 class="section-title">待领养宠物</h2>
            <p class="section-subtitle">这些可爱的毛孩子正在等待一个温暖的家</p>
            <div class="row g-4">
                <c:choose>
                    <c:when test="${not empty petList}">
                        <c:forEach items="${petList}" var="pet" begin="0" end="3">
                            <div class="col-md-6 col-lg-3">
                                <div class="card pet-card">
                                    <div class="position-relative">
                                        <img src="https://picsum.photos/id/${pet.id + 100}/600/400" 
                                             class="card-img-top" 
                                             alt="${pet.name}"
                                             loading="lazy">
                                        <span class="pet-badge">${pet.type}</span>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <i class="bi bi-heart-fill text-danger me-1"></i>${pet.name}
                                        </h5>
                                        <p class="card-text text-muted small mb-2">
                                            <i class="bi bi-calendar-check me-1"></i>${pet.age}岁 · 
                                            <i class="bi bi-venus-mars me-1"></i>${pet.gender}
                                        </p>
                                        <p class="card-text text-truncate">${pet.description}</p>
                                    </div>
                                    <div class="card-footer bg-transparent">
                                        <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-primary w-100">
                                            <i class="bi bi-heart me-1"></i>查看详情
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12 text-center py-5">
                            <i class="bi bi-inbox" style="font-size: 4rem; color: #d1d5db;"></i>
                            <p class="text-muted mt-3">暂无待领养的宠物</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-lg btn-primary">
                    查看更多 <i class="bi bi-arrow-right ms-2"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- 统计区域 -->
    <section class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-6 mb-4">
                    <div class="stat-item">
                        <div class="stat-number">500+</div>
                        <div class="stat-label">成功领养</div>
                    </div>
                </div>
                <div class="col-md-3 col-6 mb-4">
                    <div class="stat-item">
                        <div class="stat-number">200+</div>
                        <div class="stat-label">待领养宠物</div>
                    </div>
                </div>
                <div class="col-md-3 col-6 mb-4">
                    <div class="stat-item">
                        <div class="stat-number">1000+</div>
                        <div class="stat-label">注册用户</div>
                    </div>
                </div>
                <div class="col-md-3 col-6 mb-4">
                    <div class="stat-item">
                        <div class="stat-number">98%</div>
                        <div class="stat-label">满意度</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 页脚 -->
    <footer>
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4">
                    <h5 class="footer-title">
                        <i class="bi bi-paw-fill me-2"></i>毛孩子领养平台
                    </h5>
                    <p style="color: rgba(255,255,255,0.7);">
                        用爱终止流浪，让每个生命都有归宿。我们致力于为流浪动物找到温暖的家。
                    </p>
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
                            <i class="bi bi-phone me-2"></i>123-4567-8910
                        </li>
                        <li style="color: rgba(255,255,255,0.7); margin-bottom: 0.75rem;">
                            <i class="bi bi-envelope me-2"></i>adopt@maohaizi.com
                        </li>
                        <li style="color: rgba(255,255,255,0.7);">
                            <i class="bi bi-geo-alt me-2"></i>北京市朝阳区爱心路123号
                        </li>
                    </ul>
                </div>
            </div>
            <div class="border-top border-secondary mt-5 pt-4 text-center" style="color: rgba(255,255,255,0.6);">
                <p class="mb-0">© 2025 毛孩子领养平台 版权所有 | 用爱心点亮每一个生命</p>
            </div>
        </div>
    </footer>

    <!-- 引入 Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 页面加载动画
        document.addEventListener('DOMContentLoaded', function() {
            const elements = document.querySelectorAll('.fade-in-up');
            elements.forEach((el, index) => {
                setTimeout(() => {
                    el.style.opacity = '0';
                    el.style.animation = 'fadeInUp 0.6s ease-out forwards';
                }, index * 100);
            });
        });
    </script>
</body>
</html>
