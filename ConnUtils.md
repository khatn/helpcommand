# helpcommand
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 Them oracle db
 */
package utils;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Lenovo
 */
public class ConnectionUtils {

    public static Connection connect;
    public static Statement stm;

    public static void connectDB() throws SQLException {

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            //String url = "jdbc:oracle:thin:@alktech.ddns.net:1521:alktech";
            String url = "jdbc:oracle:thin:@192.168.1.68:1521:alktech";
            String username = "BIDV_DEMO";
            String password = "BIDV_DEMO";
            
//            String url = "jdbc:oracle:thin:@10.4.254.66:1521:betest";
//            String username = "backend_monitor";
//            String password = "123456";
            
            connect = DriverManager.getConnection(url, username, password);
            System.out.println("Connect successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Connect unsuccessfully!");
            connect.close();
        }

    }
    
    public static Statement getStatement() throws SQLException{
        connectDB();
        return connect.createStatement();
    }
    
    public static CallableStatement callStatement(String sql) throws SQLException{
        connectDB();
        return connect.prepareCall(sql);
    }
    
    public static void closeConnection() throws SQLException{
        if (connect != null) {
            connect.close();
        }
    }
    
    public static ResultSet getResultSet(String sql) throws SQLException{
        return stm.executeQuery(sql);
    }

}
