package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Service;

public class ServiceDAO extends DBContext {

    public List<Service> getAllService() {
        List<Service> ulist = new ArrayList<>();
        String s = "SELECT * FROM swp.service";
        
        try {
            if (connection != null) { 
                PreparedStatement stm = connection.prepareStatement(s);
                ResultSet rs = stm.executeQuery();
                while (rs.next()) {
                    Service service = new Service(
                            rs.getInt("id"),
                            rs.getString("fullname"),
                            rs.getFloat("original_price"),
                            rs.getFloat("sale_price"),
                            rs.getString("thumbnail_link"),
                            rs.getInt("category_id"),
                            rs.getString("description"),
                            rs.getString("details"),
                            rs.getDate("updated_date"),
                            rs.getBoolean("featured"),
                            rs.getBoolean("status"),
                            rs.getInt("quantity")
                    );
                    ulist.add(service);
                }
            } else {
                System.out.println("Connection is null, cannot execute query.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ulist;
    }

    public static void main(String[] args) {
        ServiceDAO sd = new ServiceDAO();
        List<Service> ulist = sd.getAllService();
        for (Service u : ulist) {
            System.out.print(u.getThumbnailLink());
        }
        System.out.println(ulist.size());
    }
}
