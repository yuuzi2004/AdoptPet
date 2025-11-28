<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员后台 - 毛孩子领养平台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #6366f1;
            --danger-color: #ef4444;
            --success-color: #10b981;
            --warning-color: #f59e0b;
        }

        body {
            background: #f8f9fa;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 250px;
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            color: white;
            padding: 2rem 0;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }

        .sidebar-brand {
            padding: 0 1.5rem 2rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 2rem;
        }

        .sidebar-brand h4 {
            margin: 0;
            font-weight: 700;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar-menu li {
            margin-bottom: 0.5rem;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 1rem 1.5rem;
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .sidebar-menu a:hover,
        .sidebar-menu a.active {
            background: rgba(255,255,255,0.1);
            color: white;
            border-left: 4px solid var(--danger-color);
        }

        .main-content {
            margin-left: 250px;
            padding: 2rem;
        }

        .admin-header {
            background: white;
            padding: 1.5rem 2rem;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .admin-header h2 {
            margin: 0;
            font-weight: 700;
            color: #1e293b;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            margin-bottom: 1rem;
        }

        .stat-icon.primary {
            background: linear-gradient(135deg, var(--primary-color), #4f46e5);
        }

        .stat-icon.success {
            background: linear-gradient(135deg, var(--success-color), #059669);
        }

        .stat-icon.warning {
            background: linear-gradient(135deg, var(--warning-color), #d97706);
        }

        .stat-icon.danger {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #64748b;
            font-size: 0.9rem;
        }

        .content-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .table {
            margin-bottom: 0;
        }

        .table thead {
            background: #f8f9fa;
        }

        .table th {
            border: none;
            font-weight: 600;
            color: #374151;
        }

        .badge-status {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
        }

        /* 新增：编辑/删除按钮 hover 效果优化 */
        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        .btn-outline-danger:hover {
            background-color: var(--danger-color);
            border-color: var(--danger-color);
        }
    </style>
</head>
<body>
<!-- 侧边栏 -->
<div class="sidebar">
    <div class="sidebar-brand">
        <h4><i class="bi bi-shield-lock me-2"></i>管理员后台</h4>
    </div>
    <ul class="sidebar-menu">
        <li>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">
                <i class="bi bi-speedometer2 me-2"></i>仪表盘
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/pet/list">
                <i class="bi bi-heart me-2"></i>宠物管理
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/user/list">
                <i class="bi bi-people me-2"></i>用户管理
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/adoption">
                <i class="bi bi-file-check me-2"></i>领养申请
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/">
                <i class="bi bi-house me-2"></i>返回首页
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/logout">
                <i class="bi bi-box-arrow-right me-2"></i>退出登录
            </a>
        </li>
    </ul>
</div>

<!-- 主内容区 -->
<div class="main-content">
    <div class="admin-header">
        <h2><i class="bi bi-speedometer2 me-2"></i>管理仪表盘</h2>
        <div>
            <span class="text-muted me-3">欢迎，管理员</span>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-sm btn-outline-danger">
                <i class="bi bi-box-arrow-right me-1"></i>退出
            </a>
        </div>
    </div>

    <!-- 统计卡片 -->
    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="stat-card">
                <div class="stat-icon primary">
                    <i class="bi bi-heart-pulse"></i>
                </div>
                <div class="stat-number">${totalPets != null ? totalPets : 0}</div>
                <div class="stat-label">待领养宠物</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="stat-icon success">
                    <i class="bi bi-check-circle"></i>
                </div>
                <div class="stat-number">${adoptedPets != null ? adoptedPets : 0}</div>
                <div class="stat-label">已领养数量</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="stat-icon warning">
                    <i class="bi bi-people"></i>
                </div>
                <div class="stat-number">${totalUsers != null ? totalUsers : 0}</div>
                <div class="stat-label">注册用户</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="stat-icon danger">
                    <i class="bi bi-file-earmark-text"></i>
                </div>
                <div class="stat-number">${pendingApplications != null ? pendingApplications : 0}</div>
                <div class="stat-label">待处理申请</div>
            </div>
        </div>
    </div>

    <!-- 最近宠物列表（核心：编辑按钮已配置正确路径） -->
    <div class="content-card">
        <h5 class="mb-4"><i class="bi bi-list-ul me-2"></i>最近添加的宠物</h5>
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>名称</th>
                    <th>类型</th>
                    <th>年龄</th>
                    <th>性别</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty recentPets}">
                        <c:forEach items="${recentPets}" var="pet">
                            <tr>
                                <td>${pet.id}</td>
                                <td>${pet.name}</td>
                                <td><span class="badge bg-primary">${pet.type}</span></td>
                                <td>${pet.age}岁</td>
                                <td>${pet.gender}</td>
                                <td>
                                    <!-- 编辑按钮：指向之前创建的AdminPetEditServlet -->
                                    <a href="${pageContext.request.contextPath}/admin/pet/edit?id=${pet.id}"
                                       class="btn btn-sm btn-outline-primary me-2">
                                        <i class="bi bi-pencil"></i>编辑
                                    </a>
                                    <!-- 删除按钮（保留原有功能） -->
                                    <a href="${pageContext.request.contextPath}/admin/pet/delete?id=${pet.id}"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('确定要删除这只宠物吗？')">
                                        <i class="bi bi-trash"></i>删除
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="text-center text-muted">暂无数据</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 待处理领养申请 -->
    <div class="content-card mt-4">
        <h5 class="mb-4"><i class="bi bi-file-earmark-text me-2"></i>待处理领养申请（快捷审核）</h5>
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>申请ID</th>
                    <th>申请人</th>
                    <th>宠物名称</th>
                    <th>申请时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty pendingApplicationsList}">
                        <c:forEach items="${pendingApplicationsList}" var="app">
                            <tr>
                                <td>${app.id}</td>
                                <td>${app.username}</td>
                                <td>${app.petName}</td>
                                <td>${app.applyTime}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/adoption/process?id=${app.id}&status=approved"
                                       class="btn btn-sm btn-outline-success me-2"
                                       onclick="return confirm('确定通过该申请吗？')">
                                        <i class="bi bi-check"></i>通过
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/adoption/process?id=${app.id}&status=rejected"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('确定驳回该申请吗？')">
                                        <i class="bi bi-x"></i>驳回
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" class="text-center text-muted">暂无待处理申请</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>