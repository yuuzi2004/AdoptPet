<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发布信息 - 毛孩子领养平台</title>
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
            --info-color: #c7ecee;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: linear-gradient(135deg, #e8f5e9 0%, #f1f8e9 50%, #fff9c4 100%);
            min-height: 100vh;
        }
        
        .section {
            padding: 60px 0;
            min-height: calc(100vh - 200px);
        }
        
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
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
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            border: none;
        }
        
        .card-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 50%, var(--secondary-color) 100%);
            border: none;
            padding: 2rem;
            color: #2d5016;
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
            box-shadow: 0 0 0 4px rgba(168, 230, 207, 0.3);
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
            background-color: rgba(168, 230, 207, 0.2);
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
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 50%, var(--secondary-color) 100%);
            border: none;
            border-radius: 12px;
            padding: 0.875rem 2rem;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(168, 230, 207, 0.4);
            color: #2d5016;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(168, 230, 207, 0.6);
            color: #1a3009;
        }
        
        .btn-submit:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }
        
        .info-box {
            background: linear-gradient(135deg, rgba(168, 230, 207, 0.2), rgba(199, 236, 238, 0.2));
            border-left: 4px solid var(--primary-color);
            border-radius: 10px;
            padding: 1.25rem;
            margin-bottom: 2rem;
        }
        
        .info-box h6 {
            color: #2d5016;
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
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: #2d5016;
            font-weight: 700;
        }
        
        .step-label {
            font-size: 0.875rem;
            color: #6b7280;
        }
        
        .step.active .step-label {
            color: #2d5016;
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/add.jsp">发布信息</a></li>
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

<!-- 表单区 -->
<section class="section bg-light">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card form-card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0"><i class="bi bi-plus-circle me-2"></i>发布信息</h4>
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
                        <form action="${pageContext.request.contextPath}/pet/add" method="post" id="petForm" enctype="multipart/form-data" novalidate>
                            <div class="row g-4">
                                <!-- 基本信息区域 -->
                                <div class="col-12">
                                    <h5 class="mb-4" style="color: #2d5016;">
                                        <i class="bi bi-card-heading me-2"></i>基本信息
                                    </h5>
                                </div>
                                
                                <!-- 宠物图片上传 -->
                                <div class="col-12">
                                    <label class="form-label">
                                        <i class="bi bi-image"></i>
                                        宠物图片 <span class="text-muted">(可选)</span>
                                    </label>
                                    <div class="mb-3">
                                        <input type="file" 
                                               class="form-control" 
                                               id="image" 
                                               name="image" 
                                               accept="image/*"
                                               onchange="previewImage(this)">
                                        <small class="form-text text-muted">支持 JPG、PNG、GIF 格式，最大 5MB</small>
                                    </div>
                                    <div id="imagePreview" class="mt-3" style="display: none;">
                                        <img id="previewImg" src="" alt="预览" style="max-width: 300px; max-height: 300px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                                    </div>
                                </div>
                                
                                <!-- 宠物名称 -->
                                <div class="col-12">
                                    <label for="name" class="form-label">
                                        <i class="bi bi-tag"></i>
                                        宠物名称 <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="name" 
                                           name="name" 
                                           required 
                                           placeholder="请输入宠物的名字，如：小白、旺财等"
                                           minlength="1"
                                           maxlength="20">
                                    <div class="invalid-feedback">请输入宠物名称（1-20个字符）</div>
                                </div>
                                
                                <!-- 宠物类型和年龄 -->
                                <div class="col-md-6">
                                    <label for="type" class="form-label">
                                        <i class="bi bi-grid"></i>
                                        宠物类型 <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" id="type" name="type" required>
                                        <option value="">请选择类型</option>
                                        <option value="猫">🐱 猫</option>
                                        <option value="狗">🐶 狗</option>
                                        <option value="兔子">🐰 兔子</option>
                                        <option value="仓鼠">🐹 仓鼠</option>
                                        <option value="鸟">🐦 鸟</option>
                                        <option value="其他">其他</option>
                                    </select>
                                    <div class="invalid-feedback">请选择宠物类型</div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="age" class="form-label">
                                        <i class="bi bi-calendar-check"></i>
                                        宠物年龄 <span class="text-danger">*</span>
                                    </label>
                                    <input type="number" 
                                           class="form-control" 
                                           id="age" 
                                           name="age" 
                                           required 
                                           min="0" 
                                           max="30"
                                           placeholder="请输入年龄（岁）">
                                    <div class="invalid-feedback">请输入有效的年龄（0-30岁）</div>
                                </div>
                                
                                <!-- 宠物性别 -->
                                <div class="col-12">
                                    <label class="form-label">
                                        <i class="bi bi-venus-mars"></i>
                                        宠物性别 <span class="text-danger">*</span>
                                    </label>
                                    <div class="d-flex gap-3">
                                        <div class="form-check flex-grow-1">
                                            <input class="form-check-input" type="radio" name="gender" id="male" value="公" checked required>
                                            <label class="form-check-label" for="male">
                                                <i class="bi bi-gender-male me-1"></i>公
                                            </label>
                                        </div>
                                        <div class="form-check flex-grow-1">
                                            <input class="form-check-input" type="radio" name="gender" id="female" value="母" required>
                                            <label class="form-check-label" for="female">
                                                <i class="bi bi-gender-female me-1"></i>母
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- 详细信息区域 -->
                                <div class="col-12 mt-4">
                                    <h5 class="mb-4" style="color: #2d5016;">
                                        <i class="bi bi-file-text me-2"></i>详细信息
                                    </h5>
                                </div>
                                
                                <!-- 宠物描述 -->
                                <div class="col-12">
                                    <label for="description" class="form-label">
                                        <i class="bi bi-card-text"></i>
                                        宠物描述 <span class="text-danger">*</span>
                                    </label>
                                    <textarea class="form-control" 
                                              id="description" 
                                              name="description" 
                                              rows="6" 
                                              required 
                                              placeholder="请详细描述宠物的性格、健康状况、生活习惯、特殊需求等信息，有助于提高被领养的成功率（至少30字）"
                                              minlength="30"
                                              maxlength="500"></textarea>
                                    <div class="char-count" id="charCount">
                                        <span id="currentCount">0</span> / 500 字
                                    </div>
                                    <div class="invalid-feedback">请至少输入30字的详细描述</div>
                                </div>
                                <!-- 提交按钮区 -->
                                <div class="col-12 mt-4 pt-4 border-top">
                                    <div class="d-flex flex-column flex-md-row gap-3">
                                        <button type="submit" class="btn btn-primary btn-submit flex-grow-1" id="submitBtn">
                                            <i class="bi bi-check-circle me-2"></i>提交信息
                                        </button>
                                        <button type="reset" class="btn btn-outline-secondary" onclick="resetForm()">
                                            <i class="bi bi-arrow-counterclockwise me-2"></i>重置
                                        </button>
                                        <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-outline-secondary">
                                            <i class="bi bi-arrow-left me-2"></i>返回列表
                                        </a>
                                    </div>
                                </div>
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
        <div class="row g-4">
            <div class="col-md-4">
                <h5 class="mb-3"><i class="bi bi-paw-fill me-2"></i>毛孩子领养平台</h5>
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
            <p class="mb-0">© 2025 毛孩子领养平台 版权所有</p>
        </div>
    </div>
</footer>

<!-- 引入 Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 字符计数
    const description = document.getElementById('description');
    const charCount = document.getElementById('charCount');
    const currentCount = document.getElementById('currentCount');
    
    description.addEventListener('input', function() {
        const length = this.value.length;
        currentCount.textContent = length;
        
        charCount.className = 'char-count';
        if (length < 30) {
            charCount.classList.add('danger');
        } else if (length < 50) {
            charCount.classList.add('warning');
        }
    });
    
    // 表单验证
    const form = document.getElementById('petForm');
    const submitBtn = document.getElementById('submitBtn');
    
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        e.stopPropagation();
        
        // 检查是否已登录
        <c:if test="${empty sessionScope.userId}">
            alert('请先登录后再提交信息！');
            window.location.href = '${pageContext.request.contextPath}/login.jsp?redirect=${pageContext.request.contextPath}/add.jsp';
            return false;
        </c:if>
        
        // 验证表单
        if (!form.checkValidity()) {
            form.classList.add('was-validated');
            return false;
        }
        
        // 验证描述长度
        const descValue = description.value.trim();
        if (descValue.length < 30) {
            description.classList.add('is-invalid');
            alert('宠物描述至少需要30字，请详细描述宠物的信息！');
            description.focus();
            return false;
        }
        
        // 验证年龄
        const age = parseInt(document.getElementById('age').value);
        if (isNaN(age) || age < 0 || age > 30) {
            document.getElementById('age').classList.add('is-invalid');
            alert('请输入有效的年龄（0-30岁）！');
            return false;
        }
        
        // 禁用提交按钮，防止重复提交
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>提交中...';
        
        // 提交表单
        form.submit();
    });
    
    // 实时验证
    const inputs = form.querySelectorAll('input, select, textarea');
    inputs.forEach(input => {
        input.addEventListener('blur', function() {
            if (this.checkValidity()) {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            } else {
                this.classList.remove('is-valid');
                this.classList.add('is-invalid');
            }
        });
        
        input.addEventListener('input', function() {
            if (this.classList.contains('is-invalid') && this.checkValidity()) {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            }
        });
    });
    
    // 重置表单
    function resetForm() {
        form.reset();
        form.classList.remove('was-validated');
        inputs.forEach(input => {
            input.classList.remove('is-valid', 'is-invalid');
        });
        currentCount.textContent = '0';
        charCount.className = 'char-count';
        submitBtn.disabled = false;
        submitBtn.innerHTML = '<i class="bi bi-check-circle me-2"></i>提交信息';
    }
    
    // 图片预览功能
    function previewImage(input) {
        const preview = document.getElementById('imagePreview');
        const previewImg = document.getElementById('previewImg');
        
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            
            reader.onload = function(e) {
                previewImg.src = e.target.result;
                preview.style.display = 'block';
            };
            
            reader.readAsDataURL(input.files[0]);
        } else {
            preview.style.display = 'none';
        }
    }
    
    // 页面加载时聚焦第一个输入框
    window.addEventListener('load', function() {
        <c:if test="${not empty sessionScope.userId}">
            document.getElementById('name').focus();
        </c:if>
    });
</script>
</body>
</html>
</html>