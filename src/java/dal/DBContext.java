/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Admin
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    protected Connection connection;
    public DBContext() {
        String url = "jdbc:mysql://localhost:3306/swp"; 
        String user = "root"; 
        String password = "nguyetanh2311"; 
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
             connection = DriverManager.getConnection(url, user, password);
            System.out.println("Connection successful!");

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Connection failed!");
            e.printStackTrace();
        }
    }
    public static void main(String[] args) {
        DBContext dbcon = new DBContext();
    }
}

