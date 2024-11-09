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
        String query = "SELECT 'Post Category' as type, name, id as value, status FROM swp.post_category " +
                      "UNION ALL " +
                      "SELECT 'Service Category' as type, name, id as value, status FROM swp.service_category";

        try {
            PreparedStatement stm = connection.prepareStatement(query);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Setting setting = new Setting(
                    rs.getString("type"),
                    rs.getString("name"),
                    rs.getInt("value"),
                    "", 
                    rs.getInt("status")
                );
                settingsList.add(setting);
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
        
        StringBuilder sql = new StringBuilder();
        List<Object> params = new ArrayList<>();
        
        // Base query with UNION
        sql.append("SELECT * FROM (");
        sql.append("  SELECT 'Post Category' as type, name, id as value, status FROM post_category");
        sql.append("  UNION ALL");
        sql.append("  SELECT 'Service Category' as type, name, id as value, status FROM service_category");
        sql.append(") AS combined WHERE 1=1");
        
        // Add filters
        if (typeFilter != null && !typeFilter.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(typeFilter);
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(statusFilter);
        }
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR CAST(value AS CHAR) LIKE ?)");
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
            sql.append(" ORDER BY value ASC");
        }
        
        // Add pagination
        sql.append(" LIMIT ? OFFSET ?");
        params.add(recordsPerPage);
        params.add(start);
        
        try {
            System.out.println("Executing SQL: " + sql.toString());
            System.out.println("Parameters: " + params);
            
            PreparedStatement stmt = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Setting setting = new Setting(
                    rs.getString("type"),
                    rs.getString("name"),
                    rs.getInt("value"),
                    "", 
                    rs.getInt("status")
                );
                settingList.add(setting);
                System.out.println("Added setting: " + setting.getName());
            }
        } catch (SQLException ex) {
            System.out.println("SQL Error: " + ex.getMessage());
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return settingList;
    }

    public int getTotalFilteredSettings(String typeFilter, String statusFilter, String searchKeyword) {
        StringBuilder sql = new StringBuilder();
        List<Object> params = new ArrayList<>();
        
        sql.append("SELECT COUNT(*) FROM (");
        sql.append("  SELECT 'Post Category' as type, name, id as value, status FROM post_category");
        sql.append("  UNION ALL");
        sql.append("  SELECT 'Service Category' as type, name, id as value, status FROM service_category");
        sql.append(") AS combined WHERE 1=1");
        
        if (typeFilter != null && !typeFilter.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(typeFilter);
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(statusFilter);
        }
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR CAST(value AS CHAR) LIKE ?)");
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
        types.add("Post Category");
        types.add("Service Category");
        return types;
    }

    public Setting getSettingById(int id) {
        String sql = "SELECT * FROM (" +
                    "  SELECT 'Post Category' as type, name, id as value, status FROM post_category WHERE id = ? " +
                    "  UNION ALL " +
                    "  SELECT 'Service Category' as type, name, id as value, status FROM service_category WHERE id = ?" +
                    ") AS combined";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.setInt(2, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Setting(
                    rs.getString("type"),
                    rs.getString("name"),
                    rs.getInt("value"),
                    "", // Description không còn cần thiết
                    rs.getInt("status")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int updateSetting(Setting setting) {
        String sql;
        if ("Post Category".equals(setting.getType())) {
            sql = "UPDATE post_category SET name=?, status=? WHERE id=?";
        } else if ("Service Category".equals(setting.getType())) {
            sql = "UPDATE service_category SET name=?, status=? WHERE id=?";
        } else {
            return -1;
        }
        
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, setting.getName());
            stmt.setInt(2, setting.getStatus());
            stmt.setInt(3, setting.getValue());
            return stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
            return -3;
        }
    }

    private int getNextId(String type) {
        String tableName = "Post Category".equals(type) ? "post_category" : "service_category";
        int maxId = 0;
        String query = "SELECT MAX(id) as max_id FROM " + tableName;
        
        try {
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                maxId = rs.getInt("max_id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return maxId + 1;
    }

    public int addSetting(Setting setting) {
        String sql;
        int nextId = getNextId(setting.getType());
        
        if ("Post Category".equals(setting.getType())) {
            sql = "INSERT INTO post_category (id, name, status) VALUES (?, ?, ?)";
        } else if ("Service Category".equals(setting.getType())) {
            sql = "INSERT INTO service_category (id, name, status) VALUES (?, ?, ?)";
        } else {
            return -1;
        }
        
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, nextId);
            stmt.setString(2, setting.getName());
            stmt.setInt(3, setting.getStatus());
            
            // Cập nhật value của setting để phản ánh ID mới
            setting.setValue(nextId);
            
            return stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
            return -3;
        }
    }

    public void initializeDefaultSettings() {
        // Post Categories - ID bắt đầu từ 1
        addSetting(new Setting("Post Category", "News", 0, "", 1));
        addSetting(new Setting("Post Category", "Events", 0, "", 1));
        addSetting(new Setting("Post Category", "Tips", 0, "", 1));
        addSetting(new Setting("Post Category", "Reviews", 0, "", 1));
        
        // Service Categories - ID bắt đầu từ 1 cho service_category
        addSetting(new Setting("Service Category", "Dental Care", 0, "", 1));
        addSetting(new Setting("Service Category", "Check-up", 0, "", 1));
        addSetting(new Setting("Service Category", "Consultation", 0, "", 1));
        addSetting(new Setting("Service Category", "Treatment", 0, "", 1));
    }

    public boolean isDataEmpty() {
        String query = "SELECT COUNT(*) as count FROM (" +
                      "SELECT id FROM post_category " +
                      "UNION ALL " +
                      "SELECT id FROM service_category" +
                      ") AS combined";
        
        try {
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("count") == 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return true;
    }
}
