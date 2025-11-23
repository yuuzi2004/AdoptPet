@echo off
chcp 65001 >nul
echo ============================================
echo 完整重新部署项目
echo ============================================
echo.

echo 步骤 1: 清理 Maven 编译缓存...
call mvn clean
if %errorlevel% neq 0 (
    echo Maven clean 失败！
    pause
    exit /b 1
)

echo.
echo 步骤 2: 重新编译项目...
call mvn compile
if %errorlevel% neq 0 (
    echo Maven compile 失败！
    pause
    exit /b 1
)

echo.
echo 步骤 3: 打包 WAR 文件...
call mvn package
if %errorlevel% neq 0 (
    echo Maven package 失败！
    pause
    exit /b 1
)

echo.
echo ============================================
echo 构建完成！
echo ============================================
echo.
echo WAR 文件位置: target\Pet1.0.war
echo.
echo 下一步：
echo 1. 停止 Tomcat
echo 2. 删除 Tomcat webapps 中的旧部署
echo 3. 删除 Tomcat work 目录
echo 4. 重新部署项目到 Tomcat
echo 5. 启动 Tomcat
echo.
pause

