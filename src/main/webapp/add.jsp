<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        .section {
            padding: 40px 0;
        }
        .form-card {
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-radius: 10px;
            overflow: hidden;
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/pages/pet/add.jsp">提交领养信息</a></li>
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
                    <div class="card-body p-5">
                        <!-- 表单：提交到 PetAddServlet（/pet/add） -->
                        <form action="${pageContext.request.contextPath}/pet/add" method="post">
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

<!-- 引入 Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>