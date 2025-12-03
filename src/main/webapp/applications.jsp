<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>领养申请管理 - 毛孩子领养平台</title>
    <!-- 引入Bootstrap样式 -->
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
            margin-bottom: 20px;
        }
        .page-header {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: flex-start; /* 仅保留标题，移除返回按钮 */
            align-items: center;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 页面标题：移除返回首页按钮 -->
    <div class="page-header">
        <h1 class="h3">
            <i class="bi bi-file-text"></i> 领养申请管理
        </h1>
    </div>

    <!-- 提示信息：成功/错误 -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- 领养申请列表 -->
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover table-striped">
                    <thead class="table-light">
                    <tr>
                        <th>申请ID</th>
                        <th>申请人</th>
                        <th>申请宠物</th>
                        <th>申请状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty applications and applications.size() > 0}">
                            <c:forEach items="${applications}" var="app">
                                <tr>
                                    <td>${app.id}</td>
                                    <td>${app.username == null ? '未知用户' : app.username}</td>
                                    <td>${app.petName == null ? '未知宠物' : app.petName}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${app.status == 'pending'}">
                                                <span class="badge bg-warning">待审核</span>
                                            </c:when>
                                            <c:when test="${app.status == 'approved'}">
                                                <span class="badge bg-success">已同意</span>
                                            </c:when>
                                            <c:when test="${app.status == 'rejected'}">
                                                <span class="badge bg-danger">已拒绝</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">未知</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <!-- 仅待审核的申请可操作 -->
                                        <c:if test="${app.status == 'pending'}">
                                            <a href="${pageContext.request.contextPath}/admin/adoption/process?id=${app.id}&status=approved"
                                               class="btn btn-sm btn-success me-1">
                                                同意
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/adoption/process?id=${app.id}&status=rejected"
                                               class="btn btn-sm btn-danger">
                                                拒绝
                                            </a>
                                        </c:if>
                                        <c:if test="${app.status != 'pending'}">
                                            <span class="text-muted">无操作</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="text-center text-muted py-3">
                                    暂无领养申请
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- 引入Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>