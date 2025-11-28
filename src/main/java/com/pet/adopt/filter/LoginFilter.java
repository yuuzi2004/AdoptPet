package com.pet.adopt.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * 登录验证过滤器
 * 同时验证用户和管理员的登录状态，区分不同角色的访问权限
 */
@WebFilter(filterName = "LoginFilter", urlPatterns = "/*")
public class LoginFilter implements Filter {


    // 不需要登录验证的路径（包含用户和管理员的公开路径）
    private static final String[] EXCLUDE_PATHS = {
            // 允许匿名访问的首页（关键：保留首页可直接访问）
            "/",                  // 根路径（首页）
            "/index.jsp",         // 首页JSP


            // 登录/注册相关页面（必须保留，否则无法登录）
            "/login.jsp",         // 用户登录页
            "/register.jsp",      // 用户注册页
            "/login_choice.jsp",  // 登录选择页
            "/user/login",        // 用户登录接口
            "/user/register",     // 用户注册接口
            "/admin/login.jsp",   // 管理员登录页
            "/admin/login",       // 管理员登录接口


            // 静态资源（确保首页样式、图片正常加载）
            "/css/*",             // CSS样式
            "/js/*",              // JavaScript脚本
            "/images/*",          // 图片资源
            "/uploads/*"          // 上传的图片（如首页展示的宠物图片）
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

        // ========== 新增调试日志（关键） ==========
        System.out.println("===== 过滤器调试 =====");
        System.out.println("完整请求URI：" + requestURI);
        System.out.println("去除上下文后的路径：" + path);
        System.out.println("是否排除路径：" + isExcludedPath(path));
        System.out.println("管理员Session是否存在：" + (httpRequest.getSession(false) != null));
        if (httpRequest.getSession(false) != null) {
            System.out.println("Session中的adminId：" + httpRequest.getSession(false).getAttribute("adminId"));
        }
        // =========================================

        // 修复1：统一路径格式（移除末尾斜杠，避免 /admin/ 和 /admin 不匹配）
        if (path.endsWith("/") && path.length() > 1) {
            path = path.substring(0, path.length() - 1);
        }

        // 调试日志（可选：测试时开启，上线后删除）
        System.out.println("当前请求路径：" + path);

        // 检查是否在排除列表中（公开路径直接放行）
        if (isExcludedPath(path)) {
            chain.doFilter(request, response);
            return;
        }

        // 1. 管理员路径验证（/admin/*）
        if (path.startsWith("/admin/")) {
            HttpSession session = httpRequest.getSession(false);
            // 验证管理员登录状态（session存在且有adminId）
            boolean isAdminLogin = (session != null) && (session.getAttribute("adminId") != null);

            if (!isAdminLogin) {
                // 未登录：重定向到管理员登录页，携带原始跳转路径
                String redirectURL = contextPath + "/admin/login.jsp?redirect=" +
                        URLEncoder.encode(path, StandardCharsets.UTF_8.toString());
                httpResponse.sendRedirect(redirectURL);
                return;
            }
        }
        // 2. 普通用户路径验证
        else {
            HttpSession session = httpRequest.getSession(false);
            boolean isUserLogin = (session != null) && (session.getAttribute("userId") != null);

            if (!isUserLogin) {
                // 未登录：重定向到用户登录页，携带原始跳转路径
                String redirectURL = contextPath + "/login.jsp?redirect=" +
                        URLEncoder.encode(path, StandardCharsets.UTF_8.toString());
                httpResponse.sendRedirect(redirectURL);
                return;
            }
        }

        // 登录状态验证通过，放行请求
        chain.doFilter(request, response);
    }

    /**
     * 优化路径匹配逻辑：支持精确匹配、前缀匹配（替代通配符）
     */
    private boolean isExcludedPath(String path) {
        for (String excludePath : EXCLUDE_PATHS) {
            // 场景1：精确匹配（如 /admin/login 匹配 /admin/login）
            if (path.equals(excludePath)) {
                return true;
            }
            // 场景2：前缀匹配（如 /admin/pet/list/1 匹配 /admin/pet/list）
            if (path.startsWith(excludePath + "/")) {
                return true;
            }
            // 场景3：JSP页面与接口路径匹配（如 /admin/login 匹配 /admin/login.jsp）
            if (excludePath.endsWith(".jsp") && path.equals(excludePath.replace(".jsp", ""))) {
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