package com.pet.adopt.utils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class JdbcUtils {
    // 存储数据库配置信息
    private static String driver;
    private static String url;
    private static String username;
    private static String password;

    // 静态代码块：程序启动时只执行一次，加载配置文件
    static {
        try {
            // 1. 读取 db.properties 配置文件
            Properties props = new Properties();
            // 通过类加载器读取 resources 下的文件
            InputStream is = JdbcUtils.class.getClassLoader().getResourceAsStream("db.properties");
            props.load(is);

            // 2. 提取配置信息
            driver = props.getProperty("jdbc.driver");
            url = props.getProperty("jdbc.url");
            username = props.getProperty("jdbc.username");
            password = props.getProperty("jdbc.password");

            // 3. 加载数据库驱动
            Class.forName(driver);
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("数据库配置加载失败！");
        }
    }

    // 获得数据库连接
    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            e.printStackTrace();
            // 显示详细的错误信息，方便排查问题
            String errorMsg = "获取数据库连接失败！\n" +
                    "错误详情: " + e.getMessage() + "\n" +
                    "数据库URL: " + url + "\n" +
                    "用户名: " + username + "\n" +
                    "常见原因：\n" +
                    "1. MySQL 服务未启动\n" +
                    "2. 数据库 'pet_adopt' 不存在\n" +
                    "3. 用户名或密码错误\n" +
                    "4. MySQL 端口不是 3306";
            throw new RuntimeException(errorMsg, e);
        }
    }

    // 关闭资源（重载：处理 连接+预处理语句+结果集）
    public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 关闭资源（重载：处理 连接+预处理语句，无结果集时用）
    public static void close(Connection conn, PreparedStatement pstmt) {
        close(conn, pstmt, null);
    }
}