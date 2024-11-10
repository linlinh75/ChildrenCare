/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ReservationDAO;
<<<<<<< HEAD:src/java/controller/ReservationAdminServlet.java
import dal.UserDAO;
=======
import dal.ServiceDAO;
>>>>>>> d8692e10150601cca1e17380dcd62da5cdac0335:src/java/controller/ReservationManagerServlet.java
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import model.Reservation;
import model.User;
<<<<<<< HEAD:src/java/controller/ReservationAdminServlet.java
import model.WorkSchedule;
import util.EmailSender;
=======
import dal.UserDAO;
>>>>>>> d8692e10150601cca1e17380dcd62da5cdac0335:src/java/controller/ReservationManagerServlet.java

@WebServlet(name = "ReservationManagerServlet", urlPatterns = {"/reservation-manager"})
public class ReservationManagerServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("account");
        ServiceDAO sv = new ServiceDAO();
        List<Reservation> list_reservation = reservationDAO.getAllReservation();
        UserDAO u = new UserDAO();
        List<User> ulist= u.getAllUser();
        request.setAttribute("service", sv);
        request.setAttribute("users", ulist);
        request.setAttribute("reservation", list_reservation);
        request.getRequestDispatcher("admin/admin_reservation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int reservationId = Integer.parseInt(request.getParameter("id"));

        switch (action) {
            case "approveReservation":
                
                reservationDAO.updateReservationStatus(reservationId, "Approved");
<<<<<<< HEAD:src/java/controller/ReservationAdminServlet.java
                UserDAO userDao = new UserDAO();
                Reservation res = reservationDAO.getReservationById(reservationId);
                int amount = reservationDAO.getTotal(res.getId());
                HttpSession session = request.getSession(false);
                List<User> allDoctors = userDao.getUserByRoleId(3);
                List<WorkSchedule> worklist = new ArrayList<>();
                worklist = userDao.listDoctorBusy(res.getCheckup_time());
                List<User> listDoctorFree = new ArrayList<>(allDoctors);
                Random rand = new Random();
                for (WorkSchedule w : worklist) {
                    listDoctorFree.removeIf(doctor -> doctor.getId() == w.getDoctorId());
                }

                int countFreeDoctors = listDoctorFree.size();

                if (countFreeDoctors > 0) {

                    try {
                        
                        int n = (countFreeDoctors == 1) ? 0 : rand.nextInt(countFreeDoctors);
                        User assignDoctor = listDoctorFree.get(n);
                        
                        
                        reservationDAO.changeStaffReservation(res.getId(), assignDoctor.getId());
                        reservationDAO.assignWorkSchedule(res.getId(), assignDoctor.getId(), res.getCheckup_time());
                        
                        System.out.println("Assigned Doctor ID: " + assignDoctor.getId());
                        
                        User user = userDao.getProfileById(res.getCustomer_id());
                        try {
                            String content = "<p>Your reservation has been approved. Your doctor is Dr. "
                                    + assignDoctor.getFullName() + ". Email: " + assignDoctor.getEmail()
                                    + ". Mobile: " + assignDoctor.getMobile()
                                    + ". Please complete the transaction by transfering the fees by VNPAY: </p>"
                                    + "<a href='http://localhost:8080/ChildrenCare/vnpay_pay.jsp?amount=" + amount + "&rid="+res.getId()+"'>Click this link to pay fees</a>";
                            String subject = "Reservation Completion and Payment Guide";
                            EmailSender.sendHtml(user.getEmail(), content, subject);
                            request.setAttribute("res", res);
                            session.setAttribute("rid", res.getId());
                            
                        } catch (MessagingException ex) {
                            Logger.getLogger(ReservationCompletionServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    } catch (SQLException ex) {
                        Logger.getLogger(ReservationAdminServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else {
                    System.out.println("No available doctors at this time.");
                    
                }
                response.sendRedirect("reservation-admin");
=======
                response.sendRedirect("reservation-manager");
>>>>>>> d8692e10150601cca1e17380dcd62da5cdac0335:src/java/controller/ReservationManagerServlet.java
                break;
            case "cancelReservation":
                reservationDAO.updateReservationStatus(reservationId, "Cancelled");
                response.sendRedirect("reservation-manager");
                break;
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReservationAdminServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReservationAdminServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

}
