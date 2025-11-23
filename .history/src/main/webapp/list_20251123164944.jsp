<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        .section {
            padding: 40px 0;
        }
        .card-hover {
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
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
<section class="section bg-light">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-6">
            <h2 class="fw-bold">可领养宠物列表</h2>
            <a href="${pageContext.request.contextPath}/add.jsp" class="btn btn-primary">
                <i class="bi bi-plus-circle me-2"></i>新增可领养宠物
            </a>
        </div>

        <!-- 筛选栏 -->
        <div class="card mb-6 p-4">
            <form class="row g-3">
                <div class="col-md-3">
                    <label class="form-label">宠物类型</label>
                    <select class="form-select">
                        <option value="">全部类型</option>
                        <option value="猫">猫</option>
                        <option value="狗">狗</option>
                        <option value="其他">其他</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">性别</label>
                    <select class="form-select">
                        <option value="">不限性别</option>
                        <option value="公">公</option>
                        <option value="母">母</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">年龄</label>
                    <select class="form-select">
                        <option value="">不限年龄</option>
                        <option value="1">1岁以下</option>
                        <option value="2">1-3岁</option>
                        <option value="3">3岁以上</option>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="bi bi-search me-2"></i>筛选
                    </button>
                </div>
            </form>
        </div>

        <!-- 宠物列表卡片 -->
        <div class="row g-4">
            <!-- 用 JSTL 遍历数据库中的宠物数据 -->
            <c:forEach items="${petList}" var="pet">
                <div class="col-md-4 col-lg-3">
                    <div class="card card-hover h-100">
                        <!-- 宠物图片（默认图，后续可扩展上传功能） -->
                        <img src="https://picsum.photos/id/${pet.id + 100}/600/400" class="card-img-top" alt="${pet.name}">
                        <div class="card-body">
                            <h5 class="card-title">${pet.name}</h5>
                            <p class="card-text text-muted small">
                                <i class="bi bi-tag me-1"></i>${pet.type} ·
                                <i class="bi bi-calendar-check me-1"></i>${pet.age}岁 ·
                                <i class="bi bi-venus-mars me-1"></i>${pet.gender}
                            </p>
                            <p class="card-text text-truncate">${pet.description}</p>
                        </div>
                        <div class="card-footer bg-transparent d-flex justify-content-between">
                            <button class="btn btn-sm btn-outline-primary">
                                <i class="bi bi-heart me-1"></i>申请领养
                            </button>
                            <button class="btn btn-sm btn-outline-secondary">
                                <i class="bi bi-info-circle me-1"></i>详情
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- 若无数据，显示空状态 -->
            <c:if test="${empty petList}">
                <div class="col-12 text-center py-10">
                    <div class="bg-light p-5 rounded-lg">
                        <i class="bi bi-paw text-muted fs-5 mb-3"></i>
                        <h4 class="text-muted">暂无可领养宠物</h4>
                        <p class="text-muted mb-4">可以尝试新增宠物信息哦~</p>
                        <a href="${pageContext.request.contextPath}/add.jsp" class="btn btn-sm btn-primary">
                            <i class="bi bi-plus-circle me-1"></i>新增宠物
                        </a>
                    </div>
                </div>
            </c:if>
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