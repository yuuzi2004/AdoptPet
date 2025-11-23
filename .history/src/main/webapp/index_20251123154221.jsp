<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 重定向到宠物列表页面
    response.sendRedirect(request.getContextPath() + "/pet/list");
%>