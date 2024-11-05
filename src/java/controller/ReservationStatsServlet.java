/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
// ReservationStatsServlet.java

import com.google.gson.Gson;
import dal.ReservationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/reservations/stats")
public class ReservationStatsServlet extends HttpServlet {
    private ReservationDAO reservationDAO;

    @Override
    public void init() {
        reservationDAO = new ReservationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Parse the start and end dates from request parameters
//        Date startDate = Date.valueOf(request.getParameter("startDate"));
//        Date endDate = Date.valueOf(request.getParameter("endDate"));
        Date startDate = Date.valueOf("2024-09-19");
        Date endDate = Date.valueOf("2024-09-25");

        // Fetch reservation statistics from DAO
        Map<String, Integer> stats = new HashMap<>();
        stats.put("success", reservationDAO.getReservationCount("Successful", startDate, endDate));
        stats.put("cancelled", reservationDAO.getReservationCount("Cancel", startDate, endDate));
        stats.put("submitted", reservationDAO.getReservationCount("Submitted", startDate, endDate));
        stats.put("approved", reservationDAO.getReservationCount("Approved", startDate, endDate));
        stats.put("pending", reservationDAO.getReservationCount("Pending", startDate, endDate));
        // Convert the map to JSON and write it to the response
        Gson gson = new Gson();
        String json = gson.toJson(stats);
        
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}
