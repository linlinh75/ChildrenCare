package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Setting;

public class SettingDAO extends DBContext {

    public List<Setting> getAllSettings() {
        List<Setting> settingsList = new ArrayList<>();
        String query = "SELECT * FROM setting";

        try {
            if (connection != null) {
                PreparedStatement stm = connection.prepareStatement(query);
                ResultSet rs = stm.executeQuery();
                while (rs.next()) {
                    Setting setting = new Setting(
                            rs.getInt("id"),
                            rs.getString("type"),
                            rs.getString("name"),
                            rs.getInt("value"),
                            rs.getString("description"),
                            rs.getString("status")
                    );
                    settingsList.add(setting);
                }
            } else {
                System.out.println("Connection is null, cannot execute query.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return settingsList;
    }

    public List<Setting> getRole() {
        return getSettingsByType("Role");
    }

    public List<Setting> getPostCategory() {
        return getSettingsByType("Post category");
    }

    public List<Setting> getServiceCategory() {
        return getSettingsByType("Service Category");
    }

    public List<Setting> getUserStatus() {
        return getSettingsByType("User Status");
    }

    private List<Setting> getSettingsByType(String type) {
        List<Setting> settingsList = new ArrayList<>();
        String query = "SELECT * FROM swp.setting WHERE type = ?";

        try {
            if (connection != null) {
                PreparedStatement stm = connection.prepareStatement(query);
                stm.setString(1, type);
                ResultSet rs = stm.executeQuery();
                while (rs.next()) {
                    Setting setting = new Setting(
                            rs.getInt("id"),
                            rs.getString("type"),
                            rs.getString("name"),
                            rs.getInt("value"),
                            rs.getString("description"),
                            rs.getString("status")
                    );
                    settingsList.add(setting);
                }
            } else {
                System.out.println("Connection is null, cannot execute query.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return settingsList;
    }

    public List<Setting> getFilteredAndSortedSettings(String typeFilter, String statusFilter, 
            String searchKeyword, String sortBy, String sortOrder, int page, int recordsPerPage) {
        List<Setting> settingList = new ArrayList<>();
        int start = (page - 1) * recordsPerPage;
        
        StringBuilder sql = new StringBuilder("SELECT * FROM setting WHERE 1=1");
        List<Object> params = new ArrayList<>();
        
        // Add filters
        if (typeFilter != null && !typeFilter.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(typeFilter);
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(statusFilter);
        }
        
        // Add search
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR value LIKE ?)");
            String searchPattern = "%" + searchKeyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        // Add sorting
        if (sortBy != null && !sortBy.isEmpty()) {
            sql.append(" ORDER BY ").append(sortBy);
            if ("desc".equalsIgnoreCase(sortOrder)) {
                sql.append(" DESC");
            } else {
                sql.append(" ASC");
            }
        } else {
            sql.append(" ORDER BY id ASC");
        }
        
        // Add pagination
        sql.append(" LIMIT ? OFFSET ?");
        params.add(recordsPerPage);
        params.add(start);
        
        try {
            PreparedStatement stmt = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Setting setting = new Setting(
                    rs.getInt("id"),
                    rs.getString("type"),
                    rs.getString("name"),
                    rs.getInt("value"),
                    rs.getString("description"),
                    rs.getString("status")
                );
                settingList.add(setting);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return settingList;
    }

    public int getTotalFilteredSettings(String typeFilter, String statusFilter, String searchKeyword) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM setting WHERE 1=1");
        List<Object> params = new ArrayList<>();
        
        if (typeFilter != null && !typeFilter.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(typeFilter);
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(statusFilter);
        }
        
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR value LIKE ?)");
            String searchPattern = "%" + searchKeyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        try {
            PreparedStatement stmt = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<String> getUniqueSettingTypes() {
        List<String> types = new ArrayList<>();
        String sql = "SELECT DISTINCT type FROM setting ORDER BY type";
        
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                types.add(rs.getString("type"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return types;
    }

    public Setting getSettingById(int id) {
        String sql = "SELECT * FROM setting WHERE id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Setting(
                    rs.getInt("id"),
                    rs.getString("type"),
                    rs.getString("name"),
                    rs.getInt("value"),
                    rs.getString("description"),
                    rs.getString("status")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean addSetting(Setting setting) {
        String sql = "INSERT INTO setting (type, name, value, description, status) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, setting.getType());
            stmt.setString(2, setting.getName());
            stmt.setInt(3, setting.getValue());
            stmt.setString(4, setting.getDescription());
            stmt.setString(5, setting.getStatus());
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean updateSetting(Setting setting) {
        String sql = "UPDATE setting SET type=?, name=?, value=?, description=?, status=? WHERE id=?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, setting.getType());
            stmt.setString(2, setting.getName());
            stmt.setInt(3, setting.getValue());
            stmt.setString(4, setting.getDescription());
            stmt.setString(5, setting.getStatus());
            stmt.setInt(6, setting.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static void main(String[] args) {
        SettingDAO settingDAO = new SettingDAO();

        // Kiểm tra các phương thức
        List<Setting> roles = settingDAO.getRole();
        System.out.println("Roles:");
        for (Setting role : roles) {
            System.out.println(role.getName());
        }

        List<Setting> postCategories = settingDAO.getPostCategory();
        System.out.println("\nPost Categories:");
        for (Setting category : postCategories) {
            System.out.println(category.getName());
        }

        List<Setting> serviceCategories = settingDAO.getServiceCategory();
        System.out.println("\nService Categories:");
        for (Setting category : serviceCategories) {
            System.out.println(category.getName());
        }

        List<Setting> userStatuses = settingDAO.getUserStatus();
        System.out.println("\nUser Statuses:");
        for (Setting status : userStatuses) {
            System.out.println(status.getName());
        }
    }
}
