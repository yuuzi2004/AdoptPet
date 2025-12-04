package com.pet.adopt.controller;

import com.pet.adopt.service.AdoptionService;
import com.pet.adopt.service.AdoptionServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// 管理员领养申请的访问路径：/admin/adoption/*
@WebServlet("/admin/adoption/*")
public class AdminAdoptionServlet extends HttpServlet {
    // 注入领养申请服务
    private AdoptionService adoptionService = new AdoptionServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // 首先检查管理员是否登录（新增的权限验证）
        HttpSession session = req.getSession();
        if (session.getAttribute("adminId") == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
            return;
        }

        // 获取请求路径的后缀
        String pathInfo = req.getPathInfo();

        try {
            // 1. 管理员查看所有领养申请列表
            if (pathInfo == null || pathInfo.equals("/")) {
                // 调用Service查询所有申请，传递到JSP页面
                var applications = adoptionService.getAllApplications();
                req.setAttribute("applications", applications);
                // 转发到管理员领养申请页面
                req.getRequestDispatcher("/admin/adoption-applications.jsp").forward(req, resp);
            }
            // 2. 管理员处理申请（同意/拒绝）
            else if (pathInfo.equals("/process")) {
                // 获取申请ID和处理状态（approved/rejected）
                String idStr = req.getParameter("id");
                String status = req.getParameter("status");

                if (idStr != null && status != null) {
                    try {
                        int id = Integer.parseInt(idStr);
                        // 调用Service更新申请状态
                        adoptionService.processApplication(id, status);
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                        req.setAttribute("error", "无效的申请ID格式");
                        req.getRequestDispatcher("/admin/adoption-applications.jsp").forward(req, resp);
                        return;
                    }
                } else {
                    req.setAttribute("error", "缺少申请ID或处理状态参数");
                    req.getRequestDispatcher("/admin/adoption-applications.jsp").forward(req, resp);
                    return;
                }
                // 处理完成后，重定向回申请列表页
                resp.sendRedirect(req.getContextPath() + "/admin/adoption");
            } else {
                // 处理未知路径
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            // 捕获所有异常并显示错误信息
            e.printStackTrace();
            req.setAttribute("error", "加载领养申请失败：" + e.getMessage());
            req.getRequestDispatcher("/admin/adoption-applications.jsp").forward(req, resp);
        }
    }
}