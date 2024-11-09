/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ReservationDAO;
import dal.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Reservation;
import model.User;
import dal.UserDAO;

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
                response.sendRedirect("reservation-manager");
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
