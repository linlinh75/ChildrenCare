package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    
    protected Connection connection;
    
    public DBContext() {
        try {
            String url = "jdbc:mysql://localhost:3306/swp"; // Update with your DB name
            String user = "root"; // MySQL username
            String password = "thanh1610"; // MySQL password
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
            System.out.println("Connection successful!");
        } catch (ClassNotFoundException e) {
            System.out.println("Driver class not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Connection failed!");
            e.printStackTrace();
        }
    }
}
