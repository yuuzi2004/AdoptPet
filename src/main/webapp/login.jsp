<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - 毛孩子领养平台</title>
    <!-- 与管理员登录页统一的外部资源 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root {
            /* 统一马卡龙配色方案 */
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

        /* 返回登录类型选择页链接（统一命名+样式） */
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

        /* 切换登录类型链接（右上角） */
        .switch-login {
            position: absolute;
            top: 2rem;
            right: 2rem;
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
        }

        .switch-login:hover {
            color: #fbbf24;
            transform: translateX(5px);
        }

        /* 登录卡片样式（与管理员登录页尺寸一致） */
        .auth-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
        }

        /* 头部区域（渐变背景统一） */
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

        /* 表单区域样式统一 */
        .auth-body {
            padding: 2rem;
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
            box-shadow: 0 0 0 3px rgba(168, 230, 207, 0.2);
        }

        .input-group .icon {
            position: absolute;
            left: 0.8rem;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
        }

        /* 记住密码选项 */
        .remember-me {
            display: flex;
            align-items: center;
            margin: 1rem 0;
            font-size: 0.9rem;
        }

        .remember-me input {
            margin-right: 0.5rem;
            accent-color: var(--primary-color);
        }

        /* 登录按钮（样式与管理员登录页统一） */
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
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-auth i {
            margin-right: 0.5rem;
        }

        .btn-auth:hover {
            opacity: 0.9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(168, 230, 207, 0.4);
        }

        /* 注册链接区域（与管理员登录页风格统一） */
        .auth-link {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.9rem;
            color: #666;
        }

        .auth-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .auth-link a:hover {
            text-decoration: underline;
            color: #8bd4b8;
        }

        /* 错误提示样式统一 */
        .alert-danger {
            background-color: #ffebee;
            color: #b71c1c;
            padding: 0.8rem;
            border-radius: 8px;
            margin-bottom: 1.2rem;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            border-left: 4px solid #e53935;
        }

        .alert-danger i {
            margin-right: 0.5rem;
        }
    </style>
</head>
<body>
<!-- 返回登录类型选择页 （统一类名+样式） -->
<a href="${pageContext.request.contextPath}/login_choice.jsp" class="back-choice">
    <i class="bi bi-arrow-left me-2"></i>返回选择登录类型
</a>

<!-- 切换登录类型链接（优化样式+交互） -->
<div class="switch-login">
    <a href="${pageContext.request.contextPath}/login_choice.jsp" class="text-white">
        <i class="bi bi-exchange me-1"></i>切换登录类型
    </a>
</div>

<!-- 登录卡片（与管理员登录页结构一致） -->
<div class="auth-card">
    <div class="auth-header">
        <div class="logo">
            <i class="bi bi-person"></i> <!-- 用户专属图标 -->
        </div>
        <h2>用户登录</h2>
        <p>欢迎回到毛孩子领养平台</p>
    </div>

    <div class="auth-body">
        <!-- 错误提示（样式统一） -->
        <c:if test="${not empty error}">
            <div class="alert-danger">
                <i class="bi bi-x-circle"></i>${error}
            </div>
        </c:if>

        <!-- 用户登录表单（提交到用户登录接口） -->
        <form action="${pageContext.request.contextPath}/user/login" method="post">
            <div class="form-group">
                <label for="username">用户名</label>
                <div class="input-group">
                    <i class="bi bi-person icon"></i> <!-- 用户图标 -->
                    <input type="text"
                           class="form-control"
                           id="username"
                           name="username"
                           placeholder="请输入用户名"
                           required>
                </div>
            </div>

            <div class="form-group">
                <label for="password">密码</label>
                <div class="input-group">
                    <i class="bi bi-lock icon"></i>
                    <input type="password"
                           class="form-control"
                           id="password"
                           name="password"
                           placeholder="请输入密码"
                           required>
                </div>
            </div>

            <!-- 记住密码选项（用户登录特有，优化选中样式） -->
            <div class="remember-me">
                <input type="checkbox" id="remember" name="remember">
                <label for="remember">记住我</label>
            </div>

            <!-- 登录按钮（与管理员登录页样式一致） -->
            <button type="submit" class="btn-auth">
                <i class="bi bi-box-arrow-in-right"></i>用户登录
            </button>

            <!-- 注册链接（用户登录特有） -->
            <div class="auth-link">
                还没有账号？<a href="${pageContext.request.contextPath}/register.jsp">
                <i class="bi bi-person-plus me-1"></i>立即注册
            </a>
            </div>
        </form>
    </div>
</div>

<!-- 统一引用的脚本 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>