@echo off
chcp 65001 >nul
echo ============================================
echo 404 错误排查工具
echo ============================================
echo.

echo 步骤 1: 检查项目是否编译成功...
if exist "target\classes\com\pet\adopt\controller\PetListServlet.class" (
    echo [√] PetListServlet.class 存在
) else (
    echo [×] PetListServlet.class 不存在！
    echo 请运行: mvn clean compile
    pause
    exit /b 1
)

echo.
echo 步骤 2: 检查 WAR 文件...
if exist "target\Pet1.0.war" (
    echo [√] Pet1.0.war 存在
) else (
    echo [×] Pet1.0.war 不存在！
    echo 请运行: mvn package
    pause
    exit /b 1
)

echo.
echo 步骤 3: 检查 web.xml...
if exist "src\main\webapp\WEB-INF\web.xml" (
    echo [√] web.xml 存在
) else (
    echo [×] web.xml 不存在！
    pause
    exit /b 1
)

echo.
echo ============================================
echo 检查完成！
echo ============================================
echo.
echo 请确认：
echo 1. 使用的是 Tomcat 9（不是 Tomcat 10）
echo 2. 项目已正确部署到 Tomcat
echo 3. 访问路径：http://localhost:8080/Pet1.0/pet/list
echo 4. 或先测试：http://localhost:8080/Pet1.0/test.jsp
echo.
pause

