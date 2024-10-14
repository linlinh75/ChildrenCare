package dal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    
    protected Connection connection;
    
    public DBContext() {
        String url = "jdbc:mysql://localhost:3306/swp"; 
        String user = "root"; 

        String password = "thanh1610"; 

        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
             connection = DriverManager.getConnection(url, user, password);
            System.out.println("Connection successful!");

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Driver class not found!");
            e.printStackTrace();
        }
    }
    public static void main(String[] args) {
        DBContext dbcon = new DBContext();
        System.out.println(dbcon.connection);
    }
}
