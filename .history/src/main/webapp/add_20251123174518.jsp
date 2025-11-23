<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增可领养宠物 - 毛孩子领养平台</title>
    <!-- 引入 Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入图标库 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #6366f1;
            --secondary-color: #8b5cf6;
            --success-color: #10b981;
            --danger-color: #ef4444;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }
        
        .section {
            padding: 60px 0;
            min-height: calc(100vh - 200px);
        }
        
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .form-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            border: none;
        }
        
        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 2rem;
        }
        
        .card-header h4 {
            margin: 0;
            font-weight: 700;
            font-size: 1.5rem;
        }
        
        .card-body {
            padding: 2.5rem;
        }
        
        .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .form-label i {
            color: var(--primary-color);
        }
        
        .form-control, .form-select {
            border-radius: 12px;
            padding: 0.875rem 1.25rem;
            border: 2px solid #e5e7eb;
            transition: all 0.3s ease;
            font-size: 1rem;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            outline: none;
        }
        
        .form-control.is-invalid {
            border-color: var(--danger-color);
        }
        
        .form-control.is-valid {
            border-color: var(--success-color);
        }
        
        .invalid-feedback {
            display: block;
            color: var(--danger-color);
            font-size: 0.875rem;
            margin-top: 0.5rem;
        }
        
        .form-check {
            padding: 0.75rem 1rem;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .form-check:hover {
            border-color: var(--primary-color);
            background-color: #f8f9ff;
        }
        
        .form-check-input:checked ~ .form-check-label {
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .form-check-input {
            margin-top: 0.5rem;
            cursor: pointer;
        }
        
        .form-check-label {
            cursor: pointer;
            margin-left: 0.5rem;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 12px;
            padding: 0.875rem 2rem;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.4);
        }
        
        .btn-submit:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }
        
        .info-box {
            background: linear-gradient(135deg, #eef2ff, #f0f9ff);
            border-left: 4px solid var(--primary-color);
            border-radius: 10px;
            padding: 1.25rem;
            margin-bottom: 2rem;
        }
        
        .info-box h6 {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 0.75rem;
        }
        
        .info-box ul {
            margin-bottom: 0;
            padding-left: 1.5rem;
        }
        
        .info-box li {
            color: #6b7280;
            margin-bottom: 0.5rem;
        }
        
        .char-count {
            text-align: right;
            font-size: 0.875rem;
            color: #9ca3af;
            margin-top: 0.5rem;
        }
        
        .char-count.warning {
            color: #f59e0b;
        }
        
        .char-count.danger {
            color: var(--danger-color);
        }
        
        .step-indicator {
            display: flex;
            justify-content: space-between;
            margin-bottom: 2rem;
            padding: 1rem;
            background: #f9fafb;
            border-radius: 12px;
        }
        
        .step {
            flex: 1;
            text-align: center;
            position: relative;
        }
        
        .step::after {
            content: '';
            position: absolute;
            top: 20px;
            left: 60%;
            width: 80%;
            height: 2px;
            background: #e5e7eb;
            z-index: 0;
        }
        
        .step:last-child::after {
            display: none;
        }
        
        .step-number {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e5e7eb;
            color: #9ca3af;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 0.5rem;
            font-weight: 700;
            position: relative;
            z-index: 1;
        }
        
        .step.active .step-number {
            background: var(--primary-color);
            color: white;
        }
        
        .step-label {
            font-size: 0.875rem;
            color: #6b7280;
        }
        
        .step.active .step-label {
            color: var(--primary-color);
            font-weight: 600;
        }
        
        @media (max-width: 768px) {
            .card-body {
                padding: 1.5rem;
            }
            
            .step-indicator {
                display: none;
            }
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/pet/list">领养列表</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/add.jsp">提交领养信息</a></li>
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
<section class="section bg-light">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card form-card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0"><i class="bi bi-plus-circle me-2"></i>新增可领养宠物</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty sessionScope.userId}">
                            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-triangle me-2"></i>
                                <strong>提示：</strong>您需要先<a href="${pageContext.request.contextPath}/login.jsp?redirect=${pageContext.request.contextPath}/add.jsp" class="alert-link fw-bold">登录</a>才能提交领养信息。
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-x-circle me-2"></i>${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="bi bi-check-circle me-2"></i>${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        
                        <!-- 步骤指示器 -->
                        <div class="step-indicator">
                            <div class="step active">
                                <div class="step-number">1</div>
                                <div class="step-label">基本信息</div>
                            </div>
                            <div class="step">
                                <div class="step-number">2</div>
                                <div class="step-label">详细信息</div>
                            </div>
                            <div class="step">
                                <div class="step-number">3</div>
                                <div class="step-label">提交审核</div>
                            </div>
                        </div>
                        
                        <!-- 提示信息 -->
                        <div class="info-box">
                            <h6><i class="bi bi-info-circle me-2"></i>提交须知</h6>
                            <ul>
                                <li>请确保填写的信息真实有效，以便有意向的领养者联系</li>
                                <li>详细描述有助于提高宠物被领养的成功率</li>
                                <li>提交后信息将经过审核，审核通过后会在平台上展示</li>
                                <li>如有疑问，请联系平台客服</li>
                            </ul>
                        </div>
                        
                        <!-- 表单：提交到 PetAddServlet（/pet/add） -->
                        <form action="${pageContext.request.contextPath}/pet/add" method="post" id="petForm" novalidate>
                            <div class="row g-3">
                                <!-- 宠物名称 -->
                                <div class="col-12">
                                    <label for="name" class="form-label">宠物名称 <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="name" name="name" required placeholder="请输入宠物的名字">
                                </div>
                                <!-- 宠物类型 -->
                                <div class="col-md-6">
                                    <label for="type" class="form-label">宠物类型 <span class="text-danger">*</span></label>
                                    <select class="form-select" id="type" name="type" required>
                                        <option value="">请选择类型</option>
                                        <option value="猫">猫</option>
                                        <option value="狗">狗</option>
                                        <option value="兔子">兔子</option>
                                        <option value="仓鼠">仓鼠</option>
                                        <option value="其他">其他</option>
                                    </select>
                                </div>
                                <!-- 宠物年龄 -->
                                <div class="col-md-6">
                                    <label for="age" class="form-label">宠物年龄 <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="age" name="age" required min="0" placeholder="请输入整数（单位：岁）">
                                </div>
                                <!-- 宠物性别 -->
                                <div class="col-md-6">
                                    <label class="form-label">宠物性别 <span class="text-danger">*</span></label>
                                    <div class="d-flex gap-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="gender" id="male" value="公" checked>
                                            <label class="form-check-label" for="male">公</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="gender" id="female" value="母">
                                            <label class="form-check-label" for="female">母</label>
                                        </div>
                                    </div>
                                </div>
                                <!-- 疫苗情况 -->
                                <div class="col-md-6">
                                    <label class="form-label">是否疫苗 <span class="text-danger">*</span></label>
                                    <div class="d-flex gap-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="vaccine" id="vaccineYes" value="是" checked>
                                            <label class="form-check-label" for="vaccineYes">是</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="vaccine" id="vaccineNo" value="否">
                                            <label class="form-check-label" for="vaccineNo">否</label>
                                        </div>
                                    </div>
                                </div>
                                <!-- 宠物描述 -->
                                <div class="col-12">
                                    <label for="description" class="form-label">宠物描述 <span class="text-danger">*</span></label>
                                    <textarea class="form-control" id="description" name="description" rows="4" required placeholder="请描述宠物的性格、健康状况、习惯等（至少20字）"></textarea>
                                </div>
                                <!-- 提交按钮区 -->
                                <div class="col-12 d-flex gap-3">
                                    <button type="submit" class="btn btn-primary w-50">
                                        <i class="bi bi-check-circle me-2"></i>提交信息
                                    </button>
                                    <button type="reset" class="btn btn-outline-secondary w-25">
                                        <i class="bi bi-arrow-counterclockwise me-2"></i>重置
                                    </button>
                                    <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-outline-danger w-25">
                                        <i class="bi bi-arrow-left me-2"></i>返回列表
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 页脚（和首页一致） -->
<footer class="bg-dark text-white py-6">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4">
                <h5 class="mb-3"><i class="bi bi-paw-fill me-2"></i>毛孩子领养平台</h5>
                <p>用爱终止流浪，让每个生命都有归宿</p>
            </div>
            <div class="col-md-4 mb-4">
                <h5 class="mb-3">快速链接</h5>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/" class="text-white/80 text-decoration-none">首页</a></li>
                    <li><a href="${pageContext.request.contextPath}/pet/list" class="text-white/80 text-decoration-none">领养列表</a></li>
                    <li><a href="${pageContext.request.contextPath}/add.jsp" class="text-white/80 text-decoration-none">提交信息</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5 class="mb-3">联系我们</h5>
                <ul class="list-unstyled">
                    <li><i class="bi bi-phone me-2"></i>123-4567-8910</li>
                    <li><i class="bi bi-envelope me-2"></i>adopt@maohaizi.com</li>
                </ul>
            </div>
        </div>
        <div class="border-top border-white/20 mt-4 pt-4 text-center text-white/60">
            © 2025 毛孩子领养平台 版权所有
        </div>
    </div>
</footer>

<!-- 引入 Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>