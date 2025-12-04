<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员后台 - 毛孩子领养平台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        /* 全局统一样式 - 所有管理员页面共用 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        .container-fluid {
            display: flex;
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        /* 左侧导航栏（所有页面统一） */
        .sidebar {
            width: 200px;
            background-color: #e6f7ee;
            padding: 20px 0;
            border-right: 1px solid #b3e0cc;
            flex-shrink: 0; /* 防止压缩 */
        }
        .sidebar h3 {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #b3e0cc;
            font-size: 18px;
            color: #2d5016;
        }
        .sidebar .nav {
            list-style: none;
            padding: 0 10px;
        }
        .sidebar .nav li {
            margin-bottom: 8px;
        }
        .sidebar .nav a {
            display: block;
            padding: 10px 15px;
            color: #333;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
        }
        .sidebar .nav a:hover {
            background-color: #b3e0cc;
            color: #000;
        }
        .sidebar .nav a.active {
            background-color: #b3e0cc;
            color: #000;
            font-weight: 500;
        }
        /* 右侧内容区（所有页面统一尺寸） */
        .main-content {
            flex: 1;
            padding: 25px;
            max-width: calc(100% - 200px); /* 固定右侧宽度，和其他页面一致 */
            overflow-y: auto;
        }
        /* 标题栏（所有页面统一） */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e9ecef;
        }
        .page-header h2 {
            font-size: 20px;
            font-weight: 600;
            margin: 0;
        }
        /* 卡片容器（所有页面统一） */
        .card-container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        /* 统计卡片样式（仪表盘专属，保持美观） */
        .stat-cards {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }
        .stat-card {
            background: #fff;
            padding: 20px;
            text-align: center;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .stat-card i {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        .stat-card .stat-number {
            font-size: 2rem;
            font-weight: bold;
            margin: 10px 0;
        }
        .stat-card .stat-label {
            color: #6c757d;
            font-size: 14px;
        }
        /* 表格样式（所有页面统一） */
        .data-table {
            width: 100%;
            margin-bottom: 0;
            table-layout: auto;
        }
        .data-table th, .data-table td {
            padding: 12px 10px;
            text-align: center;
            vertical-align: middle;
            font-size: 14px;
            white-space: nowrap;
        }
        .data-table th {
            background-color: #f8f9fa;
            font-weight: 500;
            color: #495057;
        }
        .data-table td {
            color: #333;
        }
        /* 空数据提示（所有页面统一） */
        .empty-data {
            padding: 30px 0;
            color: #6c757d;
            text-align: center;
            font-size: 14px;
        }
        /* 按钮样式（所有页面统一） */
        .btn {
            font-size: 14px;
            padding: 6px 12px;
            border-radius: 4px;
        }
        .btn-sm {
            font-size: 12px;
            padding: 4px 8px;
        }
        /* 模块标题（统一） */
        .module-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #2d3436;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <!-- 左侧导航栏（和其他页面完全统一） -->
    <div class="sidebar">
        <h3>管理员后台</h3>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="bi bi-speedometer2"></i> 仪表盘
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/pet/list">
                    <i class="bi bi-heart-pulse"></i> 宠物管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/user/list">
                    <i class="bi bi-people"></i> 用户管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/adoption">
                    <i class="bi bi-journal-check"></i> 领养申请
                </a>
            </li>
        </ul>
    </div>

    <!-- 右侧内容区（统一尺寸和样式） -->
    <div class="main-content">
        <!-- 统一标题栏（修复退出按钮为可点击链接） -->
        <div class="page-header">
            <h2><i class="bi bi-speedometer2 me-2 text-primary"></i>管理仪表盘</h2>
            <div>
                欢迎，管理员
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger btn-sm ms-2">退出</a>
            </div>
        </div>

        <!-- 统计卡片（保持原有功能，样式统一） -->
        <div class="stat-cards">
            <div class="stat-card">
                <i class="bi bi-house-heart" style="color: #4CAF50;"></i>
                <div class="stat-number">${totalPets}</div>
                <div class="stat-label">待领养宠物</div>
            </div>
            <div class="stat-card">
                <i class="bi bi-check-circle" style="color: #2196F3;"></i>
                <div class="stat-number">${adoptedPets}</div>
                <div class="stat-label">已领养数量</div>
            </div>
            <div class="stat-card">
                <i class="bi bi-people" style="color: #FF9800;"></i>
                <div class="stat-number">${totalUsers}</div>
                <div class="stat-label">注册用户</div>
            </div>
            <div class="stat-card">
                <i class="bi bi-file-text" style="color: #F44336;"></i>
                <div class="stat-number">${pendingApplications}</div>
                <div class="stat-label">待处理申请</div>
            </div>
        </div>

        <!-- 最近添加的宠物（统一卡片容器+表格样式） -->
        <div class="card-container">
            <div class="module-title">最近添加的宠物</div>
            <table class="table data-table table-hover">
                <thead>
                <tr>
                    <th style="width: 8%;">ID</th>
                    <th style="width: 15%;">名称</th>
                    <th style="width: 15%;">类型</th>
                    <th style="width: 8%;">年龄</th>
                    <th style="width: 8%;">性别</th>
                    <th style="width: 16%;">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty recentPets}">
                        <c:forEach items="${recentPets}" var="pet">
                            <tr>
                                <td>${pet.id}</td>
                                <td>${pet.name}</td>
                                <td>${pet.type}</td>
                                <td>${pet.age}</td>
                                <td>${pet.gender}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/pet/edit?id=${pet.id}" class="btn btn-sm btn-outline-primary me-1">
                                        <i class="bi bi-pencil"></i> 编辑
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="empty-data">暂无数据</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>

        <!-- 待处理领养申请（统一卡片容器+表格样式） -->
        <div class="card-container">
            <div class="module-title">待处理领养申请（快捷审核）</div>
            <table class="table data-table table-hover">
                <thead>
                <tr>
                    <th style="width: 8%;">申请ID</th>
                    <th style="width: 15%;">申请人</th>
                    <th style="width: 15%;">宠物名称</th>
                    <th style="width: 22%;">申请时间</th>
                    <th style="width: 16%;">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty pendingApplicationsList}">
                        <c:forEach items="${pendingApplicationsList}" var="app">
                            <tr>
                                <td>${app.id}</td>
                                <td>${app.user.username}</td>
                                <td>${app.pet.name}</td>
                                <td>${app.createTime}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/adoption/process?id=${app.id}&status=1"
                                       class="btn btn-sm btn-success me-1">同意</a>
                                    <a href="${pageContext.request.contextPath}/admin/adoption/process?id=${app.id}&status=2"
                                       class="btn btn-sm btn-danger">拒绝</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" class="empty-data">暂无待处理申请</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>