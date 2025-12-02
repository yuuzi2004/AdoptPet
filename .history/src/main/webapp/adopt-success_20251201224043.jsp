<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>申请提交成功 - 毛孩子领养平台</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root {
            /* 与薄巧色主题保持一致 */
            --primary-color: #a8e6cf; /* 薄荷绿 */
            --secondary-color: #ffd3d3; /* 粉红 */
            --accent-color: #c7ecee; /* 淡蓝 */
            --success-color: #10b981;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            /* 背景改为与寻找宠物等页面统一的薄巧色渐变 */
            background: linear-gradient(135deg, #e8f5e9 0%, #f1f8e9 50%, #fff9c4 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        
        .success-container {
            max-width: 600px;
            margin: 0 auto;
        }
        
        .success-card {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
            padding: 3rem;
            text-align: center;
        }
        
        .success-icon {
            width: 100px;
            height: 100px;
            margin: 0 auto 2rem;
            background: linear-gradient(135deg, var(--success-color), #059669);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: white;
            animation: scaleIn 0.5s ease-out;
        }
        
        @keyframes scaleIn {
            from {
                transform: scale(0);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }
        
        .success-title {
            font-size: 2rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 1rem;
        }
        
        .success-message {
            color: #6b7280;
            margin-bottom: 2rem;
            line-height: 1.8;
        }
        
        .pet-info {
            background: #f9fafb;
            border-radius: 12px;
            padding: 1.5rem;
            margin: 2rem 0;
            text-align: left;
        }
        
        .btn-action {
            border-radius: 10px;
            padding: 0.875rem 2rem;
            font-weight: 600;
            margin: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-container">
            <div class="success-card">
                <div class="success-icon">
                    <i class="bi bi-check-circle-fill"></i>
                </div>
                <h1 class="success-title">申请提交成功！</h1>
                <p class="success-message">
                    您的领养申请已成功提交，我们会在3个工作日内审核并与您联系。<br>
                    请保持联系方式畅通，感谢您的爱心！
                </p>
                
                <c:if test="${not empty pet}">
                    <div class="pet-info">
                        <h5 class="mb-3"><i class="bi bi-heart-fill text-danger me-2"></i>申请领养的宠物</h5>
                        <p class="mb-2"><strong>名称：</strong>${pet.name}</p>
                        <p class="mb-2"><strong>类型：</strong>${pet.type}</p>
                        <p class="mb-0"><strong>年龄：</strong>${pet.age}岁 | <strong>性别：</strong>${pet.gender}</p>
                    </div>
                </c:if>
                
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/pet/list" class="btn btn-primary btn-action">
                        <i class="bi bi-list-ul me-2"></i>返回领养列表
                    </a>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary btn-action">
                        <i class="bi bi-house me-2"></i>返回首页
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

