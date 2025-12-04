<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>宠物管理 - 管理员后台</title>
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
            color: #000;
        }
        .sidebar .nav a.active {
            background-color: #b3e0cc;
            color: #000;
        }
        /* 右侧内容区 */
        .main-content {
            flex: 1;
            padding: 20px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <!-- 左侧导航栏 -->
    <div class="sidebar">
        <h3>管理员后台</h3>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="bi bi-speedometer2"></i> 仪表盘
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/pet/list">
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

    <!-- 右侧内容 -->
    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0"><i class="bi bi-heart-pulse me-2 text-danger"></i>宠物管理</h2>
        </div>

        <div class="mb-3">
            <a href="${pageContext.request.contextPath}/add.jsp" class="btn btn-primary">
                <i class="bi bi-plus-circle"></i> 添加新宠物
            </a>
        </div>

        <table class="table table-hover table-striped align-middle">
            <thead class="table-light">
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
                <c:when test="${not empty petList}">
                    <c:forEach items="${petList}" var="pet">
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
                                <a href="${pageContext.request.contextPath}/admin/pet/delete?id=${pet.id}" 
                                   class="btn btn-sm btn-outline-danger"
                                   onclick="return confirm('确定要删除【${pet.name}】吗？删除后无法恢复！');">
                                    <i class="bi bi-trash"></i> 删除
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="6" class="text-center text-muted py-4">
                            暂无宠物数据
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>


