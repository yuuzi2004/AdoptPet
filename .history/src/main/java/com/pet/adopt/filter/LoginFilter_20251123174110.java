package com.pet.adopt.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 登录验证过滤器
 * 拦截需要登录才能访问的页面和操作
 */
@WebFilter(filterName = "LoginFilter", urlPatterns = {
    "/pet/adopt/*",
    "/pet/add",
    "/adopt.jsp",
    "/add.jsp"
})
public class LoginFilter implements Filter {
    
    // 不需要登录验证的路径
    private static final String[] EXCLUDE_PATHS = {
        "/login.jsp",
        "/register.jsp",
        "/user/login",
        "/user/register",
        "/pet/list",
        "/",
        "/index.jsp"
    };
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化方法
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        // 检查是否在排除列表中
        if (isExcludedPath(path)) {
            chain.doFilter(request, response);
            return;
        }
        
        // 检查用户是否已登录
        HttpSession session = httpRequest.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            // 未登录，重定向到登录页面，并保存原始请求URL
            String redirectURL = contextPath + "/login.jsp?redirect=" + 
                                java.net.URLEncoder.encode(path, "UTF-8");
            httpResponse.sendRedirect(redirectURL);
            return;
        }
        
        // 已登录，继续处理请求
        chain.doFilter(request, response);
    }
    
    private boolean isExcludedPath(String path) {
        for (String excludePath : EXCLUDE_PATHS) {
            if (path.equals(excludePath) || path.startsWith(excludePath + "/")) {
                return true;
            }
        }
        return false;
    }
    
    @Override
    public void destroy() {
        // 销毁方法
    }
}

