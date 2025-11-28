<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>选择登录类型 - 毛孩子领养平台</title>
    <!-- 与用户登录页一致的外部资源 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- 粘贴用户登录页的完整样式 -->
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

        /* 返回首页链接（与用户登录页一致） */
        .back-home {
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

        .back-home:hover {
            color: #fbbf24;
            transform: translateX(-5px);
        }

        /* 卡片容器（与用户登录页尺寸、阴影一致） */
        .auth-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            overflow: hidden;
            width: 100%;
            max-width: 450px; /* 与用户登录页宽度相同 */
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

        /* 主体区域样式（与用户登录页表单区域一致） */
        .auth-body {
            padding: 2rem;
        }

        /* 按钮样式（复用用户登录页按钮风格） */
        .btn-choice {
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
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none; /* 确保链接无下划线 */
        }

        .btn-choice i {
            margin-right: 0.5rem;
        }

        .btn-choice:hover {
            opacity: 0.9;
            transform: translateY(-2px);
            color: var(--text-color); /*  hover时文字颜色不变 */
        }
    </style>
</head>
<body>
<!-- 返回首页链接（与用户登录页位置、样式一致） -->
<a href="${pageContext.request.contextPath}/" class="back-home">
    <i class="bi bi-arrow-left me-2"></i>返回首页
</a>

<!-- 登录选择卡片（与用户登录页结构一致） -->
<div class="auth-card">
    <div class="auth-header">
        <div class="logo">
            <i class="bi bi-door-open"></i> <!-- 选择页专属图标，风格统一 -->
        </div>
        <h2>选择登录类型</h2>
        <p>请选择您的登录身份</p>
    </div>

    <div class="auth-body">
        <!-- 登录类型选择按钮（样式与用户登录页按钮一致） -->
        <a href="${pageContext.request.contextPath}/login.jsp" class="btn-choice">
            <i class="bi bi-person"></i>用户登录
        </a>

        <a href="${pageContext.request.contextPath}/admin/login.jsp" class="btn-choice">
            <i class="bi bi-shield-lock"></i>管理员登录
        </a>
    </div>
</div>

<!-- 与用户登录页一致的脚本引用 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>