<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>宠物管理 - 毛孩子领养平台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
            padding-top: 20px;
        }
        .container {
            max-width: 1200px;
        }
        .card {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border: none;
        }
        .page-header {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        .pet-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h1 class="h3">
            <i class="bi bi-paw"></i> 宠物管理
        </h1>
        <p class="text-muted">共 <span class="text-primary">${totalPets}</span> 只待领养宠物</p>
    </div>

    <!-- 错误提示 -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- 宠物列表表格 -->
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover table-striped">
                    <thead class="table-light">
                    <tr>
                        <th>宠物ID</th>
                        <th>宠物图片</th>
                        <th>宠物名称</th>
                        <th>类型</th>
                        <th>年龄</th>
                        <th>性别</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                    <c:when test="${not empty petList and petList.size() > 0}">
                    <c:forEach items="${petList}" var="pet">
                    <tr>
                        <td>${pet.id}</td>
                        <td>
                            <c:if test="${not empty pet.imagePath}">
                                <!-- 修正：确保图片路径正确拼接上下文路径 -->
                                <img src="${pageContext.request.contextPath}/${pet.imagePath}"
                                     class="pet-img" alt="${pet.name}">
                            </c:if>
                            <c:if test="${empty pet.imagePath}">
                                <span class="text-muted">无图片</span>
                            </c:if>
                        </td>
                        <td>${pet.name == null ? '未命名' : pet.name}</td>
                        <td>${pet.type == null ? '未知' : pet.type}</td>
                        <td>${pet.age}岁</td>
                        <td>${pet.gender == null ? '未知' : pet.gender}</td>
                        <td>
                            <!-- 编辑按钮路径与Servlet匹配 -->
                            <a href="${pageContext.request.contextPath}/admin/pet/edit?id=${pet.id}"
                               class="btn btn-sm btn-outline-warning">编辑</a>
                            <!-- 补充删除按钮（与DAO层deletePet方法参数匹配） -->
                            <a href="${pageContext.request.contextPath}/admin/pet/delete?id=${pet.id}&userId=${pet.userId}"
                               class="btn btn-sm btn-outline-danger"
                               onclick="return confirm('确定删除【${pet.name}】吗？')">删除</a>
                        </td>
                    </tr>
                    </c:forEach>
                    </c:when>
                    <c:otherwise>
                    <tr>
                        <td colspan="7" class="text-center text-muted py-3">
                            暂无待领养宠物
                        </td>
                    </tr>
                    </c:otherwise>
                    </c:choose>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>