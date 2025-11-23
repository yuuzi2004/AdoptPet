<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>测试页面</title>
</head>
<body>
    <h1>测试页面</h1>
    <p>如果你能看到这个页面，说明项目已正确部署！</p>
    <p>当前时间：<%= new java.util.Date() %></p>
    <p><a href="<%= request.getContextPath() %>/pet/list">访问宠物列表</a></p>
</body>
</html>

