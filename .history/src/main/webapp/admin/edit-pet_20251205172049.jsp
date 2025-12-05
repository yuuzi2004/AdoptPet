<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑宠物信息 - 管理员后台</title>
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
        /* 表单样式（统一） */
        .form-label {
            font-weight: 500;
            margin-bottom: 8px;
            font-size: 14px;
        }
        .form-control, .form-select {
            font-size: 14px;
            padding: 8px 12px;
            border-radius: 4px;
            border: 1px solid #ced4da;
        }
        .form-control:focus, .form-select:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
            outline: 0;
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
        .btn-outline-secondary {
            border: 1px solid #a8e6cf;
            color: #1f3b1f;
        }
        .btn-outline-secondary:hover {
            background: linear-gradient(135deg, #a8e6cf 0%, #c7ecee 50%, #ffd3d3 100%);
            color: #0f2a0f;
            box-shadow: 0 6px 14px rgba(168, 230, 207, 0.35);
        }
        /* 图片预览样式 */
        .img-thumbnail {
            border-radius: 4px;
            border: 1px solid #dee2e6;
            max-width: 200px;
        }
        .form-text {
            font-size: 12px;
            color: #6c757d;
            margin-top: 4px;
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
        <!-- 统一标题栏 - 退出按钮已正确配置 -->
        <div class="page-header">
            <h2><i class="bi bi-pencil me-2"></i>编辑宠物信息</h2>
            <div>
                欢迎，管理员
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger btn-sm ms-2">退出</a>
            </div>
        </div>

        <!-- 统一卡片容器 -->
        <div class="card-container">
            <!-- 结果提示弹窗 -->
            <div class="modal fade" id="updateResultModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="updateResultTitle">提示</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body" id="updateResultBody">-</div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-bs-dismiss="modal">好的</button>
                        </div>
                    </div>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/admin/pet/update" method="post" enctype="multipart/form-data">
                <!-- 隐藏字段存储宠物ID -->
                <input type="hidden" name="id" value="${pet.id}">

                <div class="mb-3">
                    <label for="name" class="form-label">宠物名称 *</label>
                    <input type="text" class="form-control" id="name" name="name" value="${pet.name}" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="type" class="form-label">宠物类型 *</label>
                        <input type="text" class="form-control" id="type" name="type" value="${pet.type}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="age" class="form-label">年龄 *</label>
                        <input type="number" class="form-control" id="age" name="age" value="${pet.age}" required min="0">
                    </div>
                </div>

                <div class="mb-3">
                    <label for="gender" class="form-label">性别 *</label>
                    <select class="form-select" id="gender" name="gender" required>
                        <option value="公" ${pet.gender == '公' ? 'selected' : ''}>公</option>
                        <option value="母" ${pet.gender == '母' ? 'selected' : ''}>母</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">描述信息 *</label>
                    <textarea class="form-control" id="description" name="description" rows="5" required>${pet.description}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">当前图片</label><br>
                    <c:choose>
                        <c:when test="${not empty pet.imagePath}">
                            <c:choose>
                                <c:when test="${fn:startsWith(pet.imagePath, 'uploads/')}">
                                    <img src="${pageContext.request.contextPath}/uploads/${fn:substringAfter(pet.imagePath, 'uploads/')}"
                                         width="200"
                                         alt="${pet.name}"
                                         class="img-thumbnail"
                                         onerror="this.src='https://via.placeholder.com/200x200/a8e6cf/2d5016?text=暂无图片'">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/${pet.imagePath}"
                                         width="200"
                                         alt="${pet.name}"
                                         class="img-thumbnail"
                                         onerror="this.src='https://via.placeholder.com/200x200/a8e6cf/2d5016?text=暂无图片'">
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/200x200/a8e6cf/2d5016?text=暂无图片"
                                 width="200"
                                 alt="暂无图片"
                                 class="img-thumbnail">
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="mb-3">
                    <label for="image" class="form-label">更换图片（可选）</label>
                    <input type="file" class="form-control" id="image" name="image" accept="image/*">
                    <div class="form-text">支持 JPG、PNG、GIF 格式，最大 5MB</div>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check-circle me-1"></i>保存修改
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/pet/list" class="btn btn-secondary">
                        <i class="bi bi-x-circle me-1"></i>取消
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 根据后端返回的 successMessage / errorMessage 弹出提示，不再跳转
    document.addEventListener('DOMContentLoaded', function () {
        const successMsg = '${fn:escapeXml(successMessage)}';
        const errorMsg = '${fn:escapeXml(errorMessage)}';
            const listPage = '${pageContext.request.contextPath}/admin/pet/list';
        if (successMsg || errorMsg) {
            const modalEl = document.getElementById('updateResultModal');
            const titleEl = document.getElementById('updateResultTitle');
            const bodyEl = document.getElementById('updateResultBody');
            const modal = new bootstrap.Modal(modalEl);

            if (successMsg) {
                titleEl.innerHTML = '<i class="bi bi-check-circle text-success me-1"></i>操作成功';
                bodyEl.textContent = successMsg;
            } else {
                titleEl.innerHTML = '<i class="bi bi-exclamation-triangle text-danger me-1"></i>操作失败';
                bodyEl.textContent = errorMsg || '操作失败';
            }
            modal.show();

            // “好的”按钮或关闭弹窗后，成功时跳回宠物管理列表
            modalEl.addEventListener('hidden.bs.modal', function () {
                if (successMsg) {
                    window.location.href = listPage;
                }
            });
            const okBtn = modalEl.querySelector('.btn.btn-primary');
            if (okBtn) {
                okBtn.addEventListener('click', function () {
                    if (successMsg) {
                        window.location.href = listPage;
                    }
                });
            }
        }
    });
</script>
</body>
</html>