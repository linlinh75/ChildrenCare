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
import model.User;

/**
 *
 * @author admin
 */
@WebServlet(name = "ReservationCashierServlet", urlPatterns = {"/cashier-reservation"})
public class ReservationCashierServlet extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReservationCashierServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReservationCashierServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("account");
        ServiceDAO sv = new ServiceDAO();
        List<Reservation> list_reservation = reservationDAO.getAllReservation();
        UserDAO u = new UserDAO();
        List<User> ulist = u.getAllUser();
        request.setAttribute("service", sv);
        request.setAttribute("users", ulist);
        request.setAttribute("reservation", list_reservation);
        ReservationDAO r = new ReservationDAO();
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("checkin")) {
                double totalcost = Double.parseDouble(request.getParameter("totalCost"));
                int res_id = Integer.parseInt(request.getParameter("rid"));
                r.checkin(res_id, (int) totalcost);
                response.sendRedirect("cashier-reservation");
                return;
            }
            else if (action.equals("checkout")) {
                double totalcost = Double.parseDouble(request.getParameter("totalCost"));
                int res_id = Integer.parseInt(request.getParameter("rid"));
                Reservation res = r.getReservationById(res_id);
                r.checkout(res_id, (int) totalcost,res.getCustomer_id());
                response.sendRedirect("cashier-reservation");
                return;
            }
        }
        request.getRequestDispatcher("cashier-reservation.jsp").forward(request, response);
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
        processRequest(request, response);
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
