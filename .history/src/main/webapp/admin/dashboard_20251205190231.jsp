<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>管理员后台 - 毛孩子领养平台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --mint: #a8e6cf;
            --pink: #ffd3d3;
            --blue: #c7ecee;
            --deep: #1f3b1f;
        }
        .container-fluid {
            display: flex;
            min-height: 100vh;
            background: linear-gradient(135deg, #e8f5e9 0%, #f1f8e9 50%, #fff9c4 100%);
        }
        /* 左侧导航栏薄巧渐变 */
        .sidebar {
            width: 200px;
            background: linear-gradient(135deg, var(--mint) 0%, var(--blue) 50%, var(--pink) 100%);
            padding: 20px 0;
            border-right: 1px solid #b3e0cc;
            flex-shrink: 0;
        }
        .sidebar h3 {
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(45, 80, 22, 0.15);
            font-size: 18px;
            color: var(--deep);
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
            color: var(--deep);
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
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
            border: 1px solid rgba(168, 230, 207, 0.35);
        }
        .section {
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
            margin-bottom: 30px;
            border: 1px solid rgba(168, 230, 207, 0.35);
        }
        .btn {
            border: none;
            border-radius: 8px;
            transition: all 0.2s ease;
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
            color: var(--deep);
        }
        .btn-success:hover {
            box-shadow: 0 8px 18px rgba(168, 230, 207, 0.45);
            color: #0f2a0f;
        }
        .btn-outline-primary {
            border: 1px solid var(--mint);
            color: var(--deep);
        }
        .btn-outline-primary:hover {
            background: linear-gradient(135deg, var(--mint) 0%, var(--blue) 50%, var(--pink) 100%);
            color: #0f2a0f;
            box-shadow: 0 6px 14px rgba(168, 230, 207, 0.35);
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

    <!-- 右侧内容区 -->
    <div class="main-content">
        <div class="header">
            <h2>管理仪表盘</h2>
            <div>
                欢迎，管理员
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger btn-sm ms-2">退出</a>
            </div>
        </div>

        <div class="stat-cards">
            <div class="stat-card">
                <i class="bi bi-house-heart" style="font-size: 2rem; color: #4CAF50;"></i>
                <div style="font-size: 2rem; font-weight: bold; margin: 10px 0;">${totalPets}</div>
                <div>待领养宠物</div>
            </div>
            <div class="stat-card">
                <i class="bi bi-check-circle" style="font-size: 2rem; color: #2196F3;"></i>
                <div style="font-size: 2rem; font-weight: bold; margin: 10px 0;">${adoptedPets}</div>
                <div>已领养数量</div>
            </div>
            <div class="stat-card">
                <i class="bi bi-people" style="font-size: 2rem; color: #FF9800;"></i>
                <div style="font-size: 2rem; font-weight: bold; margin: 10px 0;">${totalUsers}</div>
                <div>注册用户</div>
            </div>
            <div class="stat-card">
                <i class="bi bi-file-text" style="font-size: 2rem; color: #F44336;"></i>
                <div style="font-size: 2rem; font-weight: bold; margin: 10px 0;">${pendingApplications}</div>
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
                                        编辑
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="6" class="text-center text-muted">暂无数据</td></tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
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
                <c:choose>
                    <c:when test="${not empty pendingApplicationsList}">
                        <c:forEach items="${pendingApplicationsList}" var="app">
                            <tr>
                                <td>${app.id}</td>
                                <td>${app.user.username}</td>
                                <td>${app.pet.name}</td>
                                <td>${app.createTime}</td>
                                <td>
                                    <button type="button"
                                            class="btn btn-sm btn-success me-1"
                                            data-application-id="${app.id}"
                                            data-action="approved"
                                            onclick="processApplication(this)">
                                        同意
                                    </button>
                                    <button type="button"
                                            class="btn btn-sm btn-danger"
                                            data-application-id="${app.id}"
                                            data-action="rejected"
                                            onclick="processApplication(this)">
                                        拒绝
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="5" class="text-center text-muted">暂无待处理申请</td></tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- 统一反馈弹窗（成功/失败/警告） -->
<div class="modal fade" id="feedbackModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header border-0">
                <h5 class="modal-title" id="feedbackModalTitle">
                    <i class="bi bi-check-circle-fill text-success me-2"></i>操作成功
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center py-4" id="feedbackModalBody">
                操作成功！
            </div>
            <div class="modal-footer border-0 justify-content-center">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="feedbackModalBtn">好的</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.js"></script>
<script>
    // 处理领养申请（同意/拒绝）
    function processApplication(btn) {
        const applicationId = btn.dataset.applicationId;
        const action = btn.dataset.action; // 'approved' 或 'rejected'
        const actionText = action === 'approved' ? '同意' : '拒绝';
        
        // 使用 AJAX 提交请求
        fetch('${pageContext.request.contextPath}/admin/adoption/process?id=' + applicationId + '&status=' + action, {
            method: 'GET',
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            }
        })
        .then(response => {
            if (response.ok) {
                // 显示成功弹窗
                showFeedbackModal('success', actionText + '申请成功！');
                // 延迟刷新页面，让用户看到成功提示
                setTimeout(() => {
                    window.location.reload();
                }, 1500);
            } else {
                showFeedbackModal('error', actionText + '申请失败，请重试！');
            }
        })
        .catch(error => {
            console.error('处理申请出错：', error);
            showFeedbackModal('error', '操作失败，请重试！');
        });
    }
    
    // 显示统一反馈弹窗
    function showFeedbackModal(type, message) {
        const modal = document.getElementById('feedbackModal');
        const title = document.getElementById('feedbackModalTitle');
        const body = document.getElementById('feedbackModalBody');
        const btn = document.getElementById('feedbackModalBtn');
        
        if (type === 'success') {
            title.innerHTML = '<i class="bi bi-check-circle-fill text-success me-2"></i>操作成功';
            title.querySelector('i').className = 'bi bi-check-circle-fill text-success me-2';
            btn.className = 'btn btn-primary';
        } else if (type === 'error') {
            title.innerHTML = '<i class="bi bi-x-circle-fill text-danger me-2"></i>操作失败';
            title.querySelector('i').className = 'bi bi-x-circle-fill text-danger me-2';
            btn.className = 'btn btn-danger';
        } else if (type === 'warn') {
            title.innerHTML = '<i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>提示';
            title.querySelector('i').className = 'bi bi-exclamation-triangle-fill text-warning me-2';
            btn.className = 'btn btn-warning';
        }
        
        body.textContent = message;
        const bsModal = new bootstrap.Modal(modal);
        bsModal.show();
    }
</script>
</body>
</html>
