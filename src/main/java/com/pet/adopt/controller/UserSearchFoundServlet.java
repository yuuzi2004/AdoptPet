package com.pet.adopt.controller;

import com.pet.adopt.entity.PetSearch;
import com.pet.adopt.service.PetSearchService;
import com.pet.adopt.service.PetSearchServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * 用户在个人中心将寻宠信息标记为“已找回”的处理 Servlet
 */
@WebServlet("/user/search/found")
public class UserSearchFoundServlet extends HttpServlet {

    private final PetSearchService petSearchService = new PetSearchServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 1. 校验登录状态
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            String msg = "请先登录后再操作";
            if (isAjax(req)) {
                writeJson(resp, false, msg);
            } else {
                resp.sendRedirect(req.getContextPath() + "/login.jsp?error=" + msg);
            }
            return;
        }
        Integer userId = (Integer) session.getAttribute("userId");

        // 2. 获取并校验参数
        String idStr = req.getParameter("id");
        Integer searchId = null;
        try {
            searchId = Integer.parseInt(idStr);
        } catch (Exception e) {
            String msg = "非法的寻宠信息ID";
            if (isAjax(req)) {
                writeJson(resp, false, msg);
            } else {
                resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + msg);
            }
            return;
        }

        // 3. 根据ID和当前用户查询寻宠信息（做权限校验）
        PetSearch petSearch = petSearchService.getPetSearchByIdAndUserId(searchId, userId);
        if (petSearch == null) {
            String msg = "未找到对应的寻宠信息或无操作权限";
            if (isAjax(req)) {
                writeJson(resp, false, msg);
            } else {
                resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + msg);
            }
            return;
        }

        // 4. 标记为“已找回”
        petSearch.setStatus("found");
        boolean success = petSearchService.updatePetSearch(petSearch);

        String successMsg = "已将「" + petSearch.getName() + "」标记为已找回";
        String errorMsg = "标记失败，请稍后重试";

        if (isAjax(req)) {
            if (success) {
                writeJson(resp, true, successMsg);
            } else {
                writeJson(resp, false, errorMsg);
            }
        } else {
            // 5. 非 Ajax：根据结果重定向回个人中心
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/user/my-pets?success=" + successMsg);
            } else {
                resp.sendRedirect(req.getContextPath() + "/user/my-pets?error=" + errorMsg);
            }
        }
    }

    // 判断是否为 Ajax 请求
    private boolean isAjax(HttpServletRequest req) {
        String requestedWith = req.getHeader("X-Requested-With");
        return requestedWith != null && "XMLHttpRequest".equalsIgnoreCase(requestedWith);
    }

    // 输出 JSON 响应
    private void writeJson(HttpServletResponse resp, boolean success, String message) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        String json = String.format("{\"success\":%s,\"message\":\"%s\"}",
                success ? "true" : "false",
                message == null ? "" : message.replace("\"", "\\\""));
        resp.getWriter().write(json);
    }
}


