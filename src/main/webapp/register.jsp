<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册 - 毛孩子领养平台</title>
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

        /* 返回首页链接 - 与登录页一致 */
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

        /* 主卡片容器 - 比登录页宽，保持相同圆角和阴影 */
        .auth-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            overflow: hidden;
            width: 100%;
            max-width: 800px; /* 比登录页宽 */
        }

        /* 头部区域 - 与登录页完全一致 */
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

        /* 表单区域 - 两列布局 */
        .auth-body {
            padding: 2rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        /* 表单元素样式 - 与登录页一致 */
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #333;
            font-size: 0.9rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
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

        .input-group {
            position: relative;
        }

        .input-group .form-control {
            padding-left: 2.5rem;
        }

        .input-group .icon {
            position: absolute;
            left: 0.8rem;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
        }

        .password-strength {
            font-size: 0.8rem;
            color: #666;
            margin-top: 0.3rem;
        }

        /* 按钮样式 - 与登录页一致 */
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
        }

        .btn-auth:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        /* 链接区域 - 与登录页一致 */
        .auth-link {
            text-align: center;
            margin-top: 1.2rem;
            font-size: 0.9rem;
            color: #666;
        }

        .auth-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .auth-link a:hover {
            text-decoration: underline;
        }

        /* 提示信息样式 */
        .alert {
            padding: 0.8rem;
            border-radius: 8px;
            margin-bottom: 1.2rem;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
        }

        .alert i {
            margin-right: 0.5rem;
        }

        .alert-danger {
            background-color: #ffebee;
            color: #b71c1c;
        }

        .alert-success {
            background-color: #e8f5e9;
            color: #2e7d32;
        }

        /* 适配移动端 - 屏幕小时恢复单列 */
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .auth-card {
                max-width: 90%;
            }
        }
    </style>
</head>
<body>
<a href="${pageContext.request.contextPath}/" class="back-home">
    <i class="bi bi-arrow-left me-2"></i>返回首页
</a>

<div class="auth-card">
    <div class="auth-header">
        <div class="logo">
            <i class="bi bi-person-plus"></i>
        </div>
        <h2>用户注册</h2>
        <p>加入我们，开启领养之旅</p>
    </div>

    <div class="auth-body">
        <form action="${pageContext.request.contextPath}/user/register" method="post" id="registerForm">
            <!-- 提示信息 -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle me-2"></i>${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="bi bi-check-circle me-2"></i>${success}
                </div>
            </c:if>

            <!-- 两列表单布局 -->
            <div class="form-grid">
                <!-- 第一列 -->
                <div class="form-group">
                    <label for="username">用户名 <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <i class="bi bi-person icon"></i>
                        <input type="text"
                               class="form-control"
                               id="username"
                               name="username"
                               placeholder="请输入用户名（3-20个字符）"
                               required
                               minlength="3"
                               maxlength="20">
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">邮箱 <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <i class="bi bi-envelope icon"></i>
                        <input type="email"
                               class="form-control"
                               id="email"
                               name="email"
                               placeholder="请输入邮箱地址"
                               required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="phone">手机号 <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <i class="bi bi-phone icon"></i>
                        <input type="tel"
                               class="form-control"
                               id="phone"
                               name="phone"
                               placeholder="请输入手机号"
                               required
                               pattern="[0-9]{11}">
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">密码 <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <i class="bi bi-lock icon"></i>
                        <input type="password"
                               class="form-control"
                               id="password"
                               name="password"
                               placeholder="请输入密码（至少6位）"
                               required
                               minlength="6">
                    </div>
                    <small class="password-strength">密码长度至少6位</small>
                </div>

                <!-- 第二列将自动填充剩余空间，这里密码确认跨列显示 -->
            </div>

            <!-- 确认密码占满整行 -->
            <div class="form-group" style="margin-top: 1.5rem;">
                <label for="confirmPassword">确认密码 <span class="text-danger">*</span></label>
                <div class="input-group">
                    <i class="bi bi-lock-fill icon"></i>
                    <input type="password"
                           class="form-control"
                           id="confirmPassword"
                           name="confirmPassword"
                           placeholder="请再次输入密码"
                           required>
                </div>
            </div>

            <!-- 注册按钮 -->
            <button type="submit" class="btn-auth">
                <i class="bi bi-person-plus me-2"></i>立即注册
            </button>

            <!-- 登录链接 -->
            <div class="auth-link">
                已有账号？<a href="${pageContext.request.contextPath}/login.jsp">
                <i class="bi bi-box-arrow-in-right me-1"></i>立即登录
            </a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            e.preventDefault();
            // 显示错误提示
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-danger';
            alertDiv.innerHTML = '<i class="bi bi-exclamation-triangle me-2"></i>两次输入的密码不一致，请重新输入！';

            const form = document.getElementById('registerForm');
            const firstChild = form.firstChild;
            if (firstChild.classList && firstChild.classList.contains('alert')) {
                form.replaceChild(alertDiv, firstChild);
            } else {
                form.insertBefore(alertDiv, firstChild);
            }

            document.getElementById('confirmPassword').focus();
            document.getElementById('confirmPassword').value = '';

            // 3秒后移除提示
            setTimeout(() => {
                alertDiv.remove();
            }, 3000);

            return false;
        }
    });
</script>
</body>
</html>