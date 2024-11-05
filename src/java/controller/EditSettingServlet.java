package controller;

import dal.SettingDAO;
import model.Setting;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "EditSettingServlet", urlPatterns = {"/edit-setting"})
public class EditSettingServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String type = request.getParameter("type");
            String name = request.getParameter("name");
            int value = Integer.parseInt(request.getParameter("value"));
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            
            Setting setting = new Setting();
            setting.setId(id);
            setting.setType(type);
            setting.setName(name);
            setting.setValue(value);
            setting.setDescription(description);
            setting.setStatus(status);
            
            SettingDAO settingDAO = new SettingDAO();
            boolean success = settingDAO.updateSetting(setting);
            
            if (success) {
                request.getSession().setAttribute("successMessage", "Setting updated successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to update setting.");
            }
            
            response.sendRedirect("admin-manage-settings");
            
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error updating setting: " + e.getMessage());
            response.sendRedirect("admin-manage-settings");
        }
    }
} 