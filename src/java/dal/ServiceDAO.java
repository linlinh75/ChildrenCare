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
        String s = "SELECT * FROM service where status = 1";
        
        try {
            if (connection != null) { 
                PreparedStatement stm = connection.prepareStatement(s);
                ResultSet rs = stm.executeQuery();
                while (rs.next()) {
                    Service service = getFromResultSet(rs);
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

    public Service getServiceById(int id) {
        Service service = null;
        String sql = "SELECT * FROM service WHERE id = ?";
        
        try {
            if (connection != null) {
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setInt(1, id);
                ResultSet rs = stm.executeQuery();
                
                if (rs.next()) {
                    service = getFromResultSet(rs);
                }
            } else {
                System.out.println("Connection is null, cannot execute query.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ServiceDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return service;
    }
    
    public Service getFromResultSet(ResultSet rs) throws SQLException {
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
        return service;
    }

    public static void main(String[] args) {
        ServiceDAO sd = new ServiceDAO();
        
        // Test getAllService()
//        List<Service> ulist = sd.getAllService();
//        for (Service u : ulist) {
//            System.out.println(u.getThumbnailLink());
//        }
        
        // Test getServiceById()
        int testId = 1; // Replace with an actual ID from your database
        Service service = sd.getServiceById(testId);
        if (service != null) {
            System.out.println("Service found: " + service.getFullname());
        } else {
            System.out.println("No service found with ID: " + testId);
        }
    }
}
