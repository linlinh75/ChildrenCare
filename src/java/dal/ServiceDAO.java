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

    public String getServiceCategoryName(int serviceId) {
        String categoryName = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            String sql = "SELECT c.name FROM service_category c JOIN service s ON c.id = s.category_id WHERE s.id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, serviceId);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                categoryName = resultSet.getString("name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null)
                    resultSet.close();
                if (preparedStatement != null)
                    preparedStatement.close();
                if (connection != null)
                    connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return categoryName;
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
                rs.getInt("author_id"));
        return service;
    }

    public List<Service> getServiceWithPagination(int offset, int noOfRecords) {
        String query = "SELECT * FROM service LIMIT ?, ?";
        List<Service> list = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, offset);
            ps.setInt(2, noOfRecords);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service service = getFromResultSet(rs);
                list.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getNoOfRecords() {
        String query = "SELECT COUNT(*) FROM service";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Service> searchServices(String query, int offset, int noOfRecords) {
        List<Service> searchResults = new ArrayList<>();
        String sql = "SELECT * FROM service WHERE (fullname LIKE ? OR description LIKE ?) AND status = 1 LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ps.setInt(3, offset);
            ps.setInt(4, noOfRecords);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Service service = getFromResultSet(rs);
                    searchResults.add(service);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return searchResults;
    }

    public int getNoOfSearchRecords(String query) {
        String sql = "SELECT COUNT(*) FROM service WHERE (fullname LIKE ? OR description LIKE ?) AND status = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public static void main(String[] args) {
        ServiceDAO sd = new ServiceDAO();

        // Test getAllService()
        List<Service> ulist = sd.getAllService();
        for (Service u : ulist) {
            System.out.println(u.getThumbnailLink());
        }
        // Test getServiceById()
        int testId = 1; // Replace with an actual ID from your database
        Service service = sd.getServiceById(testId);
        if (service != null) {
            System.out.println("Service found: " + service.getFullname());
        } else {
            System.out.println("No service found with ID: " + testId);
        }

        // Test get Category Name
        String categoryName = sd.getServiceCategoryName(1); // serviceId = 1
        System.out.println("Category Name: " + categoryName);
    }
}
