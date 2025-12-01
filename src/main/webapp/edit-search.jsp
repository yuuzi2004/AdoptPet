<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>编辑寻宠信息</title>
    <!-- 引入Bootstrap和图标库 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
<div class="container mt-5">
    <h2>编辑寻宠信息</h2>
    <!-- 表单提交到更新Servlet -->
    <form action="${pageContext.request.contextPath}/user/search/update" method="post" enctype="multipart/form-data">
        <!-- 隐藏域：传递寻宠信息id和用户id（用于权限验证） -->
        <input type="hidden" name="id" value="${search.id}">
        <input type="hidden" name="userId" value="${sessionScope.userId}">

        <div class="mb-3">
            <label for="name" class="form-label">宠物名称 *</label>
            <input type="text" class="form-control" id="name" name="name"
                   value="${search.name}" required>
        </div>

        <div class="mb-3">
            <label for="type" class="form-label">宠物类型 *</label>
            <select class="form-select" id="type" name="type" required>
                <option value="猫" ${search.type == '猫' ? 'selected' : ''}>猫</option>
                <option value="狗" ${search.type == '狗' ? 'selected' : ''}>狗</option>
                <option value="其他" ${search.type == '其他' ? 'selected' : ''}>其他</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="location" class="form-label">丢失位置 *</label>
            <input type="text" class="form-control" id="location" name="location"
                   value="${search.location}" required>
        </div>

        <div class="mb-3">
            <label for="lostTime" class="form-label">丢失时间 *</label>
            <input type="datetime-local" class="form-control" id="lostTime" name="lostTime"
                   value="<fmt:formatDate value="${search.lostTime}" pattern="yyyy-MM-dd'T'HH:mm"/>" required>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">宠物特征描述 *</label>
            <textarea class="form-control" id="description" name="description" rows="4" required>
                ${search.description}
            </textarea>
        </div>

        <div class="mb-3">
            <label for="contact" class="form-label">联系方式 *</label>
            <input type="text" class="form-control" id="contact" name="contact"
                   value="${search.contact}" required>
        </div>

        <div class="mb-3">
            <label for="image" class="form-label">宠物照片（可选）</label>
            <input type="file" class="form-control" id="image" name="image"
                   accept="image/jpeg,image/png,image/gif">
            <!-- 显示现有图片 -->
            <c:if test="${not empty search.imagePath}">
                <div class="mt-2">
                    <img src="${pageContext.request.contextPath}/${search.imagePath}"
                         alt="${search.name}" style="width: 200px; border-radius: 8px;">
                </div>
            </c:if>
        </div>

        <div class="mb-3">
            <label for="status" class="form-label">状态 *</label>
            <select class="form-select" id="status" name="status" required>
                <option value="searching" ${search.status == 'searching' ? 'selected' : ''}>寻找中</option>
                <option value="found" ${search.status == 'found' ? 'selected' : ''}>已找回</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">保存修改</button>
        <a href="${pageContext.request.contextPath}/pet/search?action=default" class="btn btn-outline-secondary ms-2">
            取消
        </a>
    </form>
</div>
</body>
</html>