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

    public List<Service> getAllManageService() {
        List<Service> ulist = new ArrayList<>();
        String s = "SELECT * FROM service";

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
                if (resultSet != null) {
                    resultSet.close();
                }
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
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
        String query = "SELECT * FROM service where status = 1 LIMIT ?, ?";
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
        String query = "SELECT COUNT(*) FROM service where status = 1";
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

    public List<Service> searchServicesStatusOne(String query, int offset, int servicesPerPage) {
        List<Service> services = new ArrayList<>();

        String sql = "SELECT * FROM service WHERE (fullname LIKE ? OR description LIKE ?) AND status = 1 " +
                "LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ps.setInt(3, offset);
            ps.setInt(4, servicesPerPage);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = getFromResultSet(rs);
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return services;
    }

    public List<Service> searchServices(String query, int offset, int servicesPerPage) {
        List<Service> services = new ArrayList<>();

        String sql = "SELECT * FROM service WHERE (fullname LIKE ? OR description LIKE ?) " +
                "LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ps.setInt(3, offset);
            ps.setInt(4, servicesPerPage);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = getFromResultSet(rs);
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return services;
    }

    public List<Service> searchServicesWithStatus(String query, int page, int servicesPerPage, boolean status) {
        List<Service> services = new ArrayList<>();
        int offset = (page - 1) * servicesPerPage;

        String sql = "SELECT * FROM service WHERE (fullname LIKE ? OR description LIKE ?) " +
                "AND status = ? LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ps.setBoolean(3, status);
            ps.setInt(4, offset);
            ps.setInt(5, servicesPerPage);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = getFromResultSet(rs);
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return services;
    }

    public int getTotalSearchCount(String query) {
        String sql = "SELECT COUNT(*) FROM service WHERE fullname LIKE ? OR description LIKE ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalSearchCountWithStatus(String query, boolean status) {
        String sql = "SELECT COUNT(*) FROM service WHERE (fullname LIKE ? OR description LIKE ?) " +
                "AND status = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ps.setBoolean(3, status);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
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

    // Add these methods to your existing ServiceDAO class
    public List<Service> getServicesWithPagination(int page, int servicesPerPage) {
        List<Service> services = new ArrayList<>();
        int offset = (page - 1) * servicesPerPage;

        String sql = "SELECT * FROM service LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, servicesPerPage);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service service = getFromResultSet(rs);
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return services;
    }

    public List<Service> getServicesWithPaginationAndStatus(int page, int servicesPerPage, boolean status) {
        List<Service> services = new ArrayList<>();
        int offset = (page - 1) * servicesPerPage;

        String sql = "SELECT * FROM service WHERE status = ? LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBoolean(1, status);
            ps.setInt(2, offset);
            ps.setInt(3, servicesPerPage);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Service service = getFromResultSet(rs);
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return services;
    }

    public boolean toggleServiceStatus(int serviceId) {
        String sql = "UPDATE service SET status = NOT status WHERE id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addService(Service service) {
        String sql = "INSERT INTO service (fullname, original_price, sale_price, thumbnail_link, "
                + "category_id, description, details, featured, status, updated_date) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, service.getFullname());
            ps.setFloat(2, service.getOriginalPrice());
            ps.setFloat(3, service.getSalePrice());
            ps.setString(4, service.getThumbnailLink());
            ps.setInt(5, service.getCategoryId());
            ps.setString(6, service.getDescription());
            ps.setString(7, service.getDetails());
            ps.setBoolean(8, service.isFeatured());
            ps.setBoolean(9, service.isStatus());
//            ps.setInt(10, service.getQuantity());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateService(Service service, String newImagePath) {
        String sql;
        if (newImagePath != null) {
            sql = "UPDATE service SET fullname = ?, original_price = ?, sale_price = ?, "
                    + "thumbnail_link = ?, category_id = ?, description = ?, details = ?, "
                    + "featured = ?, status = ?, updated_date = NOW() "
                    + "WHERE id = ?";
        } else {
            sql = "UPDATE service SET fullname = ?, original_price = ?, sale_price = ?, "
                    + "category_id = ?, description = ?, details = ?, featured = ?, "
                    + "status = ?, updated_date = NOW() "
                    + "WHERE id = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, service.getFullname());
            ps.setFloat(2, service.getOriginalPrice());
            ps.setFloat(3, service.getSalePrice());

            int paramIndex = 4;
            if (newImagePath != null) {
                ps.setString(paramIndex++, newImagePath);
            }

            ps.setInt(paramIndex++, service.getCategoryId());
            ps.setString(paramIndex++, service.getDescription());
            ps.setString(paramIndex++, service.getDetails());
            ps.setBoolean(paramIndex++, service.isFeatured());
            ps.setBoolean(paramIndex++, service.isStatus());
//            ps.setInt(paramIndex++, service.getQuantity());
            ps.setInt(paramIndex, service.getId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper method to get total count for pagination
    public int getTotalServicesCount() {
        String sql = "SELECT COUNT(*) FROM service";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // Helper method to get total count with status filter for pagination
    public int getTotalServicesCountByStatus(boolean status) {
        String sql = "SELECT COUNT(*) FROM service WHERE status = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBoolean(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<Service> getServicesByCategoryWithPagination(int categoryId, int page, int servicesPerPage) {
        List<Service> services = new ArrayList<>();
        int offset = (page - 1) * servicesPerPage;

        String sql = "SELECT * FROM service WHERE category_id = ? AND status = 1 LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.setInt(2, offset);
            ps.setInt(3, servicesPerPage);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = getFromResultSet(rs);
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return services;
    }

    public int getTotalServiceCountByCategory(int categoryId) {
        String sql = "SELECT COUNT(*) FROM service WHERE category_id = ? AND status = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
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
