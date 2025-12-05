<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

        .record-footer {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            gap: 0.75rem;
        }

        .record-status {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.4rem 0.9rem;
            border-radius: 999px;
            font-weight: 600;
            font-size: 0.85rem;
        }

        .record-status.pending {
            background-color: rgba(255, 213, 165, 0.4);
            color: #8b5a08;
        }

        .record-status.approved {
            background-color: #e8f7f0;
            color: #0f5132;
            border: 1px solid #b7e4c7;
        }

        .record-status.rejected {
            background-color: rgba(255, 170, 165, 0.4);
            color: #7a1c1c;
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

        /* 寻宠信息专属样式 */
        .record-status.search-pet-status-searching {
            background-color: rgba(229, 62, 62, 0.2);
            color: #e53e3e;
        }

        .record-status.search-pet-status-found {
            background-color: rgba(72, 187, 120, 0.2);
            color: #48bb78;
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
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/center">
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
        <!-- 全局反馈弹窗（统一风格） -->
        <div class="modal fade" id="feedbackModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header border-0">
                        <h5 class="modal-title" id="feedbackTitle">
                            <i class="bi bi-info-circle me-2"></i>提示
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="feedbackBody">-</div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">好的</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 页面标题和操作按钮 -->
        <!-- 个人中心总标题 -->
        <div class="page-header d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-3 mb-4">
            <div>
                <h1 class="page-title">
                    <i class="bi bi-person-circle text-primary me-2" style="font-size: 1.5rem;"></i>
                    个人中心
                </h1>
            </div>
        </div>

        <!-- 我的发布领养信息子板块 -->
        <div class="page-header d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-3">
            <div>
                <h2 class="page-title" style="font-size: 1.5rem; font-weight: 600;">
                    <i class="bi bi-sun text-primary me-2" style="font-size: 1.5rem;"></i>
                    我的发布领养信息
                </h2>
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
                                        <button type="button"
                                                class="btn btn-sm btn-outline-primary btn-action"
                                                data-bs-toggle="modal"
                                                data-bs-target="#petDetailModal"
                                                data-pet-id="${pet.id}"
                                                data-pet-name="${fn:escapeXml(pet.name)}"
                                                data-pet-type="${fn:escapeXml(pet.type)}"
                                                data-pet-age="${fn:escapeXml(pet.age)}"
                                                data-pet-gender="${fn:escapeXml(pet.gender)}"
                                                data-pet-description="${fn:escapeXml(pet.description)}"
                                                data-pet-image="${pet.imagePath}"
                                                onclick="loadPetDetail(this)">
                                            <i class="bi bi-info-circle me-1"></i>查看详情
                                        </button>
                                        <div class="d-flex gap-2">
                                            <a href="${pageContext.request.contextPath}/user/pet/edit?id=${pet.id}"
                                               class="btn btn-sm btn-primary btn-action flex-grow-1">
                                                <i class="bi bi-pencil me-1"></i>编辑
                                            </a>
                                            <button type="button"
                                                    class="btn btn-sm btn-danger btn-action"
                                                    data-pet-id="${pet.id}"
                                                    data-pet-name="${fn:escapeXml(pet.name)}"
                                                    onclick="handlePetDelete(this)">
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

        <!-- 我的领养申请记录板块 -->
        <div class="mt-5">
            <div class="page-header d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-3 mt-5">
                <div>
                    <h2 class="page-title" style="font-size: 1.5rem; font-weight: 600;">
                        <i class="bi bi-file-earmark-check text-primary me-2"></i>
                        我的领养申请记录
                    </h2>
                    <p class="text-muted mb-0 mt-2">
                        <c:choose>
                            <c:when test="${not empty applicationList}">
                                共提交了 <strong>${applicationList.size()}</strong> 条领养申请
                            </c:when>
                            <c:otherwise>
                                您还没有提交任何领养申请
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>

            <!-- 申请记录列表 -->
            <c:choose>
                <c:when test="${not empty applicationList}">
                    <div class="row g-4 mt-3">
                        <c:forEach items="${applicationList}" var="application">
                            <div class="col-12">
                                <div class="pet-card">
                                    <div class="card-body">
                                        <div class="d-flex flex-wrap gap-4">
                                            <!-- 宠物信息 -->
                                            <div class="flex-grow-1">
                                                <h5 class="card-title">
                                                    <i class="bi bi-paw text-primary me-1"></i>
                                                    申请领养：${application.petName}
                                                </h5>
                                                <div class="pet-info">
                                            <span class="pet-info-item">
                                                <i class="bi bi-paw"></i>
                                                类型：${application.pet.type}
                                            </span>
                                                    <span class="pet-info-item">
                                                <i class="bi bi-calendar"></i>
                                                年龄：${application.pet.age}岁
                                            </span>
                                            <span class="pet-info-item">
                                                <i class="bi bi-clock"></i>
                                                申请时间：${application.createTimeText}
                                            </span>
                                                </div>
                                                <p class="mt-2">
                                                    <strong>申请理由：</strong>
                                                    <span class="text-muted">${application.reason}</span>
                                                </p>
                                                <p>
                                                    <strong>联系方式：</strong>
                                                    <span class="text-muted">${application.contact}</span>
                                                </p>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="card-footer">
                                        <div class="record-footer">
                                            <div class="d-flex flex-wrap gap-2">
                                                <button type="button"
                                                        class="btn btn-sm btn-outline-primary btn-action"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#petDetailModal"
                                                        data-pet-id="${application.pet != null ? application.pet.id : ''}"
                                                        data-pet-name="${application.pet != null && not empty application.pet.name ? fn:escapeXml(application.pet.name) : '未知宠物'}"
                                                        data-pet-type="${application.pet != null && not empty application.pet.type ? fn:escapeXml(application.pet.type) : '未知类型'}"
                                                        data-pet-age="${application.pet != null && application.pet.age != null ? application.pet.age : '未知'}"
                                                        data-pet-gender="${application.pet != null && not empty application.pet.gender ? fn:escapeXml(application.pet.gender) : '未填写'}"
                                                        data-pet-description="${application.pet != null && not empty application.pet.description ? fn:escapeXml(application.pet.description) : '暂无描述'}"
                                                        data-pet-image="${application.pet != null ? application.pet.imagePath : ''}"
                                                        onclick="loadPetDetail(this)">
                                                    <i class="bi bi-info-circle me-1"></i>查看详情
                                                </button>
                                                <button type="button"
                                                        class="btn btn-sm btn-danger btn-action"
                                                        data-application-id="${application.id}"
                                                        data-pet-name="${fn:escapeXml(application.petName)}"
                                                        onclick="handleApplicationDelete(this)">
                                                    <i class="bi bi-trash me-1"></i>删除申请
                                                </button>
                                            </div>
                                            <c:choose>
                                                <c:when test="${application.pending}">
                                                    <span class="record-status pending">
                                                        <i class="bi bi-hourglass-half"></i>${application.statusCN}
                                                    </span>
                                                </c:when>
                                                <c:when test="${application.approved}">
                                                    <span class="record-status approved">
                                                        <i class="bi bi-check-circle"></i>${application.statusCN}
                                                    </span>
                                                </c:when>
                                                <c:when test="${application.rejected}">
                                                    <span class="record-status rejected">
                                                        <i class="bi bi-x-circle"></i>${application.statusCN}
                                                    </span>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                        <c:if test="${application.approved}">
                                            <div class="text-success small mt-2">
                                                <i class="bi bi-check2-circle me-1"></i>管理员已同意申请，处理时间：${application.processTimeText}
                                            </div>
                                        </c:if>
                                        <c:if test="${application.rejected}">
                                            <div class="text-danger small mt-2">
                                                管理员已拒绝申请，处理时间：${application.processTimeText}
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- 申请记录空状态 -->
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="bi bi-file-earmark-check"></i>
                        </div>
                        <h4>还没有提交任何领养申请</h4>
                        <p>去领养列表看看有没有心仪的毛孩子吧！</p>
                        <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-primary btn-action">
                            <i class="bi bi-list-ul me-2"></i>浏览领养列表
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 我的寻宠信息板块 -->
        <div class="mt-5">
            <div class="page-header d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-3">
                <div>
                    <h1 class="page-title">
                        <i class="bi bi-search text-primary me-2" style="font-size: 1.5rem;"></i>
                        我的寻宠信息
                    </h1>
                    <p class="text-muted mb-0 mt-2">
                        <c:choose>
                            <c:when test="${not empty myPetSearchList}">
                                共发布了 <strong>${myPetSearchList.size()}</strong> 条寻宠信息
                            </c:when>
                            <c:otherwise>
                                您还没有发布任何寻宠信息
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </div>

            <!-- 寻宠信息列表 -->
            <c:choose>
                <c:when test="${not empty myPetSearchList}">
                    <div class="row g-4 mt-3">
                        <c:forEach items="${myPetSearchList}" var="search">
                            <div class="col-12">
                                <div class="pet-card">
                                    <div class="card-body">
                                        <div class="d-flex flex-wrap gap-4">
                                            <!-- 寻宠信息主内容 -->
                                            <div class="flex-grow-1">
                                                <h5 class="card-title">
                                                    <i class="bi bi-geo-alt-fill text-danger me-1"></i>
                                                    寻找：${search.name}
                                                </h5>

                                                <!-- 寻宠基础信息 -->
                                                <div class="pet-info">
                                                    <span class="pet-info-item">
                                                        <i class="bi bi-paw"></i>
                                                        类型：${search.type}
                                                    </span>
                                                    <span class="pet-info-item">
                                                        <i class="bi bi-geo-alt"></i>
                                                        丢失位置：${search.location}
                                                    </span>
                                                    <span class="pet-info-item">
                                                        <i class="bi bi-clock"></i>
                                                        丢失时间：<c:choose>
                                                        <c:when test="${not empty search.lostTime}">
                                                            <%
                                                                com.pet.adopt.entity.PetSearch searchItem = (com.pet.adopt.entity.PetSearch) pageContext.getAttribute("search");
                                                                if (searchItem != null && searchItem.getLostTime() != null) {
                                                                    out.print(searchItem.getLostTime().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                                                                }
                                                            %>
                                                        </c:when>
                                                        <c:otherwise>未知</c:otherwise>
                                                    </c:choose>
                                                    </span>
                                                </div>

                                                <!-- 寻宠描述 -->
                                                <p class="mt-2">
                                                    <strong>寻宠描述：</strong>
                                                    <span class="text-muted">${search.description}</span>
                                                </p>

                                                <!-- 联系方式 -->
                                                <p>
                                                    <strong>联系电话：</strong>
                                                    <span class="text-muted">${search.contact}</span>
                                                </p>
                                            </div>
                                        </div>

                                        <!-- 寻宠图片（如果有） -->
                                        <c:if test="${not empty search.imagePath}">
                                            <div class="mt-3">
                                                <label class="text-muted small">寻宠照片：</label>
                                                <div class="mt-1" style="max-width: 200px;">
                                                    <c:choose>
                                                        <c:when test="${fn:startsWith(search.imagePath, 'uploads/')}">
                                                            <img src="${pageContext.request.contextPath}/uploads/${fn:substringAfter(search.imagePath, 'uploads/')}"
                                                                 alt="${search.name}"
                                                                 class="img-thumbnail"
                                                                 style="border-radius: 8px;"
                                                                 onerror="this.src='https://via.placeholder.com/200x150/a8e6cf/2d5016?text=暂无图片';">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/${search.imagePath}"
                                                                 alt="${search.name}"
                                                                 class="img-thumbnail"
                                                                 style="border-radius: 8px;"
                                                                 onerror="this.src='https://via.placeholder.com/200x150/a8e6cf/2d5016?text=暂无图片';">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>

                                    <!-- 操作按钮 -->
                                    <div class="card-footer">
                                        <div class="record-footer">
                                            <div class="d-flex flex-wrap gap-2">
                                                <!-- 修改后（添加2行数据属性） -->
                                                <button type="button"
                                                        class="btn btn-sm btn-outline-primary btn-action"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#petDetailModal"
                                                        data-pet-name="${fn:escapeXml(search.name)}"
                                                        data-pet-type="${fn:escapeXml(search.type)}"
                                                        data-pet-age="${search.age != null ? search.age : '未知'}"
                                                        data-pet-gender="${fn:escapeXml(search.gender != null ? search.gender : '未填写')}"
                                                        data-pet-description="${fn:escapeXml(search.description)}"
                                                        data-pet-image="${search.imagePath}"
                                                        data-search-location="${fn:escapeXml(search.location)}"
                                                        data-search-losttime="${search.lostTime != null ? fn:escapeXml(search.lostTime.toString()) : '未知'}"
                                                        data-search-contact="${fn:escapeXml(search.contact)}"
                                                        onclick="loadSearchDetail(this)">
                                                    <i class="bi bi-info-circle me-1"></i>查看详情
                                                </button>        <!-- 标记找回 -->
                                                <c:if test="${search.status == 'searching'}">
                                                    <button type="button"
                                                            class="btn btn-sm btn-success btn-action"
                                                            data-search-id="${search.id}"
                                                            data-search-name="${fn:escapeXml(search.name)}"
                                                            onclick="handleSearchFound(this)">
                                                        <i class="bi bi-check-circle me-1"></i>标记找回
                                                    </button>
                                                </c:if>

                                                <!-- 删除寻宠信息 -->
                                                <button type="button"
                                                        class="btn btn-sm btn-danger btn-action"
                                                        data-search-id="${search.id}"
                                                        data-search-name="${fn:escapeXml(search.name)}"
                                                        onclick="handleSearchDelete(this)">
                                                    <i class="bi bi-trash me-1"></i>删除
                                                </button>
                                            </div>
                                            <!-- 寻宠状态 -->
                                            <c:choose>
                                                <c:when test="${search.status == 'searching'}">
                                                    <span class="record-status search-pet-status-searching">
                                                        <i class="bi bi-hourglass-half"></i>寻找中
                                                    </span>
                                                </c:when>
                                                <c:when test="${search.status == 'found'}">
                                                    <span class="record-status search-pet-status-found">
                                                        <i class="bi bi-check-circle"></i>已找回
                                                    </span>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- 寻宠信息空状态 -->
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="bi bi-search"></i>
                        </div>
                        <h4>还没有发布任何寻宠信息</h4>
                        <p>快去发布寻宠信息，帮毛孩子回家吧！</p>
                        <a href="${pageContext.request.contextPath}/search.jsp" class="btn btn-primary btn-action">
                            <i class="bi bi-plus-circle me-2"></i>发布寻宠信息
                        </a>
                    </div>
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
    // 加载领养宠物详情到弹窗
    // 加载领养宠物详情到弹窗
    function loadPetDetail(button) {
        // 获取按钮上的宠物数据（增加空值兜底）
        const petName = button.dataset.petName || '未知宠物';
        const petType = button.dataset.petType || '未知类型';
        const petAge = button.dataset.petAge || '未知';
        const petGender = button.dataset.petGender || '未填写';
        const petDescription = button.dataset.petDescription || '暂无描述';
        const petImage = button.dataset.petImage || '';

        // 填充弹窗内容
        document.getElementById('modalPetName').textContent = petName + ' - 详情';
        document.getElementById('modalPetNameText').textContent = petName;
        document.getElementById('modalPetType').textContent = petType;
        document.getElementById('modalPetAge').textContent = petAge + '岁';
        document.getElementById('modalPetGender').textContent = petGender;
        document.getElementById('modalPetDescription').textContent = petDescription;

        // 处理宠物图片（修复路径拼接逻辑）
        const modalImage = document.getElementById('modalPetImage');
        if (petImage && petImage.trim() !== '') {
            let imageSrc = '';
            // 兼容绝对路径和相对路径
            if (petImage.startsWith('http')) {
                imageSrc = petImage; // 如果是网络图片直接使用
            } else if (petImage.startsWith('uploads/')) {
                imageSrc = contextPath + '/uploads/' + petImage.substring('uploads/'.length);
            } else {
                imageSrc = contextPath + '/' + petImage;
            }
            modalImage.src = imageSrc;
            modalImage.onerror = function() {
                this.src = 'https://via.placeholder.com/300x200/a8e6cf/2d5016?text=暂无图片';
            };
        } else {
            modalImage.src = 'https://via.placeholder.com/300x200/a8e6cf/2d5016?text=暂无图片';
        }
    }
    // 修复寻宠信息详情加载函数
    function loadSearchDetail(button) {
        // 获取寻宠基础信息
        const petName = button.dataset.petName || '未知宠物';
        const petType = button.dataset.petType || '未知类型';
        const petAge = button.dataset.petAge ? button.dataset.petAge + '岁' : '未知';
        const petGender = button.dataset.petGender || '未填写';
        const petDescription = button.dataset.petDescription || '暂无描述';
        const petImage = button.dataset.petImage || '';

        // 获取寻宠专属信息
        const searchLocation = button.dataset.searchLocation || '未知位置';
        const searchLosttime = button.dataset.searchLosttime || '未知时间';
        const searchContact = button.dataset.searchContact || '未知联系方式';

        // 填充基础弹窗内容
        document.getElementById('modalPetName').textContent = petName + ' - 寻宠详情';
        document.getElementById('modalPetNameText').textContent = petName;
        document.getElementById('modalPetType').textContent = petType;
        document.getElementById('modalPetAge').textContent = petAge;
        document.getElementById('modalPetGender').textContent = petGender;

        // 关键修复：分开设置基础信息和寻宠专属信息
        document.getElementById('modalPetDescription').textContent = petDescription;

        // 显示并填充寻宠专属字段
        document.querySelectorAll('.search-only').forEach(el => {
            el.style.display = 'table-row'; // 显示寻宠专属行
        });
        document.getElementById('modalSearchLocation').textContent = searchLocation;
        document.getElementById('modalSearchLosttime').textContent = searchLosttime;
        document.getElementById('modalSearchContact').textContent = searchContact;

        // 处理寻宠图片
        const modalImage = document.getElementById('modalPetImage');
        if (petImage && petImage.trim() !== '') {
            let imageSrc = '';
            if (petImage.startsWith('http')) {
                imageSrc = petImage;
            } else if (petImage.startsWith('uploads/')) {
                imageSrc = contextPath + '/uploads/' + petImage.substring('uploads/'.length);
            } else {
                imageSrc = contextPath + '/' + petImage;
            }
            modalImage.src = imageSrc;
            modalImage.onerror = function() {
                this.src = 'https://via.placeholder.com/300x200/a8e6cf/2d5016?text=暂无图片';
            };
        } else {
            modalImage.src = 'https://via.placeholder.com/300x200/a8e6cf/2d5016?text=暂无图片';
        }
    }
    // 统一删除 / 标记操作的弹窗处理
    let currentActionType = null; // 'pet' | 'application' | 'found' | 'search'
    let currentActionId = null;
    let currentActionName = null;

    function handlePetDelete(button) {
        currentActionType = 'pet';
        currentActionId = button.dataset.petId;
        currentActionName = button.dataset.petName;
        showConfirmModal('删除领养信息', '确定要删除 "' + currentActionName + '" 的领养信息吗？删除后无法恢复！');
    }

    function handleApplicationDelete(button) {
        currentActionType = 'application';
        currentActionId = button.dataset.applicationId;
        currentActionName = button.dataset.petName;
        showConfirmModal('删除领养申请', '确定要删除 "' + currentActionName + '" 的领养申请吗？删除后无法恢复！');
    }

    function handleSearchFound(button) {
        currentActionType = 'found';
        currentActionId = button.dataset.searchId;
        currentActionName = button.dataset.searchName;
        showConfirmModal('标记已找回', '确定要将 "' + currentActionName + '" 标记为已找回吗？');
    }

    function handleSearchDelete(button) {
        currentActionType = 'search';
        currentActionId = button.dataset.searchId;
        currentActionName = button.dataset.searchName;
        showConfirmModal('删除寻宠信息', '确定要删除 "' + currentActionName + '" 的寻宠信息吗？删除后无法恢复！');
    }

    // 显示统一确认弹窗
    function showConfirmModal(title, message) {
        document.getElementById('confirmModalTitle').innerText = title;
        document.getElementById('confirmModalBody').innerText = message;
        const modal = new bootstrap.Modal(document.getElementById('confirmActionModal'));
        modal.show();
    }

    // 用户在弹窗中点击“确定”后的统一处理
    function confirmActionSubmit() {
        if (!currentActionType || !currentActionId) return;

        // 特殊处理：标记寻宠“已找回”使用 Ajax，保持当前在个人中心页面
        if (currentActionType === 'found') {
            fetch('${pageContext.request.contextPath}/user/search/found', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: 'id=' + encodeURIComponent(currentActionId)
            })
                .then(function (resp) {
                    const ct = resp.headers.get('content-type') || '';
                    if (ct.indexOf('application/json') !== -1) {
                        return resp.json();
                    }
                    return null;
                })
                .then(function (data) {
                    console.log('标记找回结果 => ', data);
                    // 无论成功失败，都刷新个人中心列表（简单可靠）
                    window.location.reload();
                })
                .catch(function (err) {
                    console.error('标记找回请求出错：', err);
                    window.location.reload();
                });
            return;
        }

        // 其他操作（删除领养信息 / 删除申请 / 删除寻宠）保持原来的表单提交逻辑
        let formAction = '';
        let idFieldName = '';

        if (currentActionType === 'pet') {
            formAction = '${pageContext.request.contextPath}/user/pet/delete';
            idFieldName = 'id';
        } else if (currentActionType === 'application') {
            formAction = '${pageContext.request.contextPath}/adoption/delete';
            idFieldName = 'applicationId';
        } else if (currentActionType === 'search') {
            formAction = '${pageContext.request.contextPath}/user/search/delete';
            idFieldName = 'id';
        }

        if (!formAction) return;

        const form = document.createElement('form');
        form.method = 'POST';
        form.action = formAction;

        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = idFieldName;
        idInput.value = currentActionId;

        form.appendChild(idInput);
        document.body.appendChild(form);
        form.submit();
    }

    // 统一反馈弹窗（成功/错误/警告，参考 p3 样式）
    (function () {
        const successMsg = '${fn:escapeXml(not empty param.success ? param.success : success)}';
        const errorMsg = '${fn:escapeXml(not empty param.error ? param.error : error)}';
        const warnMsg = '${fn:escapeXml(param.warn)}';

        function showFeedback(type, message) {
            if (!message) return;
            const modalEl = document.getElementById('feedbackModal');
            if (!modalEl) return;
            const titleEl = document.getElementById('feedbackTitle');
            const bodyEl = document.getElementById('feedbackBody');
            const okBtn = modalEl.querySelector('.btn.btn-primary');

            const iconMap = {
                success: '<i class="bi bi-check-circle text-success me-2"></i>操作成功',
                error: '<i class="bi bi-exclamation-triangle text-danger me-2"></i>操作失败',
                warn: '<i class="bi bi-exclamation-circle text-warning me-2"></i>提示'
            };
            titleEl.innerHTML = iconMap[type] || iconMap.warn;
            bodyEl.textContent = message;

            // 显示弹窗
            const modal = new bootstrap.Modal(modalEl);
            modal.show();

            // 点击“好的”仅关闭，不跳转
            if (okBtn) {
                okBtn.onclick = function () {
                    modal.hide();
                };
            }
        }

        if (successMsg) {
            showFeedback('success', successMsg);
        } else if (errorMsg) {
            showFeedback('error', errorMsg);
        } else if (warnMsg) {
            showFeedback('warn', warnMsg);
        }
    })();
</script>

<!-- 通用确认操作弹窗（删除 / 标记已找回等） -->
<div class="modal fade" id="confirmActionModal" tabindex="-1" aria-labelledby="confirmModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 16px;">
            <div class="modal-header border-0">
                <h5 class="modal-title" id="confirmModalTitle">
                    <i class="bi bi-exclamation-triangle-fill text-danger me-2"></i>操作确认
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p class="mb-0" id="confirmModalBody">确定要执行此操作吗？</p>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="confirmActionSubmit()" data-bs-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

<!-- 领养信息详情弹窗（支持领养和寻宠信息） -->
<div class="modal fade" id="petDetailModal" tabindex="-1" aria-labelledby="petDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="petDetailModalLabel">
                    <i class="bi bi-paw text-primary me-2"></i>
                    <span id="modalPetName">宠物详情</span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <!-- 宠物图片 -->
                    <div class="col-md-4 mb-3">
                        <img id="modalPetImage"
                             src="https://via.placeholder.com/300x200/a8e6cf/2d5016?text=暂无图片"
                             class="img-thumbnail w-100"
                             alt="宠物图片">
                    </div>
                    <!-- 宠物信息表格 -->
                    <div class="col-md-8">
                        <div class="table-responsive">
                            <table class="table table-hover table-borderless">
                                <tbody>
                                <tr class="border-bottom border-light">
                                    <th class="py-3" style="width: 20%;">名称：</th>
                                    <td class="py-3" id="modalPetNameText">-</td>
                                </tr>
                                <tr class="border-bottom border-light">
                                    <th class="py-3">类型：</th>
                                    <td class="py-3" id="modalPetType">-</td>
                                </tr>
                                <tr class="border-bottom border-light">
                                    <th class="py-3">年龄：</th>
                                    <td class="py-3" id="modalPetAge">-</td>
                                </tr>
                                <tr class="border-bottom border-light">
                                    <th class="py-3">性别：</th>
                                    <td class="py-3" id="modalPetGender">-</td>
                                </tr>
                                <!-- 寻宠信息专属字段（默认隐藏） -->
                                <tr class="border-bottom border-light search-only" style="display: none;">
                                    <th class="py-3">丢失位置：</th>
                                    <td class="py-3" id="modalSearchLocation">-</td>
                                </tr>
                                <tr class="border-bottom border-light search-only" style="display: none;">
                                    <th class="py-3">丢失时间：</th>
                                    <td class="py-3" id="modalSearchLosttime">-</td>
                                </tr>
                                <tr class="border-bottom border-light search-only" style="display: none;">
                                    <th class="py-3">联系方式：</th>
                                    <td class="py-3" id="modalSearchContact">-</td>
                                </tr>
                                <tr>
                                    <th class="py-3" style="vertical-align: top;">详细描述：</th>
                                    <!-- 移除white-space: pre-wrap样式 -->
                                    <td class="py-3" id="modalPetDescription" style="line-height: 1.6;">-</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 全局路径变量（解决JS中路径解析问题） -->
<script>
    // 定义全局上下文路径
    const contextPath = '${pageContext.request.contextPath}';
</script>
</body>
</html>