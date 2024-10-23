/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import model.Reservation;
import model.ReservationService;
import model.User;
import com.google.gson.Gson;
import dal.ReservationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Tran Thi Nguyet Ha
 */
public class ReservationContactController extends HttpServlet {

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
            out.println("<title>Servlet ReservationContactController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReservationContactController at " + request.getContextPath() + "</h1>");
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
        String action = request.getServletPath();
        switch (action) {
            case "/reservation/contact":
                getReservationInfo(request,response);
                break;
            case "/reservation/contact/addreceiver":
                addReceiverInfo(request,response);
                break;
            
            default:
//                getReservationInfoEdit(request, response);
                break;
        }
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
        this.doGet(request, response);

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


    private void getReservationInfo(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException{
        int rid = Integer.parseInt(request.getParameter("reservation_id"));
        ReservationDAO reservationDB = new ReservationDAO();
        Reservation reservation = reservationDB.getReservationById(rid);
        ArrayList<ReservationService> reservationServices  = reservationDB.getReservationServices(reservation);
        double totalCost = 0;
        for(ReservationService rs: reservationServices){
            totalCost += rs.getQuantity()*rs.getUnit_price();
        }
        User u = (User) request.getSession().getAttribute("user");
        request.setAttribute("reservation", reservation);
        request.setAttribute("services", reservationServices);
        request.setAttribute("user", u);
        request.setAttribute("totalCost", totalCost);
        request.getRequestDispatcher("../view/customer/reservation/reservationContact.jsp").forward(request, response);
    }

    private void addReceiverInfo(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException{
        User u = (User) request.getSession().getAttribute("user");
        int rid = Integer.parseInt(request.getParameter("rid"));
        ReservationDAO reservationDB = new ReservationDAO();
        String email = request.getParameter("email");
        if (u!=null){
        } else {
            u = new User();
            u.setId(-1);
        }
        
        
        String checkupTime = request.getParameter("checkup-time");
        try {
            java.util.Date utilDate = new SimpleDateFormat("dd/MM/yyyy").parse(checkupTime);
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            reservationDB.editCheckupTime(rid, sqlDate);

        } catch (ParseException ex) {
            Logger.getLogger(ReservationContactController.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("../reservationcompletion?rid=" + rid);
    }

    
}
