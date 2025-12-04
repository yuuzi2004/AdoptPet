<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>寻找宠物 - 毛孩子领养平台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

        body {
            background: linear-gradient(135deg, #e8f5e9 0%, #f1f8e9 50%, #fff9c4 100%);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
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

        .search-hero {
            background: linear-gradient(135deg, #a8e6cf 0%, #c7ecee 50%, #ffd3d3 100%);
            color: #2d5016;
            padding: 80px 0 60px;
            text-align: center;
        }

        .search-hero h1 {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 1rem;
        }

        .search-hero p {
            font-size: 1.2rem;
            opacity: 0.95;
        }

        .search-form-card {
            background: white;
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-top: -40px;
            position: relative;
            z-index: 1;
        }

        .form-label {
            font-weight: 600;
            color: #2d5016;
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
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(168, 230, 207, 0.3);
            outline: none;
        }

        .btn-search {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 50%, var(--secondary-color) 100%);
            border: none;
            border-radius: 10px;
            padding: 0.875rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
            color: #2d5016;
        }

        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(168, 230, 207, 0.6);
            color: #1a3009;
        }

        .image-upload-area {
            border: 2px dashed var(--primary-color);
            border-radius: 12px;
            padding: 2rem;
            text-align: center;
            background: rgba(168, 230, 207, 0.1);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .image-upload-area:hover {
            background: rgba(168, 230, 207, 0.2);
            border-color: var(--accent-color);
        }

        .image-upload-area.dragover {
            background: rgba(168, 230, 207, 0.3);
            border-color: var(--secondary-color);
        }

        .image-preview {
            margin-top: 1rem;
            display: none;
        }

        .image-preview img {
            max-width: 100%;
            max-height: 300px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .result-section {
            padding: 60px 0;
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
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
        }

        .empty-state-icon {
            font-size: 5rem;
            color: #d1d5db;
            margin-bottom: 1.5rem;
        }

        /* 提示框样式（适配你的配色） */
        .alert-custom {
            border-radius: 12px;
            padding: 1rem 1.5rem;
            margin-bottom: 2rem;
            border: none;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .alert-success-custom {
            background-color: rgba(168, 230, 207, 0.2);
            color: #2d5016;
            border-left: 4px solid var(--success-color);
        }

        .alert-danger-custom {
            background-color: rgba(255, 170, 165, 0.2);
            color: #721c24;
            border-left: 4px solid var(--danger-color);
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">首页</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/pet/list">领养列表</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/add.jsp">发布信息</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/pet/search?action=default">寻找宠物</a></li>
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
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login_choice.jsp">
                                <i class="bi bi-person-circle me-1"></i>登录
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- 搜索英雄区 -->
<section class="search-hero">
    <div class="container">
        <h1><i class="bi bi-search me-3"></i>寻找走失的宠物</h1>
        <p>发布寻宠信息，让更多人帮助您找回心爱的毛孩子</p>
    </div>
</section>

<!-- 搜索表单 -->
<section class="container">
    <!-- 成功/错误提示 -->
    <c:if test="${not empty param.success}">
        <div class="alert-custom alert-success-custom mt-4">
            <i class="bi bi-check-circle me-2"></i>${param.success}
        </div>
    </c:if>
    <c:if test="${not empty param.error || not empty error}">
        <div class="alert-custom alert-danger-custom mt-4">
            <i class="bi bi-exclamation-circle me-2"></i>${param.error != null ? param.error : error}
        </div>
    </c:if>

    <!-- 发布成功提示（重定向后通过URL参数 successMsg 传递） -->
    <c:if test="${not empty param.successMsg}">
        <div class="alert alert-success-custom mb-4 d-none" id="publishSuccessAlert"
             data-success-msg="${fn:escapeXml(param.successMsg)}">
            <i class="bi bi-check-circle me-2"></i>${param.successMsg}
        </div>
    </c:if>

    <!-- 发布失败提示（request attribute 或 URL 参数 error） -->
    <c:if test="${not empty error || not empty param.error}">
        <div class="alert alert-danger-custom mb-4">
            <i class="bi bi-exclamation-circle me-2"></i>${error != null ? error : param.error}
        </div>
    </c:if>

    <div class="search-form-card">
        <h3 class="mb-4" style="color: #2d5016;"><i class="bi bi-file-earmark-plus me-2"></i>发布寻宠信息</h3>
        <form action="${pageContext.request.contextPath}/pet/search" method="post" enctype="multipart/form-data" id="searchForm">
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label">
                        <i class="bi bi-tag"></i>
                        宠物名称 <span class="text-danger">*</span>
                    </label>
                    <input type="text" class="form-control" name="name" required placeholder="请输入宠物名称">
                </div>
                <div class="col-md-6">
                    <label class="form-label">
                        <i class="bi bi-grid"></i>
                        宠物类型 <span class="text-danger">*</span>
                    </label>
                    <select class="form-select" name="type" required>
                        <option value="">请选择类型</option>
                        <option value="猫">🐱 猫</option>
                        <option value="狗">🐶 狗</option>
                        <option value="其他">其他</option>
                    </select>
                </div>
                <!-- 新增：宠物年龄输入框 -->
                <div class="col-md-6">
                    <label class="form-label">
                        <i class="bi bi-calendar-check"></i>
                        宠物年龄 <span class="text-danger">*</span>
                    </label>
                    <input type="number" class="form-control" id="age" name="age"
                           min="0" required placeholder="请输入宠物年龄（整数）">
                </div>
                <!-- 新增：宠物性别选择框 -->
                <div class="col-md-6">
                    <label class="form-label">
                        <i class="bi bi-gender-ambiguous"></i>
                        宠物性别 <span class="text-danger">*</span>
                    </label>
                    <select class="form-select" id="gender" name="gender" required>
                        <option value="">请选择性别</option>
                        <option value="公">公</option>
                        <option value="母">母</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label">
                        <i class="bi bi-geo-alt"></i>
                        丢失地点 <span class="text-danger">*</span>
                    </label>
                    <input type="text" class="form-control" name="location" required placeholder="请输入丢失地点">
                </div>
                <div class="col-md-6">
                    <label class="form-label">
                        <i class="bi bi-calendar-event"></i>
                        丢失时间 <span class="text-danger">*</span>
                    </label>
                    <input type="datetime-local" class="form-control" name="lostTime" required>
                </div>
                <div class="col-12">
                    <label class="form-label">
                        <i class="bi bi-image"></i>
                        宠物照片 <span class="text-muted">(可选)</span>
                    </label>
                    <div class="image-upload-area" onclick="document.getElementById('petImage').click()">
                        <i class="bi bi-cloud-upload" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                        <p class="mb-2" style="color: #2d5016;">点击或拖拽图片到此处上传</p>
                        <p class="text-muted small mb-0">支持 JPG、PNG、GIF 格式，最大 5MB</p>
                        <input type="file" id="petImage" name="image" accept="image/*" style="display: none;" onchange="previewImage(this)">
                    </div>
                    <div class="image-preview" id="imagePreview">
                        <img id="previewImg" src="" alt="预览">
                        <button type="button" class="btn btn-sm btn-outline-danger mt-2" onclick="removeImage()">
                            <i class="bi bi-x-circle me-1"></i>移除图片
                        </button>
                    </div>
                </div>
                <div class="col-12">
                    <label class="form-label">
                        <i class="bi bi-card-text"></i>
                        宠物特征描述 <span class="text-danger">*</span>
                    </label>
                    <textarea class="form-control" name="description" rows="4" required placeholder="请详细描述宠物的特征、颜色、体型等信息"></textarea>
                </div>
                <div class="col-12">
                    <label class="form-label">
                        <i class="bi bi-telephone"></i>
                        联系方式 <span class="text-danger">*</span>
                    </label>
                    <input type="text" class="form-control" name="contact" required placeholder="请输入您的手机号或微信号">
                </div>
                <div class="col-12">
                    <button type="submit" class="btn btn-search">
                        <i class="bi bi-send me-2"></i>发布寻宠信息
                    </button>
                    <a href="${pageContext.request.contextPath}/search.jsp" class="btn btn-outline-secondary ms-2">
                        <i class="bi bi-arrow-left me-2"></i>返回列表
                    </a>
                </div>
            </div>
        </form>
    </div>
</section>

<!-- 搜索结果区域 -->
<section class="result-section">
    <div class="container">
        <!-- 全部寻宠信息 -->
        <h3 class="mb-4"><i class="bi bi-list-ul me-2"></i>全部寻宠信息</h3>
        <div class="row g-4">
            <c:choose>
                <c:when test="${empty searchList}">
                    <div class="col-12">
                        <div class="empty-state">
                            <div class="empty-state-icon">
                                <i class="bi bi-search"></i>
                            </div>
                            <h4 class="text-muted">暂无寻宠信息</h4>
                            <p class="text-muted">当前没有任何寻宠信息，您可以发布第一条信息</p>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${searchList}" var="search">
                        <div class="col-md-6 col-lg-4">
                            <div class="card pet-card">
                                <c:choose>
                                    <c:when test="${not empty search.imagePath}">
                                        <c:choose>
                                            <c:when test="${fn:startsWith(search.imagePath, 'uploads/')}">
                                                <img src="${pageContext.request.contextPath}/uploads/${fn:substringAfter(search.imagePath, 'uploads/')}"
                                                     class="card-img-top"
                                                     alt="${search.name}"
                                                     style="height: 220px; object-fit: cover;"
                                                     onerror="this.src='https://via.placeholder.com/600x400/c7ecee/2d5016?text=${search.name}'">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/${search.imagePath}"
                                                     class="card-img-top"
                                                     alt="${search.name}"
                                                     style="height: 220px; object-fit: cover;"
                                                     onerror="this.src='https://via.placeholder.com/600x400/c7ecee/2d5016?text=${search.name}'">
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://via.placeholder.com/600x400/c7ecee/2d5016?text=${search.name}"
                                             class="card-img-top"
                                             alt="${search.name}"
                                             style="height: 220px; object-fit: cover;">
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body">
                                    <h5 class="card-title" style="color: #2d5016;">${search.name}</h5>
                                    <p class="text-muted small mb-2">
                                        <i class="bi bi-tag me-1"></i>${search.type} ·
                                        <i class="bi bi-geo-alt me-1"></i>${search.location} ·
                                        <!-- 新增：显示年龄和性别 -->
                                        <i class="bi bi-calendar-check me-1"></i>${search.age}岁 ·
                                        <i class="bi bi-gender-ambiguous me-1"></i>${search.gender}
                                    </p>
                                    <p class="card-text">${fn:substring(search.description, 0, 50)}${fn:length(search.description) > 50 ? '...' : ''}</p>
                                    <p class="text-muted small">
                                        <i class="bi bi-clock me-1"></i>丢失时间：${search.lostTime != null ? fn:replace(search.lostTime, 'T', ' ') : '未知'}
                                    </p>
                                    <p class="text-muted small">
                                        <i class="bi bi-telephone me-1"></i>联系方式：${search.contact}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
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
                    <li><a href="${pageContext.request.contextPath}/pet/search" class="footer-link">寻找宠物</a></li>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 图片预览功能
    function previewImage(input) {
        const preview = document.getElementById('imagePreview');
        const previewImg = document.getElementById('previewImg');
        const uploadArea = document.querySelector('.image-upload-area');

        if (input.files && input.files[0]) {
            const reader = new FileReader();

            reader.onload = function(e) {
                previewImg.src = e.target.result;
                preview.style.display = 'block';
                uploadArea.style.display = 'none';
            };

            reader.readAsDataURL(input.files[0]);
        }
    }

    // 移除图片
    function removeImage() {
        const preview = document.getElementById('imagePreview');
        const uploadArea = document.querySelector('.image-upload-area');
        const input = document.getElementById('petImage');

        preview.style.display = 'none';
        uploadArea.style.display = 'block';
        input.value = '';
    }

    // 拖拽上传
    const uploadArea = document.querySelector('.image-upload-area');

    uploadArea.addEventListener('dragover', function(e) {
        e.preventDefault();
        this.classList.add('dragover');
    });

    uploadArea.addEventListener('dragleave', function(e) {
        e.preventDefault();
        this.classList.remove('dragover');
    });

    uploadArea.addEventListener('drop', function(e) {
        e.preventDefault();
        this.classList.remove('dragover');

        const files = e.dataTransfer.files;
        if (files.length > 0) {
            const file = files[0];
            if (file.type.startsWith('image/')) {
                document.getElementById('petImage').files = files;
                previewImage(document.getElementById('petImage'));
            } else {
                alert('请上传图片文件！');
            }
        }
    });
</script>
</body>
</html>