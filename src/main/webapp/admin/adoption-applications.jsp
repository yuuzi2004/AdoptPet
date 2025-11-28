<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>领养申请管理</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>领养申请列表</h2>
    <table class="table table-striped">
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
                        <a href="${pageContext.request.contextPath}/admin/adoption/process?id=${app.id}&status=1" class="btn btn-success btn-sm">同意</a>
                        <a href="${pageContext.request.contextPath}/admin/adoption/process?id=${app.id}&status=2" class="btn btn-danger btn-sm">拒绝</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>