package dal;

import java.sql.*;

public class DBContext {

    protected Connection connection;
    protected ResultSet resultSet;
    protected PreparedStatement statement;

    /**
     * get a connection
     *
     * @return connection or null
     * @throws ClassNotFoundException
     */
    public Connection getConnection() {
        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            String url = "jdbc:mysql://buycard123.mysql.database.azure.com:3306/sold_card_system3";
//            String user = "g3"; // Change to your MySQL username
//            String password = "Grouppp3"; // Change to your MySQL password
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/swp";
            String user = "demo"; // Change to your MySQL username
            String password = "123456"; // Change to your MySQL password
            connection = DriverManager.getConnection(url, user, password);
            return connection;
        } catch (SQLException | ClassNotFoundException e) {
//            System.err.println("Error " + e.getMessage() + " at DBContext");
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        DBContext test = new DBContext();
        test.connection = test.getConnection();
        System.out.println(test.connection);
    }

    public void closeConnection() {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (Exception e) {
            System.err.println("Error " + e.getMessage() + " at closeConnection");
        }
    }
}
