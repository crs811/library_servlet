package com.crs811.library.util;

import java.sql.*;
import java.util.Objects;

public class JdbcUtils {

    static String driverClassName= "com.mysql.cj.jdbc.Driver";
    static String ip = "localhost";
    static String port = "3306";
    static String database = "library";       // 数据库名称
    static String encoding = "utf8";
    static String serverTimezone = "UTC";
    static String username = "root";          // 数据库用户名
    static String password = "123456";        // 数据库密码

    public static Connection conn = null;
    public static PreparedStatement ps = null;

    /**
     * 数据库连接
     * @return
     */
    public static Connection init()  throws SQLException {
        // System.out.println("DBConn.init - Initializing database connection..."+conn);
        if (conn == null || conn.isClosed()) {
            try {
                Class.forName(driverClassName);
                String url = String.format("jdbc:mysql://%s:%s/%s?serverTimezone=%s&useUnicode=true&characterEncoding=%s&useSSL=false",
                        ip, port, database, serverTimezone, encoding);
                conn = DriverManager.getConnection(url, username, password);
            } catch (Exception e) {
                System.out.println("DBConn.init - SQL driver initialization failed!");
                e.printStackTrace();
            }
        }
        return conn;
    }

    /**
     * 关闭资源
     * @param conn
     * @param sta
     */
    public static void close(Connection conn, Statement sta, ResultSet rs) {
        try {
            // 关闭ResultSet
            if (rs!= null &&!rs.isClosed()) {
                rs.close();
            }
            // 关闭Statement
            if (sta!= null &&!sta.isClosed()) {
                sta.close();
            }
            // 关闭Connection
            if (conn!= null &&!conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 执行查询
     * @param sql
     * @param parameters
     * @return
     */
    public static int executeSql(String sql, Object...parameters) {
        try {
            // 获取数据库库连接
            conn = init();
            // 创建Statement对象
            ps = conn.prepareStatement(sql);
            // 设置sql中的参数
            if (Objects.nonNull(parameters) && parameters.length > 0) {
                for (int i = 0; i < parameters.length; i++) {
                    ps.setObject(i+1, parameters[i]);
                }
            }
            // 返回结果数量
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(conn, ps,null);
        }
        return 0;
    }

    /**
     * 执行增加、修改、删除
     * @param sql
     * @param parameters
     * @return
     */
    public static ResultSet selectSql(String sql, Object...parameters) throws SQLException {
        // 获取数据库库连接
        conn = init();
        // 创建Statement对象
        ps = conn.prepareStatement(sql);
        // 设置sql中的参数
        if (Objects.nonNull(parameters) && parameters.length > 0) {
            for (int i = 0; i < parameters.length; i++) {
                ps.setObject(i+1, parameters[i]);
            }
        }
        // 返回结果集
        return ps.executeQuery();
    }
}
