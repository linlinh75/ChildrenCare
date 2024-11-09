/*
         * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
         * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ReservationDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.sql.Timestamp;
import java.util.Random;
import javax.mail.MessagingException;
import model.Reservation;
import model.User;
import util.EmailSender;

/**
 *
 * @author Admin
 */
public class ReservationCompletionServlet extends HttpServlet {

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
            out.println("<title>Servlet ReservationCompletionServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReservationCompletionServlet at " + request.getContextPath() + "</h1>");
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
        doPost(request, response);
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
        try {
            Reservation res = (Reservation) request.getAttribute("reservation");
            String optionPayment = res.getPay_option();
            System.out.println(optionPayment);
            HttpSession session = request.getSession(false);
            ReservationDAO reservationDao = new ReservationDAO();
            UserDAO userDao = new UserDAO();
            EmailSender e = new EmailSender();
            Timestamp registeredTime = res.getCheckup_time();
            int rid = (int) request.getAttribute("reservationId");
            session.setAttribute("rid", rid);
            System.out.println(rid);
            int amount = reservationDao.getTotal(rid);
            Random rand = new Random();
            // Obtain a number between [0 - max id].
            int countFreeDoctors = userDao.listDoctorFree(registeredTime).size();
                System.out.println(countFreeDoctors);
            int n;
            if(countFreeDoctors==1){
                n=0;
            }else{
                n = rand.nextInt(userDao.listDoctorFree(registeredTime).size() - 1);
            }
            User assignDoctor = userDao.listDoctorFree(registeredTime).get(n);
            reservationDao.changeStaffReservation(rid, assignDoctor.getId());
            reservationDao.assignWorkSchedule(rid,assignDoctor.getId() , registeredTime);
            reservationDao.statusReservation(rid,"Submitted");
            User user = userDao.getProfileById(res.getCustomer_id());
            try {
                String content = "<p>Your reservation has been approved. Your doctor is Dr. "
                        + assignDoctor.getFullName() + ". Email: " + assignDoctor.getEmail()
                        + ". Mobile: " + assignDoctor.getMobile()
                        + ". Please complete the transaction by transfering the fees by VNPAY: </p>"
                        + "<a href='http://localhost:8080/ChildrenCare/vnpay_pay.jsp?amount=" + amount + "'>Click this link to pay fees</a>";
                String subject = "Reservation Completion and Payment Guide";
                EmailSender.sendHtml(user.getEmail(), content, subject);
                request.setAttribute("message", "Email sent");
        request.getRequestDispatcher("/customer-reservationServiceCart.jsp").forward(request, response);
            } catch (MessagingException ex) {
                Logger.getLogger(ReservationCompletionServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(ReservationCompletionServlet.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //   }
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
