<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>编辑宠物信息</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>编辑宠物信息</h2>
    <form action="${pageContext.request.contextPath}/admin/pet/update" method="post" enctype="multipart/form-data">
        <!-- 隐藏字段存储宠物ID -->
        <input type="hidden" name="id" value="${pet.id}">

        <div class="mb-3">
            <label for="name" class="form-label">宠物名称</label>
            <input type="text" class="form-control" id="name" name="name" value="${pet.name}" required>
        </div>

        <div class="mb-3">
            <label for="type" class="form-label">宠物类型</label>
            <input type="text" class="form-control" id="type" name="type" value="${pet.type}" required>
        </div>

        <div class="mb-3">
            <label for="age" class="form-label">年龄</label>
            <input type="number" class="form-control" id="age" name="age" value="${pet.age}" required>
        </div>

        <div class="mb-3">
            <label for="gender" class="form-label">性别</label>
            <select class="form-select" id="gender" name="gender" required>
                <option value="公" ${pet.gender == '公' ? 'selected' : ''}>公</option>
                <option value="母" ${pet.gender == '母' ? 'selected' : ''}>母</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">描述信息</label>
            <textarea class="form-control" id="description" name="description" rows="3" required>${pet.description}</textarea>
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
                                 onerror="this.src='https://via.placeholder.com/200x200/a8e6cf/2d5016?text=暂无图片'">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/${pet.imagePath}" 
                                 width="200" 
                                 alt="${pet.name}"
                                 onerror="this.src='https://via.placeholder.com/200x200/a8e6cf/2d5016?text=暂无图片'">
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <img src="https://via.placeholder.com/200x200/a8e6cf/2d5016?text=暂无图片" 
                         width="200" 
                         alt="暂无图片">
                </c:otherwise>
            </c:choose>
        </div>

        <div class="mb-3">
            <label for="image" class="form-label">更换图片（可选）</label>
            <input type="file" class="form-control" id="image" name="image" accept="image/*">
        </div>

        <button type="submit" class="btn btn-primary">保存修改</button>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">取消</a>
    </form>
</div>
</body>
</html>