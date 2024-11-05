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
            
            // Get parameters
            int page = 1;
            int recordsPerPage = 10;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
            }
            
            // Get filter parameters
            String typeFilter = request.getParameter("type");
            String statusFilter = request.getParameter("status");
            String searchKeyword = request.getParameter("search");
            
            // Get sort parameters
            String sortBy = request.getParameter("sortBy");
            String sortOrder = request.getParameter("sortOrder");
            
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 