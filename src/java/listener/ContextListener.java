package listener;

import dal.SettingDAO;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class ContextListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        SettingDAO settingDAO = new SettingDAO();
        
        // Kiểm tra và khởi tạo dữ liệu mẫu nếu cần
        if (settingDAO.isDataEmpty()) {
            settingDAO.initializeDefaultSettings();
        }
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup code if needed
    }
} 