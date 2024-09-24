/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Service;

public class ServiceServlet extends HttpServlet {

    private final ServiceDAO serviceDAO = new ServiceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list"; // Default action
        }

        switch (action) {
            case "details":
                showServiceDetails(request, response);
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

                if (service != null) {
                    request.setAttribute("service", service);
                    request.getRequestDispatcher("service-details.jsp").forward(request, response);
                } else {
                    response.sendRedirect("service.jsp");  // Redirect to list if service not found
                }
            } else {
                response.sendRedirect("service.jsp");  // Redirect to list if no ID provided
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("service.jsp");  // Redirect to list if invalid ID format
        } catch (Exception e) {
            getServletContext().log("An error occurred while retrieving service details", e);
            response.sendRedirect("error.jsp");
        }
    }

    private void listServices(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            List<Service> serviceList = serviceDAO.getAllService();
            request.setAttribute("serviceList", serviceList);
            request.getRequestDispatcher("service.jsp").forward(request, response);
        } catch (Exception e) {
            getServletContext().log("An error occurred while retrieving services", e);
            response.sendRedirect("error.jsp");
        }
    }

}
