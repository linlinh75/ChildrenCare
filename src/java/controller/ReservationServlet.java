/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.ReservationDAO;
import dal.ServiceDAO;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.User;
import model.Reservation;
import model.ReservationService;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import model.Service;
import dal.SliderDAO;

/**
 *
 * @author admin
 */
@WebServlet(name = "ReservationServlet", urlPatterns = {"/ReservationServlet"})
public class ReservationServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            ReservationDAO res = new ReservationDAO();
            ServiceDAO sv = new ServiceDAO();
            HttpSession session = request.getSession();
            User loggedInUser = (User) session.getAttribute("account");
            if (null == loggedInUser) {
                response.sendRedirect("DataServlet?action=login");
                return;
            }
            List<Reservation> list_reservation = res.getReservationbyCustomerId(loggedInUser.getId());
            request.setAttribute("reservation", list_reservation);
            request.setAttribute("service", sv);
            request.getRequestDispatcher("customer-reservation.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        switch (action) {
            case "getDetails":
                handleGetDetails(request, response);
                break;
            case "cancelReservation":
                handleCancelReservation(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                break;
        }
    }

    private void handleGetDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ReservationDAO reservationDAO = new ReservationDAO();
            Reservation reservation = reservationDAO.getReservationById(id);

            StringBuilder contentHtml = new StringBuilder();

            // Reservation Information section
            contentHtml.append("<div class='row mb-4'>")
                    .append("<div class='col-md-6'>")
                    .append("<h6>Reservation Information</h6>")
                    .append("<div class='card'>")
                    .append("<div class='card-body'>")
                    .append("<p class='mb-2'><strong>Reservation ID:</strong> #").append(reservation.getId()).append("</p>")
                    .append("<p class='mb-2'><strong>Date:</strong> ").append(formatDate(reservation.getReservation_date())).append("</p>")
                    .append("<p class='mb-2'><strong>Time:</strong> ").append(formatTime(reservation.getCheckup_time())).append("</p>")
                    .append("<p class='mb-0'><strong>Status:</strong> ")
                    .append("<span class='status-badge status-").append(reservation.getStatus().toLowerCase()).append("'>")
                    .append(reservation.getStatus())
                    .append("</span></p>")
                    .append("</div></div></div></div>");

            // Services section
            contentHtml.append("<h6>Services</h6>");
            contentHtml.append("<div class='service-details'>");

            double totalCost = 0;
            for (ReservationService service : reservation.getList_service()) {
                double serviceTotal = service.getQuantity() * service.getUnit_price();
                totalCost += serviceTotal;

                contentHtml.append("<div class='row mb-3'>")
                        .append("<div class='col-md-8'>")
                        .append("<h5 class='mb-3'>").append(service.getService_name()).append("</h5>")
                        .append("<div class='d-flex justify-content-between align-items-center'>")
                        .append("<p class='service-price mb-0'>$").append(String.format("%.2f", service.getUnit_price())).append("</p>")
                        .append("<p class='mb-0'>Quantity: ").append(service.getQuantity()).append("</p>")
                        .append("</div></div></div>");
            }

            // Total section
            contentHtml.append("<div class='total-section mt-4'>")
                    .append("<div class='d-flex justify-content-between align-items-center'>")
                    .append("<h5>Total Amount</h5>")
                    .append("<h5 class='service-price'>$").append(String.format("%.2f", totalCost)).append("</h5>")
                    .append("</div></div>");

            contentHtml.append("</div>"); // Close service-details div

            // Add modal footer with cancel button if applicable
            contentHtml.append("<div class='modal-footer'>");

            // Only show cancel button if status isn't 'Cancel' or 'Success'
            if (!reservation.getStatus().equalsIgnoreCase("Cancel")
                    && !reservation.getStatus().equalsIgnoreCase("Success")) {

                // Get current timestamp and checkup time
                Timestamp currentTime = new Timestamp(System.currentTimeMillis());
                Timestamp checkupTime = reservation.getCheckup_time();

                // Calculate time difference in days
                long diffInMillies = checkupTime.getTime() - currentTime.getTime();
                long diffInDays = diffInMillies / (24 * 60 * 60 * 1000);

                if (diffInDays >= 3) {
                    contentHtml.append("<button type='button' class='btn btn-danger' onclick='cancelReservation(")
                            .append(reservation.getId())
                            .append(")'>Cancel Appointment</button>");
                } else {
                    contentHtml.append("<button type='button' class='btn btn-danger' disabled ")
                            .append("title='Cannot cancel within 3 days of appointment'>Cancel Appointment</button>");
                }
            }

            contentHtml.append("<button type='button' class='btn btn-secondary' data-bs-dismiss='modal'>Close</button>")
                    .append("</div>");

            // Send HTML response
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write(contentHtml.toString());

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("<div class='alert alert-danger'>Error loading reservation details: " + e.getMessage() + "</div>");
            e.printStackTrace();
        }
    }

    private void handleCancelReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JsonObject jsonResponse = new JsonObject();

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ReservationDAO reservationDAO = new ReservationDAO();
            Reservation reservation = reservationDAO.getReservationById(id);

            if (reservation == null) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Reservation not found");
                response.getWriter().write(jsonResponse.toString());
                return;
            }

            if (reservation.getStatus().equalsIgnoreCase("Cancel")) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Reservation is already cancelled");
                response.getWriter().write(jsonResponse.toString());
                return;
            }

            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            Timestamp checkupTime = reservation.getCheckup_time();
            long diffInMillies = checkupTime.getTime() - currentTime.getTime();
            long diffInDays = diffInMillies / (24 * 60 * 60 * 1000);

            if (diffInDays < 3) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Cannot cancel reservation within 3 days of appointment");
                response.getWriter().write(jsonResponse.toString());
                return;
            }

            boolean updated = reservationDAO.updateReservationStatus(id, "Cancel");

            if (updated) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Reservation cancelled successfully");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Failed to cancel reservation");
            }

        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error: " + e.getMessage());
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());
    }

    private String formatDate(Timestamp timestamp) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy");
        return dateFormat.format(timestamp);
    }

    private String formatTime(Timestamp timestamp) {
        SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");
        return timeFormat.format(timestamp);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
