<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户管理 - 管理员后台</title>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                    <i class="bi bi-speedometer2"></i> 仪表盘
                </a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/pet/list">
                    <i class="bi bi-heart-pulse"></i> 宠物管理
                </a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/user/list">
                    <i class="bi bi-people"></i> 用户管理
                </a>
            </li>
            <li class="nav-item mb-2">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/adoption">
                    <i class="bi bi-journal-check"></i> 领养申请
                </a>
            </li>
        </ul>
    </div>

    <!-- 右侧内容 -->
    <div class="flex-fill p-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0"><i class="bi bi-people me-2 text-primary"></i>用户管理</h2>
        </div>

        <table class="table table-hover table-striped align-middle">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>用户名</th>
                <th>邮箱</th>
                <th>手机号</th>
                <th>注册时间</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty userList}">
                    <c:forEach items="${userList}" var="user">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.username}</td>
                            <td>${user.email}</td>
                            <td>${user.phone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty user.createTime}">
                                        ${user.createTime}
                                    </c:when>
                                    <c:otherwise>未知</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5" class="text-center text-muted py-4">
                            暂无用户数据
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


