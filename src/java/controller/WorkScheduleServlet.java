/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ReservationDAO;
import dal.ServiceDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Reservation;
import dal.WorkScheduleDAO;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ReservationService;
import model.Service;
import model.User;
import model.WorkSchedule;

/**
 *
 * @author admin
 */
@WebServlet(name = "WorkScheduleServlet", urlPatterns = {"/staff-work-schedule"})
public class WorkScheduleServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

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
            HttpSession session = request.getSession();
            User loggedInUser = (User) session.getAttribute("account");
            ServiceDAO sv = new ServiceDAO();
            List<Service> slist = sv.getAllService();
            WorkScheduleDAO ws = new WorkScheduleDAO();
            List<WorkSchedule> list_schedule = ws.getWorkScheduleByDoctorId(loggedInUser.getId());
            UserDAO u = new UserDAO();
            List<User> ulist = u.getAllUser();
            request.setAttribute("service", sv);
            request.setAttribute("allservice", slist);
            request.setAttribute("users", ulist);
            request.setAttribute("schedule", list_schedule);
            request.setAttribute("reservation", reservationDAO);
            String action = request.getParameter("action");
            if (action != null) {
                if (action.equals("detail")) {
                    int res_id = Integer.parseInt(request.getParameter("rid"));
                    Reservation res = reservationDAO.getReservationById(res_id);
                    request.setAttribute("res", res);
                    request.getRequestDispatcher("/staff-reservation-detail.jsp").forward(request, response);
                    return;
                } else if (action.equals("start")) {
                    int res_id = Integer.parseInt(request.getParameter("rid"));
                    reservationDAO.statusReservation(res_id, "Examining", res_id);
                    request.getRequestDispatcher("/staff-work-schedule?action=detail&rid=" + res_id).forward(request, response);
                    return;
                }

            }
            request.getRequestDispatcher("/staff-work-schedule.jsp").forward(request, response);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        ServiceDAO sv = new ServiceDAO();
        List<Service> slist = sv.getAllService();
        int res_id = Integer.parseInt(request.getParameter("resid"));
        System.out.println("adding");
        String selectedServiceIds = request.getParameter("selectedServiceIds");
        System.out.println(selectedServiceIds);
        if (selectedServiceIds != null && !selectedServiceIds.isEmpty()) {
            String[] serviceIdArray = selectedServiceIds.split(",");
            Reservation reservation = reservationDAO.getReservationById(res_id);
            List<ReservationService> existingServices = reservation.getList_service();
            for (String serviceIdStr : serviceIdArray) {
                int serviceId = Integer.parseInt(serviceIdStr);
                boolean exists = existingServices.stream()
                        .anyMatch(service -> service.getService_id() == serviceId);
                if (!exists) {
                    Service service = sv.getServiceById(serviceId);
                    ReservationService newService = new ReservationService(
                            res_id,
                            service.getId(),
                            1,
                            service.getSalePrice(),
                            service.getFullname()
                    );
                    existingServices.add(newService);
                }
            }
            reservation.setList_service(existingServices);
            try {
                reservationDAO.addService(res_id, reservation);
            } catch (SQLException ex) {
                Logger.getLogger(WorkScheduleServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        response.sendRedirect(request.getContextPath() + "/staff-work-schedule?action=detail&rid=" + res_id);
        //request.getRequestDispatcher("/staff-work-schedule?action=detail&rid=" + res_id).forward(request, response);

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
