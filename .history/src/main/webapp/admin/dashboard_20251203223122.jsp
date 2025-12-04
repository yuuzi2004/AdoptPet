<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>管理员后台 - 毛孩子领养平台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .container-fluid {
            display: flex;
            min-height: 100vh;
        }
        /* 左侧导航栏样式（匹配你的绿色背景） */
        .sidebar {
            width: 200px;
            background-color: #e6f7ee;
            padding: 20px 0;
            border-right: 1px solid #b3e0cc;
        }
        .sidebar h3 {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #b3e0cc;
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
        }
        .sidebar .nav a:hover {
            background-color: #b3e0cc;
        }
        /* 右侧内容区 */
        .main-content {
            flex: 1;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .stat-cards {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: #fff;
            padding: 20px;
            text-align: center;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .section {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <!-- 左侧导航栏（已删除多余条目，修复路径） -->
    <div class="sidebar">
        <h3>管理员后台</h3>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
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

    <!-- 右侧内容区 -->
    <div class="main-content">
        <div class="header">
            <h2>管理仪表盘</h2>
            <div>
                欢迎，管理员
                <button class="btn btn-danger btn-sm ms-2">退出</button>
            </div>
        </div>

        <div class="stat-cards">
            <div class="stat-card">
                <i class="bi bi-house-heart" style="font-size: 2rem; color: #4CAF50;"></i>
                <div style="font-size: 2rem; font-weight: bold; margin: 10px 0;">0</div>
                <div>待领养宠物</div>
            </div>
            <div class="stat-card">
                <i class="bi bi-check-circle" style="font-size: 2rem; color: #2196F3;"></i>
                <div style="font-size: 2rem; font-weight: bold; margin: 10px 0;">0</div>
                <div>已领养数量</div>
            </div>
            <div class="stat-card">
                <i class="bi bi-people" style="font-size: 2rem; color: #FF9800;"></i>
                <div style="font-size: 2rem; font-weight: bold; margin: 10px 0;">0</div>
                <div>注册用户</div>
            </div>
            <div class="stat-card">
                <i class="bi bi-file-text" style="font-size: 2rem; color: #F44336;"></i>
                <div style="font-size: 2rem; font-weight: bold; margin: 10px 0;">0</div>
                <div>待处理申请</div>
            </div>
        </div>

        <div class="section">
            <h3>最近添加的宠物</h3>
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
                <tr><td colspan="6" class="text-center text-muted">暂无数据</td></tr>
                </tbody>
            </table>
        </div>
        <!-- 在"最近添加的宠物"下方添加 -->
        <div class="section">
            <h3>快捷操作</h3>
            <div class="d-flex gap-3">
                <!-- 添加宠物按钮（假设添加页面是pet/add.jsp） -->
                <a href="${pageContext.request.contextPath}/admin/pet/add.jsp" class="btn btn-primary">
                    <i class="bi bi-plus-circle"></i> 添加新宠物
                </a>
                <!-- 刷新数据按钮 -->
                <button onclick="location.reload()" class="btn btn-secondary">
                    <i class="bi bi-arrow-clockwise"></i> 刷新数据
                </button>
            </div>
        </div>

        <div class="section">
            <h3>待处理领养申请（快捷审核）</h3>
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
                <tr><td colspan="5" class="text-center text-muted">暂无待处理申请</td></tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>