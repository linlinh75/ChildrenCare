package controller;

import dal.ServiceCategoryDAO;
import dal.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import model.Service;
import model.ServiceCategory;

@WebServlet("/service-list-admin")
@MultipartConfig
public class ServiceAdminServlet extends HttpServlet {

    private final ServiceDAO serviceDAO = new ServiceDAO();
    private final ServiceCategoryDAO serviceCategoryDAO = new ServiceCategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        List<ServiceCategory> listServiceCategories = serviceCategoryDAO.getAll();
        request.setAttribute("listServiceCategories", listServiceCategories);

        switch (action) {
            case "list":
                listServices(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "toggle":
                toggleServiceStatus(request, response);
                break;
            case "search":
                searchServices(request, response);
                break;
            default:
                listServices(request, response);
                break;
        }
    }

    private void listServices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int servicesPerPage = 8;
        String status = request.getParameter("status");
        String searchQuery = request.getParameter("searchQuery");

        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }

        List<Service> services;
        int totalServices;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            // Search with filters
            if (status != null && !status.isEmpty() && !status.equals("all")) {
                boolean statusBool = status.equalsIgnoreCase("active");
                services = serviceDAO.searchServicesWithStatus(searchQuery, page, servicesPerPage, statusBool);
                totalServices = serviceDAO.getTotalSearchCountWithStatus(searchQuery, statusBool);
            } else {
                services = serviceDAO.searchServicesWithStatus(searchQuery, page, servicesPerPage, true);
                totalServices = serviceDAO.getTotalSearchCount(searchQuery);
            }
        } else {
            // Normal listing with status filter
            if (status != null && !status.isEmpty() && !status.equals("all")) {
                boolean statusBool = status.equalsIgnoreCase("active");
                services = serviceDAO.getServicesWithPaginationAndStatus(page, servicesPerPage, statusBool);
                totalServices = serviceDAO.getTotalServicesCountByStatus(statusBool);
            } else {
                services = serviceDAO.getServicesWithPagination(page, servicesPerPage);
                totalServices = serviceDAO.getTotalServicesCount();
            }
        }

        int totalPages = (int) Math.ceil((double) totalServices / servicesPerPage);

        request.setAttribute("services", services);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("selectedStatus", status);
        request.setAttribute("searchQuery", searchQuery);
        request.getRequestDispatcher("admin/service_list_admin.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("admin/add_service_admin.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int serviceId = Integer.parseInt(request.getParameter("id"));
        Service service = serviceDAO.getServiceById(serviceId);

        if (service != null) {
            request.setAttribute("service", service);
            request.getRequestDispatcher("admin/edit_service_admin.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/service-list-admin?action=list");
        }
    }

    private void toggleServiceStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int serviceId = Integer.parseInt(request.getParameter("id"));
            boolean success = serviceDAO.toggleServiceStatus(serviceId);

            if (success) {
                request.getSession().setAttribute("successMessage", "Service status has been updated successfully.");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to update service status. Please try again.");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid service ID.");
        }
        response.sendRedirect(request.getContextPath() + "/service-list-admin?action=list");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addService(request, response);
                break;
            case "update":
                updateService(request, response);
                break;
            default:
                listServices(request, response);
                break;
        }
    }

    private void addService(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        float originalPrice = Float.parseFloat(request.getParameter("originalPrice"));
        float salePrice = Float.parseFloat(request.getParameter("salePrice"));
        int categoryId = Integer.parseInt(request.getParameter("category"));
        String description = request.getParameter("description");
        String details = request.getParameter("details");
        boolean featured = request.getParameter("featured") != null;
        boolean status = request.getParameter("status") != null;
        // int quantity = Integer.parseInt(request.getParameter("quantity"));

        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("/uploads");

        Files.createDirectories(Paths.get(uploadPath));

        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, Paths.get(uploadPath).resolve(fileName),
                    StandardCopyOption.REPLACE_EXISTING);
        }

        Service newService = new Service();
        newService.setFullname(fullname);
        newService.setOriginalPrice(originalPrice);
        newService.setSalePrice(salePrice);
        newService.setCategoryId(categoryId);
        newService.setDescription(description);
        newService.setDetails(details);
        newService.setFeatured(featured);
        newService.setStatus(status);
        // newService.setQuantity(quantity);
        newService.setThumbnailLink(request.getContextPath() + "/uploads/" + fileName);

        boolean success = serviceDAO.addService(newService);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/service-list-admin?action=list");
        } else {
            request.setAttribute("error", "Failed to add the service. Please try again.");
            request.getRequestDispatcher("admin/add_service_admin.jsp").forward(request, response);
        }
    }

    private void updateService(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String fullname = request.getParameter("fullname");
        float originalPrice = Float.parseFloat(request.getParameter("originalPrice"));
        float salePrice = Float.parseFloat(request.getParameter("salePrice"));
        int categoryId = Integer.parseInt(request.getParameter("category"));
        String description = request.getParameter("description");
        String details = request.getParameter("details");
        boolean featured = request.getParameter("featured") != null;
        boolean status = request.getParameter("status") != null;
        // int quantity = Integer.parseInt(request.getParameter("quantity"));

        Service service = serviceDAO.getServiceById(id);
        service.setFullname(fullname);
        service.setOriginalPrice(originalPrice);
        service.setSalePrice(salePrice);
        service.setCategoryId(categoryId);
        service.setDescription(description);
        service.setDetails(details);
        service.setFeatured(featured);
        service.setStatus(status);
        // service.setQuantity(quantity);

        String newImagePath = null;
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("/uploads");
            Files.createDirectories(Paths.get(uploadPath));

            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, Paths.get(uploadPath).resolve(fileName),
                        StandardCopyOption.REPLACE_EXISTING);
            }
            newImagePath = request.getContextPath() + "/uploads/" + fileName;
        }

        boolean success = serviceDAO.updateService(service, newImagePath);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/service-list-admin?action=list");
        } else {
            request.setAttribute("error", "Failed to update the service. Please try again.");
            request.setAttribute("service", service);
            request.getRequestDispatcher("admin/edit_service_admin.jsp").forward(request, response);
        }
    }

    private void searchServices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the search query from the request parameters
        String searchQuery = request.getParameter("searchQuery");

        // Get the status filter from the request parameters
        String status = request.getParameter("status");

        // Initialize default values for pagination
        int page = 1;
        int servicesPerPage = 8;

        // Get the requested page number from the request parameters
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }

        // Declare variables to hold the list of services and total count
        List<Service> services;
        int totalServices;

        // Search services without status filter
        services = serviceDAO.searchServices(searchQuery, (page - 1) * servicesPerPage, servicesPerPage);

        // Get total count of services matching the search query
        totalServices = serviceDAO.getTotalSearchCount(searchQuery);

        // Calculate the total number of pages
        int totalPages = (int) Math.ceil((double) totalServices / servicesPerPage);

        // Set attributes for the JSP
        request.setAttribute("services", services);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("selectedStatus", status);
        request.setAttribute("searchQuery", searchQuery);

        // Forward the request to the JSP page
        request.getRequestDispatcher("admin/service_list_admin.jsp").forward(request, response);

    }
}
