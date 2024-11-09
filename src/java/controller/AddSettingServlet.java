package controller;

import dal.SettingDAO;
import model.Setting;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AddSettingServlet", urlPatterns = {"/add-setting"})
public class AddSettingServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add-setting.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String type = request.getParameter("type");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            int status = Integer.parseInt(request.getParameter("status"));
            
            Setting setting = new Setting(type, name, 0, description, status);
            
            SettingDAO settingDAO = new SettingDAO();
            int result = settingDAO.addSetting(setting);
            
            switch (result) {
                case 1:
                    request.getSession().setAttribute("successMessage", "Setting added successfully!");
                    break;
                case -1:
                    request.getSession().setAttribute("errorMessage", "Invalid setting type!");
                    break;
                case -2:
                    request.getSession().setAttribute("errorMessage", 
                        "A setting with this name already exists in " + type + "!");
                    break;
                case -3:
                    request.getSession().setAttribute("errorMessage", "Database error occurred!");
                    break;
                default:
                    request.getSession().setAttribute("errorMessage", "Failed to add setting!");
            }
            
            response.sendRedirect("admin-manage-settings");
            
        } catch (Exception e) {
            request.getSession().setAttribute("errorMessage", "Error adding setting: " + e.getMessage());
            response.sendRedirect("admin-manage-settings");
        }
    }
} 