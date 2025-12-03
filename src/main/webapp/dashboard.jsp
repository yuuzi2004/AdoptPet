<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>管理员后台 - 毛孩子领养平台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        /* 整体布局 */
        .container-fluid {
            display: flex;
            min-height: 100vh;
        }
        /* 左侧导航栏样式（绿色背景） */
        .sidebar {
            width: 220px;
            background-color: #e6f7ee;
            padding: 20px 0;
            border-right: 1px solid #b3e0cc;
        }
        .sidebar-header {
            padding: 0 20px 15px;
            border-bottom: 1px solid #b3e0cc;
            margin-bottom: 15px;
        }
        .sidebar .nav {
            padding: 0 10px;
        }
        .sidebar .nav-item {
            margin-bottom: 5px;
        }
        .sidebar .nav-link {
            color: #333;
            padding: 10px 20px;
            border-radius: 4px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .sidebar .nav-link:hover {
            background-color: #b3e0cc;
            color: #000;
        }
        /* 右侧内容区 */
        .main-content {
            flex: 1;
            padding: 20px;
            background-color: #fff;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        .stat-cards {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
        }
        .stat-card .icon {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        .stat-card .number {
            font-size: 1.8rem;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        .section h3 {
            margin-top: 0;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <!-- 左侧导航栏（核心修改：删除返回首页和退出登录） -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h3>管理员后台</h3>
        </div>
        <ul class="nav flex-column">
            <!-- 保留的导航项 -->
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="bi bi-speedometer2"></i> 仪表盘
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/pet-list.jsp">
                    <i class="bi bi-paw"></i> 宠物管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/user-list.jsp">
                    <i class="bi bi-people"></i> 用户管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/applications.jsp">
                    <i class="bi bi-file-text"></i> 领养申请
                </a>
            </li>

            <!-- 已删除：返回首页 -->
            <!-- 已删除：退出登录 -->
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

        <!-- 统计卡片 -->
        <div class="stat-cards">
            <div class="stat-card">
                <div class="icon text-success"><i class="bi bi-paw"></i></div>
                <div class="number">0</div>
                <div class="label">待领养宠物</div>
            </div>
            <div class="stat-card">
                <div class="icon text-primary"><i class="bi bi-check-circle"></i></div>
                <div class="number">0</div>
                <div class="label">已领养数量</div>
            </div>
            <div class="stat-card">
                <div class="icon text-warning"><i class="bi bi-people"></i></div>
                <div class="number">0</div>
                <div class="label">注册用户</div>
            </div>
            <div class="stat-card">
                <div class="icon text-danger"><i class="bi bi-file-text"></i></div>
                <div class="number">0</div>
                <div class="label">待处理申请</div>
            </div>
        </div>

        <!-- 最近添加的宠物 -->
        <div class="section">
            <h3>最近添加的宠物</h3>
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
                    <tr>
                        <td colspan="6" class="text-center text-muted">暂无数据</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- 待处理领养申请 -->
        <div class="section">
            <h3>待处理领养申请（快捷审核）</h3>
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
                    <tr>
                        <td colspan="5" class="text-center text-muted">暂无待处理申请</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>