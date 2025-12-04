<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>领养申请管理 - 管理员后台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
<div class="container-fluid d-flex min-vh-100">
    <!-- 左侧导航栏 -->
    <div class="sidebar" style="width:200px;background-color:#e6f7ee;padding:20px 0;border-right:1px solid #b3e0cc;">
        <h3 class="text-center mb-3 pb-2 border-bottom border-success-subtle">管理员后台</h3>
        <ul class="nav flex-column px-2">
            <li class="nav-item mb-2">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="bi bi-speedometer2"></i> 仪表盘
                </a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/pet/list">
                    <i class="bi bi-heart-pulse"></i> 宠物管理
                </a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/user/list">
                    <i class="bi bi-people"></i> 用户管理
                </a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/adoption">
                    <i class="bi bi-journal-check"></i> 领养申请
                </a>
            </li>
        </ul>
    </div>

    <!-- 右侧内容 -->
    <div class="flex-fill p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0"><i class="bi bi-journal-check me-2 text-success"></i>领养申请列表</h2>
        </div>

        <table class="table table-striped align-middle">
            <thead>
            <tr>
                <th>ID</th>
                <th>宠物名称</th>
                <th>申请人</th>
                <th>申请理由</th>
                <th>联系方式</th>
                <th>申请时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${applications}" var="app">
                <tr>
                    <td>${app.id}</td>
                    <td>${app.petName}</td>
                    <td>${app.username}</td>
                    <td>${app.reason}</td>
                    <td>${app.contact}</td>
                    <td>${app.createTime}</td>
                    <td>
                        <c:choose>
                            <c:when test="${app.status == 0}">待处理</c:when>
                            <c:when test="${app.status == 1}">已同意</c:when>
                            <c:when test="${app.status == 2}">已拒绝</c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${app.status == 0}">
                            <a href="${pageContext.request.contextPath}/admin/adoption/process?id=${app.id}&status=1"
                               class="btn btn-success btn-sm">同意</a>
                            <a href="${pageContext.request.contextPath}/admin/adoption/process?id=${app.id}&status=2"
                               class="btn btn-danger btn-sm">拒绝</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>