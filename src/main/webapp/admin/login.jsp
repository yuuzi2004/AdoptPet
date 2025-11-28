<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员登录 - 毛孩子领养平台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #a8e6cf; /* 薄荷绿 */
            --secondary-color: #ffd3d3; /* 粉红 */
            --accent-color: #c7ecee; /* 淡蓝 */
            --text-color: #2d5016; /* 文字主色 */
        }

        body {
            background: linear-gradient(135deg, #a8e6cf 0%, #c7ecee 50%, #ffd3d3 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            padding: 2rem 0;
            position: relative;
            margin: 0;
        }

        /* 返回登录类型选择页 */
        .back-choice {
            position: absolute;
            top: 2rem;
            left: 2rem;
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .back-choice:hover {
            color: #fbbf24;
            transform: translateX(-5px);
        }

        /* 登录卡片 */
        .auth-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
        }

        /* 头部区域 */
        .auth-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--accent-color) 50%, var(--secondary-color) 100%);
            color: var(--text-color);
            padding: 1.8rem;
            text-align: center;
        }

        .auth-header .logo {
            font-size: 2.5rem;
            margin-bottom: 0.8rem;
        }

        .auth-header h2 {
            margin: 0;
            font-weight: 600;
            font-size: 1.6rem;
        }

        .auth-header p {
            margin: 0.3rem 0 0;
            font-size: 0.95rem;
            opacity: 0.9;
        }

        /* 表单区域 */
        .auth-body {
            padding: 2rem;
        }

        .security-alert {
            background-color: #fff5f5;
            border-left: 4px solid var(--primary-color);
            padding: 0.8rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            color: #6b2121;
            display: flex;
            align-items: center;
        }

        .security-alert i {
            margin-right: 0.5rem;
            color: var(--primary-color);
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #333;
            font-size: 0.9rem;
        }

        .input-group {
            position: relative;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 0.75rem 0.75rem 2.5rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 0.9rem;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            outline: none;
        }

        .input-group .icon {
            position: absolute;
            left: 0.8rem;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
        }

        .btn-auth {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 8px;
            padding: 0.8rem;
            font-weight: 600;
            color: var(--text-color);
            width: 100%;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 1rem;
            margin-top: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-auth:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        .alert-danger {
            background-color: #ffebee;
            color: #b71c1c;
            padding: 0.8rem;
            border-radius: 8px;
            margin-bottom: 1.2rem;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
        }

        .alert-danger i {
            margin-right: 0.5rem;
        }
    </style>
</head>
<body>
<!-- 返回登录类型选择页 -->
<a href="${pageContext.request.contextPath}/login_choice.jsp" class="back-choice">
    <i class="bi bi-arrow-left me-2"></i>返回选择登录类型
</a>

<!-- 登录卡片 -->
<div class="auth-card">
    <div class="auth-header">
        <div class="logo">
            <i class="bi bi-shield-lock"></i>
        </div>
        <h2>管理员登录</h2>
        <p>管理员专用登录入口</p>
    </div>

    <div class="auth-body">
        <!-- 安全提示 -->
        <div class="security-alert">
            <i class="bi bi-exclamation-triangle"></i>
            安全提示：此页面仅限管理员访问，请勿泄露登录凭证
        </div>

        <!-- 错误提示 -->
        <c:if test="${not empty error}">
            <div class="alert-danger">
                <i class="bi bi-x-circle"></i>${error}
            </div>
        </c:if>

        <!-- 管理员登录表单（与你的Servlet参数匹配：name="username"/"password"） -->
        <form action="${pageContext.request.contextPath}/admin/login" method="post">
            <div class="form-group">
                <label for="username">管理员账号</label>
                <div class="input-group">
                    <i class="bi bi-person-badge icon"></i>
                    <input type="text"
                           class="form-control"
                           id="username"
                           name="username"
                           placeholder="请输入管理员账号"
                           required>
                </div>
            </div>

            <div class="form-group">
                <label for="password">管理员密码</label>
                <div class="input-group">
                    <i class="bi bi-lock icon"></i>
                    <input type="password"
                           class="form-control"
                           id="password"
                           name="password"
                           placeholder="请输入管理员密码"
                           required>
                </div>
            </div>

            <button type="submit" class="btn-auth">
                <i class="bi bi-box-arrow-in-right"></i>管理员登录
            </button>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>