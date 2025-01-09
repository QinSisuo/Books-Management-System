package com.book; // 调整包名以匹配你的项目结构

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

public class JDBCDriverUnloader implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // 应用启动时可以在这里执行一些初始化操作
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
                System.out.println("成功卸载JDBC驱动: " + driver);
            } catch (SQLException ex) {
                System.out.println("卸载JDBC驱动时出现错误: " + driver + " - " + ex.getMessage());
            }
        }
    }
}