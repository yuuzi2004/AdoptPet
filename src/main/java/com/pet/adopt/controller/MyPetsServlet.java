package com.pet.adopt.controller;

import com.pet.adopt.entity.Pet;
import com.pet.adopt.entity.AdoptionApplication;
import com.pet.adopt.entity.PetSearch;
import com.pet.adopt.service.PetService;
import com.pet.adopt.service.PetServiceImpl;
import com.pet.adopt.service.AdoptionApplicationService;
import com.pet.adopt.service.AdoptionApplicationServiceImpl;
import com.pet.adopt.service.PetSearchService;
import com.pet.adopt.service.PetSearchServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/my-pets")
public class MyPetsServlet extends HttpServlet {
    private PetService petService = new PetServiceImpl();
    private AdoptionApplicationService adoptionService = new AdoptionApplicationServiceImpl();
    private PetSearchService petSearchService = new PetSearchServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html;charset=UTF-8");

            System.out.println("===== MyPetsServlet 开始处理请求 =====");

            // 1. 检查用户是否已登录
            HttpSession session = req.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                System.out.println("用户未登录，重定向到登录页");
                resp.sendRedirect(req.getContextPath() + "/login.jsp?redirect=" +
                        req.getRequestURI());
                return;
            }

            // 2. 获取当前用户ID
            Integer userId = (Integer) session.getAttribute("userId");
            System.out.println("当前用户ID：" + userId);

            // 3. 查询该用户发布的所有宠物信息
            System.out.println("开始查询宠物信息...");
            List<Pet> petList = petService.findPetsByUserId(userId);
            req.setAttribute("petList", petList);
            System.out.println("查询到 " + (petList != null ? petList.size() : 0) + " 条宠物信息");

            // 新增：4. 查询该用户的所有领养申请记录 + 关联Pet对象（核心修改）
            System.out.println("开始查询领养申请记录...");
            List<AdoptionApplication> applicationList = adoptionService.getApplicationsByUserId(userId);
            // 关键：给每个领养申请关联对应的Pet对象
            if (applicationList != null && !applicationList.isEmpty()) {
                for (AdoptionApplication app : applicationList) {
                    if (app.getPetId() != null) {
                        // 根据petId查询宠物信息，设置到申请对象中
                        Pet pet = petService.findPetById(app.getPetId());
                        app.setPet(pet);
                        System.out.println("申请ID：" + app.getId() + " 关联宠物：" + (pet != null ? pet.getName() : "无"));
                    }
                }
            }
            req.setAttribute("applicationList", applicationList);
            System.out.println("查询到 " + (applicationList != null ? applicationList.size() : 0) + " 条领养申请");

            // 新增：5. 查询该用户发布的所有寻宠信息
            System.out.println("开始查询寻宠信息...");
            List<PetSearch> myPetSearchList = petSearchService.getMyPetSearchList(userId);
            req.setAttribute("myPetSearchList", myPetSearchList);
            System.out.println("查询到 " + (myPetSearchList != null ? myPetSearchList.size() : 0) + " 条寻宠信息");

            // 6. 转发到个人中心页面
            System.out.println("准备转发到 /my-pets.jsp");
            req.getRequestDispatcher("/my-pets.jsp").forward(req, resp);
            System.out.println("转发完成");
        } catch (Exception e) {
            System.err.println("===== MyPetsServlet 发生异常 =====");
            e.printStackTrace();
            // 输出错误信息到响应
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<html><body>");
            resp.getWriter().println("<h2>页面加载出错</h2>");
            resp.getWriter().println("<p>错误信息：" + e.getMessage() + "</p>");
            resp.getWriter().println("<pre>");
            e.printStackTrace(resp.getWriter());
            resp.getWriter().println("</pre>");
            resp.getWriter().println("</body></html>");
        }
    }
}