@echo off
chcp 65001 >nul
echo ============================================
echo MySQL 连接测试工具
echo ============================================
echo.
echo 这个脚本会帮你测试 MySQL 连接
echo.

:input
echo 请输入 MySQL root 密码（直接回车尝试空密码）：
set /p mysql_password=

if "%mysql_password%"=="" (
    echo.
    echo 正在测试空密码连接...
    mysql -u root -e "SELECT '连接成功！' AS result;" 2>nul
) else (
    echo.
    echo 正在测试密码: %mysql_password%
    mysql -u root -p%mysql_password% -e "SELECT '连接成功！' AS result;" 2>nul
)

if %errorlevel% == 0 (
    echo.
    echo ============================================
    echo ✓ 连接成功！
    echo ============================================
    echo.
    if "%mysql_password%"=="" (
        echo 你的 MySQL root 密码是：空密码（无密码）
        echo.
        echo 请修改 src/main/resources/db.properties 文件：
        echo jdbc.password=
    ) else (
        echo 你的 MySQL root 密码是：%mysql_password%
        echo.
        echo 请修改 src/main/resources/db.properties 文件：
        echo jdbc.password=%mysql_password%
    )
    echo.
    pause
    exit /b 0
) else (
    echo.
    echo ✗ 连接失败！密码不正确。
    echo.
    echo 请尝试：
    echo 1. 检查密码是否正确
    echo 2. 检查 MySQL 服务是否运行
    echo 3. 或者重置 MySQL 密码
    echo.
    set /p retry="是否重试？(Y/N): "
    if /i "%retry%"=="Y" goto input
    if /i "%retry%"=="y" goto input
)

pause

