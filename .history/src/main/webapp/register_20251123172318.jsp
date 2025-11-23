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
            --primary-color: #6366f1;
            --secondary-color: #8b5cf6;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            padding: 2rem 0;
        }
        
        .register-container {
            max-width: 500px;
            width: 100%;
        }
        
        .register-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .register-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 2.5rem;
            text-align: center;
        }
        
        .register-header h2 {
            margin: 0;
            font-weight: 700;
            font-size: 1.75rem;
        }
        
        .register-header p {
            margin: 0.5rem 0 0;
            opacity: 0.9;
        }
        
        .register-body {
            padding: 2.5rem;
        }
        
        .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.75rem;
        }
        
        .form-control {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            border: 2px solid #e5e7eb;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }
        
        .input-group-text {
            background: #f9fafb;
            border: 2px solid #e5e7eb;
            border-right: none;
            border-radius: 10px 0 0 10px;
        }
        
        .input-group .form-control {
            border-left: none;
            border-radius: 0 10px 10px 0;
        }
        
        .btn-register {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 10px;
            padding: 0.875rem;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(99, 102, 241, 0.4);
        }
        
        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            color: #6b7280;
        }
        
        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        .back-home {
            position: absolute;
            top: 2rem;
            left: 2rem;
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .back-home:hover {
            color: #fbbf24;
            transform: translateX(-5px);
        }
        
        .password-strength {
            font-size: 0.85rem;
            margin-top: 0.5rem;
        }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/" class="back-home">
        <i class="bi bi-arrow-left me-2"></i>返回首页
    </a>
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="register-container">
                <div class="register-card">
                    <div class="register-header">
                        <i class="bi bi-person-plus" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                        <h2>用户注册</h2>
                        <p>加入我们，开启领养之旅</p>
                    </div>
                    <div class="register-body">
                        <form action="${pageContext.request.contextPath}/user/register" method="post" id="registerForm">
                            <div class="mb-3">
                                <label for="username" class="form-label">用户名 <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-person"></i>
                                    </span>
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
                            
                            <div class="mb-3">
                                <label for="email" class="form-label">邮箱 <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-envelope"></i>
                                    </span>
                                    <input type="email" 
                                           class="form-control" 
                                           id="email" 
                                           name="email" 
                                           placeholder="请输入邮箱地址" 
                                           required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="phone" class="form-label">手机号 <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-phone"></i>
                                    </span>
                                    <input type="tel" 
                                           class="form-control" 
                                           id="phone" 
                                           name="phone" 
                                           placeholder="请输入手机号" 
                                           required
                                           pattern="[0-9]{11}">
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="password" class="form-label">密码 <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-lock"></i>
                                    </span>
                                    <input type="password" 
                                           class="form-control" 
                                           id="password" 
                                           name="password" 
                                           placeholder="请输入密码（至少6位）" 
                                           required
                                           minlength="6">
                                </div>
                                <small class="password-strength text-muted">密码长度至少6位</small>
                            </div>
                            
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">确认密码 <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-lock-fill"></i>
                                    </span>
                                    <input type="password" 
                                           class="form-control" 
                                           id="confirmPassword" 
                                           name="confirmPassword" 
                                           placeholder="请再次输入密码" 
                                           required>
                                </div>
                            </div>
                            
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    <i class="bi bi-exclamation-triangle me-2"></i>${error}
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty success}">
                                <div class="alert alert-success" role="alert">
                                    <i class="bi bi-check-circle me-2"></i>${success}
                                </div>
                            </c:if>
                            
                            <button type="submit" class="btn btn-primary btn-register w-100">
                                <i class="bi bi-person-plus me-2"></i>立即注册
                            </button>
                        </form>
                        
                        <div class="login-link">
                            已有账号？<a href="${pageContext.request.contextPath}/login.jsp">
                                <i class="bi bi-box-arrow-in-right me-1"></i>立即登录
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 密码确认验证
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('两次输入的密码不一致，请重新输入！');
                document.getElementById('confirmPassword').focus();
                return false;
            }
        });
    </script>
</body>
</html>

