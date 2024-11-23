/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FeedbackDAO;
import dal.PostCategoryDAO;
import dal.PostDAO;
import dal.ServiceCategoryDAO;
import dal.ServiceDAO;
import dal.SliderDAO;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.Feedback;
import model.Post;
import model.PostCategory;
import model.Service;
import model.ServiceCategory;
import model.Slider;
import model.User;

public class ServiceServlet extends HttpServlet {

    private final ServiceDAO serviceDAO = new ServiceDAO();
    private final FeedbackDAO feedbackDAO = new FeedbackDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        ServiceDAO s = new ServiceDAO();
        List<Service> list_service = s.getAllService();
        PostDAO p = new PostDAO();
        List<Post> list_post = p.getAllPosts();
        List<Post> new_post = p.getNewest();
        ServiceCategoryDAO sc = new ServiceCategoryDAO();
        List<ServiceCategory> s_category = sc.getAll();
        PostCategoryDAO pc = new PostCategoryDAO();
        List<PostCategory> p_category = pc.getAll();
        SliderDAO sliderDAO = new SliderDAO();
        List<Slider> list_sliders = sliderDAO.getAllSliders();
        request.setAttribute("list_sliders", list_sliders);
        if (s_category == null || s_category.isEmpty()) {
        } else {
            request.setAttribute("list_sc", s_category);
        }
        if (p_category == null || p_category.isEmpty()) {
        } else {
            request.setAttribute("list_pc", p_category);
        }
        if (list_service == null || list_service.isEmpty()) {
        } else {
            request.setAttribute("services", list_service);
        }
        if (list_post == null || list_post.isEmpty()) {
        } else {
            request.setAttribute("posts", list_post);
        }
        request.setAttribute("new_posts", new_post);
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Default action
        }
        request.setAttribute("active", "service");
        request.setAttribute("serviceservlet", this);
        switch (action) {
            case "details":
                showServiceDetails(request, response);
                break;
            case "search":
                searchServices(request, response);
                break;
            case "category":
                listServicesByCategory(request, response);
                break;
            case "list":
            default:
                listServices(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServiceServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServiceServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private void showServiceDetails(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String serviceId = request.getParameter("id");

            if (serviceId != null && !serviceId.isEmpty()) {
                int id = Integer.parseInt(serviceId);
                Service service = serviceDAO.getServiceById(id);
                List<Feedback> listFeedback = feedbackDAO.getFeedbackByServiceId(id);
                request.setAttribute("listFeedback", listFeedback);
                if (service != null) {
                    request.setAttribute("service", service);
                    request.getRequestDispatcher("service-details.jsp").forward(request, response);
                } else {
                    response.sendRedirect("service.jsp"); // Redirect to list if service not found
                }
            } else {
                response.sendRedirect("service.jsp"); // Redirect to list if no ID provided
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("service.jsp"); // Redirect to list if invalid ID format
        } catch (Exception e) {
            getServletContext().log("An error occurred while retrieving service details", e);
            response.sendRedirect("error.jsp");
        }
    }

    private void listServices(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int page = 1;
            int recordsPerPage = 6; // Số dịch vụ trên mỗi trang

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            ServiceDAO serviceDAO = new ServiceDAO();
            List<Service> serviceList = serviceDAO.getServiceWithPagination((page - 1) * recordsPerPage,
                    recordsPerPage);
            int noOfRecords = serviceDAO.getNoOfRecords();
            int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

            request.setAttribute("serviceList", serviceList);
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            request.getRequestDispatcher("service.jsp").forward(request, response);
        } catch (Exception e) {
            getServletContext().log("An error occurred while retrieving services", e);
            response.sendRedirect("error.jsp");
        }
    }

    private void searchServices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("query");
        int page = 1;
        int recordsPerPage = 6;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        try {
            List<Service> searchResults = serviceDAO.searchServicesStatusOne(query, (page - 1) * recordsPerPage, recordsPerPage);
            int noOfRecords = serviceDAO.getNoOfSearchRecords(query);
            int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

            request.setAttribute("serviceList", searchResults);
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("searchQuery", query);
            request.setAttribute("pageType", "search");
            request.getRequestDispatcher("service.jsp").forward(request, response);
        } catch (Exception e) {
            getServletContext().log("An error occurred while searching for services", e);
            response.sendRedirect("error.jsp");
        }
    }

    private void listServicesByCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int page = 1;
            int recordsPerPage = 6;

            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            List<Service> serviceList = serviceDAO.getServicesByCategoryWithPagination(categoryId, page, recordsPerPage);
            int noOfRecords = serviceDAO.getTotalServiceCountByCategory(categoryId);
            int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

            // Get all categories for the sidebar
//            List<ServiceCategory> allCategories = serviceDAO.getAll();

            request.setAttribute("serviceList", serviceList);
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("categoryId", categoryId);
            request.setAttribute("pageType", "category");
            request.getRequestDispatcher("service.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            getServletContext().log("Invalid category ID", e);
            response.sendRedirect("error.jsp");
        } catch (Exception e) {
            getServletContext().log("An error occurred while retrieving services by category", e);
            response.sendRedirect("error.jsp");
        }
    }


    public double getAverageRating(int serviceId) {
        double totalRating = 0;
        int totalFeedbacks = 0;
        List<Feedback> listFeedbacks = feedbackDAO.getAllFeedbackByServiceId(serviceId);
        for (Feedback feedback : listFeedbacks) {
            totalRating += feedback.getRated_star();
            totalFeedbacks++;
        }

        // Trả về 0 nếu không có đánh giá
        return totalFeedbacks > 0 ? totalRating / totalFeedbacks : 0;
    }

    public String getUserName(int userId) {
        // You'll need to implement this to get the user's name from your UserDAO
        UserDAO userDAO = new UserDAO();
        User user;
        try {
            user = userDAO.getProfileById(userId);
            return user != null ? user.getFullName() : "Anonymous";
        } catch (SQLException ex) {
            Logger.getLogger(ServiceServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "Anonymous";
    }
}
