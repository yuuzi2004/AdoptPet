@echo off
chcp 65001 >nul
echo ============================================
echo MySQL Root 密码重置工具
echo ============================================
echo.
echo 警告：此操作需要管理员权限！
echo.
pause

echo.
echo 步骤 1: 停止 MySQL 服务...
net stop MySQL
if %errorlevel% neq 0 (
    echo 无法停止 MySQL 服务，请检查服务名是否正确
    echo 常见服务名：MySQL、MySQL80、MySQL57
    echo.
    echo 请手动在"服务"中停止 MySQL 服务，然后按任意键继续...
    pause
)

echo.
echo 步骤 2: 以跳过权限表方式启动 MySQL...
echo 注意：会打开一个新窗口，请保持该窗口打开！
start "MySQL Skip Grant Tables" cmd /k "cd /d %~dp0 && mysqld --skip-grant-tables"

echo.
echo 等待 5 秒让 MySQL 启动...
timeout /t 5 /nobreak >nul

echo.
echo 步骤 3: 请输入新密码：
set /p new_password=

echo.
echo 正在重置密码...
(
    echo USE mysql;
    echo ALTER USER 'root'@'localhost' IDENTIFIED BY '%new_password%';
    echo FLUSH PRIVILEGES;
    echo EXIT;
) | mysql -u root

echo.
echo 步骤 4: 关闭跳过权限表的 MySQL 窗口，然后按任意键继续...
pause

echo.
echo 步骤 5: 启动 MySQL 服务...
net start MySQL

echo.
echo ============================================
echo 密码重置完成！
echo ============================================
echo.
echo 新密码：%new_password%
echo.
echo 请修改 src/main/resources/db.properties 文件：
echo jdbc.password=%new_password%
echo.
pause

