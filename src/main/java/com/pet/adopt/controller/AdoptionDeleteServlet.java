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
import java.io.PrintWriter;

/**
 * 处理领养申请删除的Servlet
 * 支持GET和POST方法，避免405错误
 */
@WebServlet("/adoption/delete")
public class AdoptionDeleteServlet extends HttpServlet {
    // 实例化Service对象（与你现有代码风格一致）
    private AdoptionService adoptionService = new AdoptionServiceImpl();

    // 处理GET请求（适配链接点击删除）
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processDelete(req, resp);
    }

    // 处理POST请求（适配AJAX无刷新删除）
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processDelete(req, resp);
    }

    // 统一的删除处理逻辑
    private void processDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // 设置响应内容类型为JSON（方便前端处理）
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        // 1. 获取要删除的申请ID
        String applicationIdStr = req.getParameter("applicationId");
        if (applicationIdStr == null || applicationIdStr.isEmpty()) {
            out.write("{\"success\": false, \"msg\": \"参数错误：缺少申请ID\"}");
            return;
        }

        // 2. 转换申请ID为整数（处理格式错误）
        Integer applicationId;
        try {
            applicationId = Integer.parseInt(applicationIdStr);
        } catch (NumberFormatException e) {
            out.write("{\"success\": false, \"msg\": \"参数错误：无效的ID格式\"}");
            return;
        }

        // 3. 获取当前登录用户ID（权限验证）
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            out.write("{\"success\": false, \"msg\": \"请先登录\"}");
            return;
        }

        // 4. 调用Service层删除方法（仅能删除自己的申请）
        int rows = adoptionService.deleteByIdAndUserId(applicationId, userId);

        // 5. 返回处理结果（JSON格式）
        if (rows > 0) {
            out.write("{\"success\": true, \"msg\": \"删除成功\"}");
        } else {
            out.write("{\"success\": false, \"msg\": \"删除失败，可能是没有权限或申请不存在\"}");
        }
    }
}