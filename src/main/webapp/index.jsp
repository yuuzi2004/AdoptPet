<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>流浪动物领养平台 - 给毛孩子一个家</title>
    <!-- 引入 Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入图标库 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        /* 自定义样式 */
        .hero {
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url("https://picsum.photos/id/237/1920/1080");
            background-size: cover;
            background-position: center;
            height: 80vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        .card-hover {
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .section {
            padding: 60px 0;
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/">首页</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/pet/list">领养列表</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/pages/pet/add.jsp">提交领养信息</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- 英雄区（banner） -->
<section class="hero">
    <div class="container text-center">
        <h1 class="display-4 fw-bold mb-4">给流浪的毛孩子一个温暖的家</h1>
        <p class="lead mb-6">每一个生命都值得被爱，领养代替购买，用陪伴治愈彼此</p>
        <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-primary btn-lg me-3">
            <i class="bi bi-search me-2"></i>浏览可领养宠物
        </a>
        <a href="${pageContext.request.contextPath}/pages/pet/add.jsp" class="btn btn-light btn-lg">
            <i class="bi bi-plus-circle me-2"></i>提交宠物信息
        </a>
    </div>
</section>

<!-- 推荐宠物区 -->
<section class="section bg-light">
    <div class="container">
        <h2 class="text-center mb-6 fw-bold">热门推荐领养</h2>
        <div class="row g-4">
            <!-- 推荐宠物卡片1 -->
            <div class="col-md-4">
                <div class="card card-hover h-100">
                    <img src="https://picsum.photos/id/1025/600/400" class="card-img-top" alt="金毛犬">
                    <div class="card-body">
                        <h5 class="card-title">小金 - 金毛犬</h5>
                        <p class="card-text"><i class="bi bi-calendar-check me-1"></i>2岁 · 公 · 已疫苗</p>
                        <p class="card-text text-truncate">性格温顺粘人，喜欢和小朋友玩，会简单指令</p>
                    </div>
                    <div class="card-footer bg-transparent">
                        <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-sm btn-outline-primary">查看详情</a>
                    </div>
                </div>
            </div>
            <!-- 推荐宠物卡片2 -->
            <div class="col-md-4">
                <div class="card card-hover h-100">
                    <img src="https://picsum.photos/id/40/600/400" class="card-img-top" alt="橘猫">
                    <div class="card-body">
                        <h5 class="card-title">橘子 - 橘猫</h5>
                        <p class="card-text"><i class="bi bi-calendar-check me-1"></i>1岁 · 母 · 已绝育</p>
                        <p class="card-text text-truncate">安静独立，爱干净，会自己用猫砂盆</p>
                    </div>
                    <div class="card-footer bg-transparent">
                        <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-sm btn-outline-primary">查看详情</a>
                    </div>
                </div>
            </div>
            <!-- 推荐宠物卡片3 -->
            <div class="col-md-4">
                <div class="card card-hover h-100">
                    <img src="https://picsum.photos/id/1074/600/400" class="card-img-top" alt="柯基">
                    <div class="card-body">
                        <h5 class="card-title">豆豆 - 柯基</h5>
                        <p class="card-text"><i class="bi bi-calendar-check me-1"></i>1.5岁 · 公 · 已疫苗</p>
                        <p class="card-text text-truncate">活泼好动，精力充沛，喜欢出门散步</p>
                    </div>
                    <div class="card-footer bg-transparent">
                        <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-sm btn-outline-primary">查看详情</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 领养须知 -->
<section class="section">
    <div class="container">
        <h2 class="text-center mb-6 fw-bold">领养须知</h2>
        <div class="row g-4">
            <div class="col-md-4 text-center">
                <div class="bg-primary/10 p-5 rounded-circle w-25 mx-auto mb-4">
                    <i class="bi bi-heart-fill text-primary fs-3"></i>
                </div>
                <h3 class="h5 mb-2">真心对待</h3>
                <p>视为家庭一员，不离不弃，不因搬家、结婚等理由遗弃</p>
            </div>
            <div class="col-md-4 text-center">
                <div class="bg-primary/10 p-5 rounded-circle w-25 mx-auto mb-4">
                    <i class="bi bi-shield-fill text-primary fs-3"></i>
                </div>
                <h3 class="h5 mb-2">负责到底</h3>
                <p>定期疫苗、驱虫，生病及时治疗，提供良好生活环境</p>
            </div>
            <div class="col-md-4 text-center">
                <div class="bg-primary/10 p-5 rounded-circle w-25 mx-auto mb-4">
                    <i class="bi bi-check-circle-fill text-primary fs-3"></i>
                </div>
                <h3 class="h5 mb-2">接受回访</h3>
                <p>配合志愿者定期回访，确保宠物生活状况良好</p>
            </div>
        </div>
    </div>
</section>

<!-- 页脚 -->
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
                    <li><a href="${pageContext.request.contextPath}/pages/pet/add.jsp" class="text-white/80 text-decoration-none">提交信息</a></li>
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

<!-- 引入 Bootstrap JS（实现导航栏折叠等交互） -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>