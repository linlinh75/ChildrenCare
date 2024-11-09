package controller;

import dal.SettingDAO;
import model.Setting;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SettingsListServlet", urlPatterns = {"/admin-manage-settings"})
public class SettingsListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            SettingDAO settingDAO = new SettingDAO();
            
            // Get parameters with default values
            int page = getIntParameter(request, "page", 1);
            int recordsPerPage = getIntParameter(request, "recordsPerPage", 10);
            
            // Get filter parameters
            String typeFilter = getStringParameter(request, "type", null);
            String statusFilter = getStringParameter(request, "status", null);
            String searchKeyword = getStringParameter(request, "search", null);
            
            // Get sort parameters
            String sortBy = getStringParameter(request, "sortBy", "type");  // Default sort by value
            String sortOrder = getStringParameter(request, "sortOrder", "asc");
            
            // Get filtered and sorted settings
            List<Setting> settingList = settingDAO.getFilteredAndSortedSettings(
                typeFilter, statusFilter, searchKeyword,
                sortBy, sortOrder, page, recordsPerPage
            );
            
            // Get total records for pagination
            int totalRecords = settingDAO.getTotalFilteredSettings(
                typeFilter, statusFilter, searchKeyword
            );
            
            // Calculate total pages
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            
            // Get unique setting types for filter dropdown
            List<String> settingTypes = settingDAO.getUniqueSettingTypes();
            
            // Debug print
            System.out.println("Settings found: " + (settingList != null ? settingList.size() : "null"));
            System.out.println("Total records: " + totalRecords);
            System.out.println("Total pages: " + totalPages);
            
            // Set attributes
            request.setAttribute("settingList", settingList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("recordsPerPage", recordsPerPage);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("typeFilter", typeFilter);
            request.setAttribute("statusFilter", statusFilter);
            request.setAttribute("searchKeyword", searchKeyword);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("sortOrder", sortOrder);
            request.setAttribute("settingTypes", settingTypes);
            
            // Forward to JSP
            request.getRequestDispatcher("admin-SettingsList.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("Error in SettingsListServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private int getIntParameter(HttpServletRequest request, String paramName, int defaultValue) {
        String paramValue = request.getParameter(paramName);
        if (paramValue != null && !paramValue.isEmpty()) {
            try {
                return Integer.parseInt(paramValue);
            } catch (NumberFormatException e) {
                return defaultValue;
            }
        }
        return defaultValue;
    }

    private String getStringParameter(HttpServletRequest request, String paramName, String defaultValue) {
        String paramValue = request.getParameter(paramName);
        return (paramValue != null && !paramValue.trim().isEmpty()) ? paramValue.trim() : defaultValue;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 