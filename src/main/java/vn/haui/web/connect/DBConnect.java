package vn.haui.web.connect;

import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

import javax.naming.NamingException;
import java.sql.*;
import java.util.Properties;

public class DBConnect {
    private static String user;
    private static String password;
    private static String url;
    private static String port;
    private static String dbname;
    private Connection conn;
    public static Connection getConnecttion2() {
        Connection cons = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            cons = DriverManager.getConnection("jdbc:mysql://localhost:3306/tintuc", "root", "");
            //cons = DriverManager.getConnection("jdbc:mysql://"+url+"/"+dbname, user, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        StackTraceElement[] st = Thread.currentThread().getStackTrace();
        System.out.println("create connection called from " + st[2]);
        return cons;
    }
    public static Connection getConnecttion() {
        readFileProperties();
        Connection cons = null;
        MysqlDataSource mysqlDataSource=new MysqlDataSource();
        mysqlDataSource.setUser(user);
        mysqlDataSource.setPassword(password);
        mysqlDataSource.setDatabaseName(dbname);
        mysqlDataSource.setServerName(url);
        mysqlDataSource.setPort(Integer.parseInt(port));
        try {
            cons=mysqlDataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        StackTraceElement[] st = Thread.currentThread().getStackTrace();
        System.out.println("create connection called from " + st[2]);
        return cons;
    }
    public static void main(String[] args) throws NamingException, SQLException {
        //System.out.println(getConnecttion2());

    }
    public static void readFileProperties(){
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        Properties properties = new Properties();
        try {
            properties.load(classLoader.getResourceAsStream("/config.properties"));
            url = properties.getProperty("remote.server");
            port = properties.getProperty("remote.server.port");
            user = properties.getProperty("remote.user");
            password = properties.getProperty("remote.password");
            dbname = properties.getProperty("remote.dbname");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
