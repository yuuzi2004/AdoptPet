<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>宠物管理 - 管理员后台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        /* 全局统一样式 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        .container-fluid {
            display: flex;
            min-height: 100vh;
            background: linear-gradient(135deg, #e8f5e9 0%, #f1f8e9 50%, #fff9c4 100%);
        }
        /* 左侧导航栏（所有页面统一） */
        .sidebar {
            width: 200px;
            background: linear-gradient(135deg, #a8e6cf 0%, #c7ecee 50%, #ffd3d3 100%);
            padding: 20px 0;
            border-right: 1px solid #b3e0cc;
            flex-shrink: 0; /* 防止压缩 */
        }
        .sidebar h3 {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(45, 80, 22, 0.15);
            font-size: 18px;
            color: #1f3b1f;
            font-weight: 700;
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
            color: #1f3b1f;
            text-decoration: none;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.2s ease;
        }
        .sidebar .nav a:hover {
            background: rgba(255, 255, 255, 0.35);
            color: #0f2a0f;
        }
        .sidebar .nav a.active {
            background: rgba(255, 255, 255, 0.55);
            color: #0f2a0f;
            font-weight: 600;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        /* 右侧内容区（所有页面统一尺寸） */
        .main-content {
            flex: 1;
            padding: 25px;
            max-width: calc(100% - 200px); /* 固定右侧宽度 */
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
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
            margin-bottom: 20px;
            border: 1px solid rgba(168, 230, 207, 0.35);
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
            border-radius: 8px;
            border: none;
            transition: all 0.2s ease;
        }
        .btn-sm {
            font-size: 12px;
            padding: 4px 10px;
        }
        .btn-primary {
            background: linear-gradient(135deg, #a8e6cf 0%, #c7ecee 50%, #ffd3d3 100%);
            color: #1f3b1f;
        }
        .btn-primary:hover {
            color: #0f2a0f;
            box-shadow: 0 8px 18px rgba(168, 230, 207, 0.45);
        }
        .btn-danger {
            background: linear-gradient(135deg, #ffaaa5 0%, #ffd3d3 100%);
            color: #7a1c1c;
        }
        .btn-danger:hover {
            box-shadow: 0 8px 18px rgba(255, 170, 165, 0.45);
            color: #5a1111;
        }
        .btn-success {
            background: linear-gradient(135deg, #b5e48c 0%, #a8e6cf 50%, #c7ecee 100%);
            color: #1f3b1f;
        }
        .btn-outline-secondary {
            border: 1px solid #a8e6cf;
            color: #1f3b1f;
        }
        .btn-outline-secondary:hover {
            background: linear-gradient(135deg, #a8e6cf 0%, #c7ecee 50%, #ffd3d3 100%);
            color: #0f2a0f;
            box-shadow: 0 6px 14px rgba(168, 230, 207, 0.35);
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <!-- 左侧导航栏（统一） -->
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

    <!-- 右侧内容区（统一尺寸） -->
    <div class="main-content">
        <!-- 统一标题栏 - 修复退出按钮为可点击链接 -->
        <div class="page-header">
            <h2><i class="bi bi-heart-pulse me-2 text-danger"></i>宠物管理</h2>
            <div>
                欢迎，管理员
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger btn-sm ms-2">退出</a>
            </div>
        </div>

        <!-- 统一卡片容器 -->
        <div class="card-container">
            <div class="mb-3">
                <a href="${pageContext.request.contextPath}/admin/pet/addPage" class="btn btn-primary">
                    <i class="bi bi-plus-circle"></i> 添加新宠物
                </a>
            </div>

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
                                    <button type="button"
                                            class="btn btn-sm btn-outline-danger"
                                            data-delete-url="${pageContext.request.contextPath}/admin/pet/delete?id=${pet.id}"
                                            data-pet-name="${fn:escapeXml(pet.name)}"
                                            onclick="confirmDeletePet(this)">
                                        <i class="bi bi-trash"></i> 删除
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="empty-data">暂无宠物数据</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
</div>
</div>

<!-- 删除确认弹窗（统一样式） -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="bi bi-exclamation-triangle text-danger me-2"></i>确认删除</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="deleteConfirmBody">确定要删除该宠物吗？删除后无法恢复！</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" id="deleteConfirmBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 统一删除确认
    let pendingDeleteUrl = '';
    function confirmDeletePet(btn) {
        const url = btn.dataset.deleteUrl;
        const name = btn.dataset.petName || '该宠物';
        pendingDeleteUrl = url;
        document.getElementById('deleteConfirmBody').textContent = `确定要删除「${name}」吗？删除后无法恢复！`;
        const modal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
        modal.show();
    }
    document.getElementById('deleteConfirmBtn').addEventListener('click', function () {
        if (pendingDeleteUrl) {
            window.location.href = pendingDeleteUrl;
        }
    });
</script>
</body>
</html>