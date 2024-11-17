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
        String query = "SELECT 'Post Category' as type, name, id as value, status FROM post_category "
                + "UNION ALL "
                + "SELECT 'Service Category' as type, name, id as value, status FROM service_category";

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
        sql.append("  SELECT 'Post Category' as type, name, id as value, description, status FROM post_category");
        sql.append("  UNION ALL");
        sql.append("  SELECT 'Service Category' as type, name, id as value, description, status FROM service_category");
        sql.append(") AS combined WHERE 1=1");

        // Add filters
        if (typeFilter != null && !typeFilter.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(typeFilter);
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            if ("Active".equals(statusFilter)) {
                sql.append(" AND status = 1");
            } else if ("Inactive".equals(statusFilter)) {
                sql.append(" AND status = 0");
            }
        }
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR CAST(value AS CHAR) = ?)");
            String searchPattern = "%" + searchKeyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchKeyword.trim());
        }

        // Add sorting
        if (sortBy != null && !sortBy.isEmpty()) {
            sql
                    .append(" ORDER BY ");
            switch (sortBy.toLowerCase()) {
                case "type":
                    sql.append("type");
                    break;
                case "name":
                    sql.append("name");
                    break;
                case "value":
                    sql.append("value");
                    break;
                case "description":
                    sql.append("description");
                    break;
                case "status":
                    sql.append("status");
                    break;
                default:
                    sql.append("value");
            }
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
                        rs.getString("description"),
                        rs.getInt("status")
                );
                settingList.add(setting);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return settingList;
    }

    public Setting getSettingById(int value) {
        String sql = "SELECT * FROM ("
                + "  SELECT 'Post Category' as type, name, id as value, description, status FROM post_category WHERE id = ? "
                + "  UNION ALL "
                + "  SELECT 'Service Category' as type, name, id as value, description, status FROM service_category WHERE id = ?"
                + ") AS combined";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, value);
            stmt.setInt(2, value);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Setting(
                        rs.getString("type"),
                        rs.getString("name"),
                        rs.getInt("value"),
                        rs.getString("description"),
                        rs.getInt("status")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int updateSetting(Setting setting) {
        // Get the current status before update
        int currentStatus = -1;
        String checkCurrentStatusSql = "";
        if ("Post Category".equals(setting.getType())) {
            checkCurrentStatusSql = "SELECT status FROM post_category WHERE id = ?";
        } else if ("Service Category".equals(setting.getType())) {
            checkCurrentStatusSql = "SELECT status FROM service_category WHERE id = ?";
        }

        try {
            PreparedStatement checkStmt = connection.prepareStatement(checkCurrentStatusSql);
            checkStmt.setInt(1, setting.getValue());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                currentStatus = rs.getInt("status");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
            return -3;
        }

        // Kiểm tra trùng lặp trước khi cập nhật
        String checkSql;
        if ("Post Category".equals(setting.getType())) {
            checkSql = "SELECT COUNT(*) FROM post_category WHERE name = ? AND id != ?";
        } else if ("Service Category".equals(setting.getType())) {
            checkSql = "SELECT COUNT(*) FROM service_category WHERE name = ? AND id != ?";
        } else {
            return -1; // Invalid type
        }

        try {
            // Kiểm tra trùng lặp tên
            PreparedStatement checkStmt = connection.prepareStatement(checkSql);
            checkStmt.setString(1, setting.getName());
            checkStmt.setInt(2, setting.getValue());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return -2; // Duplicate name
            }

            // Thực hiện cập nhật
            String updateSql;
            if ("Post Category".equals(setting.getType())) {
                updateSql = "UPDATE post_category SET name=?, description=?, status=? WHERE id=?";
            } else {
                updateSql = "UPDATE service_category SET name=?, description=?, status=? WHERE id=?";
            }

            PreparedStatement updateStmt = connection.prepareStatement(updateSql);
            updateStmt.setString(1, setting.getName());
            updateStmt.setString(2, setting.getDescription());
            updateStmt.setInt(3, setting.getStatus());
            updateStmt.setInt(4, setting.getValue());

            int result = updateStmt.executeUpdate();


            // If status has changed, update related posts/services
            if (result > 0 && currentStatus != setting.getStatus()) {
                updatePostStatusesForCategory(setting.getType(), setting.getValue(), setting.getStatus());
            }

            
            return result;
            
        } catch (SQLException ex) {
            Logger
                    .getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
            return -3; // Database error
        }
    }

    // Thêm phương thức để lấy ID tiếp theo cho từng loại
    private int getNextId(String type) {
        String tableName = "Post Category".equals(type) ? "post_category" : "service_category";
        String sql = "SELECT MAX(id) FROM " + tableName;
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 1; // Nếu bảng trống, bắt đầu từ 1
    }

    public int addSetting(Setting setting) {
        // Kiểm tra trùng lặp trước khi thêm
        String checkSql;
        if ("Post Category".equals(setting.getType())) {
            checkSql = "SELECT COUNT(*) FROM post_category WHERE name = ?";
        } else if ("Service Category".equals(setting.getType())) {
            checkSql = "SELECT COUNT(*) FROM service_category WHERE name = ?";
        } else {
            return -1; // Invalid type
        }

        try {
            // Kiểm tra trùng lặp tên
            PreparedStatement checkStmt = connection.prepareStatement(checkSql);
            checkStmt.setString(1, setting.getName());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return -2; // Duplicate name
            }

            // Lấy ID tiếp theo
            int nextId = getNextId(setting.getType());

            // Thực hiện thêm mới
            String insertSql;
            if ("Post Category".equals(setting.getType())) {
                insertSql = "INSERT INTO post_category (id, name, description, status) VALUES (?, ?, ?, ?)";
            } else {
                insertSql = "INSERT INTO service_category (id, name, description, status) VALUES (?, ?, ?, ?)";
            }

            PreparedStatement insertStmt = connection.prepareStatement(insertSql);
            insertStmt.setInt(1, nextId);
            insertStmt.setString(2, setting.getName());
            insertStmt.setString(3, setting.getDescription());
            insertStmt.setInt(4, setting.getStatus());

            int result = insertStmt.executeUpdate();
            if (result > 0) {
                setting.setValue(nextId); // Cập nhật value cho setting object
            }
            return result;

        } catch (SQLException ex) {
            Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, null, ex);
            return -3; // Database error
        }
    }

    public List<String> getUniqueSettingTypes() {
        List<String> types = new ArrayList<>();
        types.add("Post Category");
        types.add("Service Category");
        return types;
    }

    public int getTotalFilteredSettings(String typeFilter, String statusFilter, String searchKeyword) {
        StringBuilder sql = new StringBuilder();
        List<Object> params = new ArrayList<>();

        sql.append("SELECT COUNT(*) FROM (");
        sql.append("  SELECT 'Post Category' as type, name, id as value, description, status FROM post_category");
        sql.append("  UNION ALL");
        sql.append("  SELECT 'Service Category' as type, name, id as value, description, status FROM service_category");
        sql.append(") AS combined WHERE 1=1");

        if (typeFilter != null && !typeFilter.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(typeFilter);
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            if ("Active".equals(statusFilter)) {
                sql.append(" AND status = 1");
            } else if ("Inactive".equals(statusFilter)) {
                sql.append(" AND status = 0");
            }
        }
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append(" AND (name LIKE ? OR CAST(value AS CHAR) = ?)");
            String searchPattern = "%" + searchKeyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchKeyword.trim());
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

    // Update this method to handle status changes correctly
    public void updatePostStatusesForCategory(String type, int categoryId, int newStatus) {
        String tableName = "";
        String statusColumn = "";
        String categoryColumn = "";

        if ("Post Category".equals(type)) {
            tableName = "post";
            statusColumn = "status";
            categoryColumn = "category_id";
        } else if ("Service Category".equals(type)) {
            tableName = "service";
            statusColumn = "status";
            categoryColumn = "category_id";
        }

        
        if (!tableName.isEmpty()) {
            // Convert status from 1/0 to boolean for service table
            boolean newStatusValue = (newStatus == 1);
            
            String query = "UPDATE " + tableName + 
                          " SET " + statusColumn + " = ? " +
                          "WHERE " + categoryColumn + " = ?";
                      
            try {
                PreparedStatement stmt = connection.prepareStatement(query);
                

                if ("service".equals(tableName)) {
                    // For service table, use boolean
                    stmt.setBoolean(1, newStatusValue);
                } else {
                    // For post table, use string "Published"/"Hidden"
                    stmt.setString(1, newStatus == 1 ? "Published" : "Hidden");
                }

                
                stmt.setInt(2, categoryId);
                stmt.executeUpdate();
                
            } catch (SQLException ex) {
                Logger.getLogger(SettingDAO.class.getName()).log(Level.SEVERE, 
                    "Error updating " + tableName + " statuses for category " + categoryId, ex);
            }
        }
    }
}
