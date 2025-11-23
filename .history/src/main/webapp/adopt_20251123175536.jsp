<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>申请领养 - 毛孩子领养平台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root {
            /* 薄巧色（薄荷绿）马卡龙配色 */
            --primary-color: #a8e6cf; /* 薄荷绿 */
            --secondary-color: #ffd3d3; /* 粉红 */
            --accent-color: #c7ecee; /* 淡蓝 */
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background-color: #f8f9fa;
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
        
        .form-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            overflow: hidden;
        }
        
        .pet-info-card {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 50%, var(--secondary-color) 100%);
            color: #2d5016;
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        
        .pet-info-card h4 {
            margin-bottom: 1rem;
        }
        
        .pet-info-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
        }
        
        .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.75rem;
        }
        
        .form-control, .form-select {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            border: 2px solid #e5e7eb;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }
        
        .btn-submit {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 10px;
            padding: 0.875rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(99, 102, 241, 0.4);
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/add.jsp">提交领养信息</a></li>
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

<!-- 表单区 -->
<section class="section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty pet}">
                    <!-- 宠物信息卡片 -->
                    <div class="pet-info-card">
                        <h4><i class="bi bi-heart-fill me-2"></i>您要申请领养的宠物</h4>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="pet-info-item">
                                    <i class="bi bi-tag"></i>
                                    <span><strong>名称：</strong>${pet.name}</span>
                                </div>
                                <div class="pet-info-item">
                                    <i class="bi bi-grid"></i>
                                    <span><strong>类型：</strong>${pet.type}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="pet-info-item">
                                    <i class="bi bi-calendar-check"></i>
                                    <span><strong>年龄：</strong>${pet.age}岁</span>
                                </div>
                                <div class="pet-info-item">
                                    <i class="bi bi-venus-mars"></i>
                                    <span><strong>性别：</strong>${pet.gender}</span>
                                </div>
                            </div>
                        </div>
                        <div class="mt-3">
                            <strong>描述：</strong>${pet.description}
                        </div>
                    </div>
                </c:if>
                
                <!-- 申请表单 -->
                <div class="card form-card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0"><i class="bi bi-file-earmark-text me-2"></i>填写领养申请</h4>
                    </div>
                    <div class="card-body p-5">
                        <form action="${pageContext.request.contextPath}/pet/adopt/form" method="post" id="adoptForm">
                            <input type="hidden" name="petId" value="${pet.id}">
                            
                            <div class="mb-4">
                                <label for="reason" class="form-label">
                                    申请理由 <span class="text-danger">*</span>
                                </label>
                                <textarea class="form-control" 
                                          id="reason" 
                                          name="reason" 
                                          rows="5" 
                                          required 
                                          placeholder="请详细说明您申请领养该宠物的理由，包括您的家庭情况、养宠经验、对宠物的承诺等（至少50字）"></textarea>
                                <small class="form-text text-muted">请认真填写，这将帮助我们更好地审核您的申请</small>
                            </div>
                            
                            <div class="mb-4">
                                <label for="contact" class="form-label">
                                    联系方式 <span class="text-danger">*</span>
                                </label>
                                <input type="text" 
                                       class="form-control" 
                                       id="contact" 
                                       name="contact" 
                                       required 
                                       placeholder="请输入您的手机号码或微信号，方便我们与您联系">
                                <small class="form-text text-muted">请确保联系方式准确，我们会在3个工作日内与您联系</small>
                            </div>
                            
                            <div class="alert alert-info">
                                <i class="bi bi-info-circle me-2"></i>
                                <strong>温馨提示：</strong>
                                <ul class="mb-0 mt-2">
                                    <li>提交申请后，我们会在3个工作日内审核并与您联系</li>
                                    <li>请确保您有足够的时间和精力照顾宠物</li>
                                    <li>领养后请善待宠物，不要随意遗弃</li>
                                </ul>
                            </div>
                            
                            <div class="d-flex gap-3 mt-4">
                                <button type="submit" class="btn btn-primary btn-submit flex-grow-1">
                                    <i class="bi bi-check-circle me-2"></i>提交申请
                                </button>
                                <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left me-2"></i>返回列表
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 页脚 -->
<footer class="bg-dark text-white py-5 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <p class="mb-0">© 2025 毛孩子领养平台 版权所有 | 用爱心点亮每一个生命</p>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 表单验证
    document.getElementById('adoptForm').addEventListener('submit', function(e) {
        const reason = document.getElementById('reason').value.trim();
        const contact = document.getElementById('contact').value.trim();
        
        if (reason.length < 50) {
            e.preventDefault();
            alert('申请理由至少需要50字，请详细说明您的领养理由！');
            return false;
        }
        
        if (contact.length < 5) {
            e.preventDefault();
            alert('请输入有效的联系方式！');
            return false;
        }
    });
</script>
</body>
</html>

