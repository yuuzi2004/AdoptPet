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
            --primary-color: #6366f1;
            --danger-color: #ef4444;
        }
        
        body {
            background: linear-gradient(135deg, #1e293b 0%, #334155 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }
        
        .admin-login-container {
            max-width: 450px;
            width: 100%;
        }
        
        .admin-login-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.5);
            overflow: hidden;
            border: 3px solid var(--danger-color);
        }
        
        .admin-login-header {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
            color: white;
            padding: 2.5rem;
            text-align: center;
        }
        
        .admin-login-header h2 {
            margin: 0;
            font-weight: 700;
            font-size: 1.75rem;
        }
        
        .admin-login-header p {
            margin: 0.5rem 0 0;
            opacity: 0.9;
        }
        
        .admin-login-body {
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
            border-color: var(--danger-color);
            box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
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
        
        .btn-admin-login {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
            border: none;
            border-radius: 10px;
            padding: 0.875rem;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }
        
        .btn-admin-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(239, 68, 68, 0.4);
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
        
        .security-notice {
            background: #fef2f2;
            border-left: 4px solid var(--danger-color);
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            color: #991b1b;
        }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/" class="back-home">
        <i class="bi bi-arrow-left me-2"></i>返回首页
    </a>
    
    <div class="container">
        <div class="row justify-content-center">
            <div class="admin-login-container">
                <div class="admin-login-card">
                    <div class="admin-login-header">
                        <i class="bi bi-shield-lock" style="font-size: 3rem; margin-bottom: 1rem;"></i>
                        <h2>管理员登录</h2>
                        <p>管理员专用登录入口</p>
                    </div>
                    <div class="admin-login-body">
                        <div class="security-notice">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <strong>安全提示：</strong>此页面仅限管理员访问，请勿泄露登录凭证。
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/admin/login" method="post" id="adminLoginForm">
                            <div class="mb-4">
                                <label for="adminUsername" class="form-label">管理员账号</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-shield-check"></i>
                                    </span>
                                    <input type="text" 
                                           class="form-control" 
                                           id="adminUsername" 
                                           name="username" 
                                           placeholder="请输入管理员账号" 
                                           required>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="adminPassword" class="form-label">管理员密码</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-lock"></i>
                                    </span>
                                    <input type="password" 
                                           class="form-control" 
                                           id="adminPassword" 
                                           name="password" 
                                           placeholder="请输入管理员密码" 
                                           required>
                                </div>
                            </div>
                            
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    <i class="bi bi-exclamation-triangle me-2"></i>${error}
                                </div>
                            </c:if>
                            
                            <button type="submit" class="btn btn-danger btn-admin-login w-100">
                                <i class="bi bi-box-arrow-in-right me-2"></i>管理员登录
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

