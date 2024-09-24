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
