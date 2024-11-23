package controller;
import com.google.gson.Gson;
import dal.ReservationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.DateToMap;
import model.StatToMap;
import model.StatsPerDay;



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

        LocalDate startDate;
        LocalDate endDate;

        // Parse the start and end dates from request parameters
        if (request.getParameter("startDate") != null && request.getParameter("endDate") != null) {
            startDate = LocalDate.parse(request.getParameter("startDate"));
            endDate = LocalDate.parse(request.getParameter("endDate"));
        } else {
            startDate = LocalDate.now().minusDays(7);
            endDate = LocalDate.now();
        }

        // Fetch reservation statistics from DAO
        List<StatToMap> statsAll = new ArrayList<>();
        statsAll.add(new StatToMap(1,"success", reservationDAO.getReservationCount("Successful", startDate, endDate)));
        statsAll.add(new StatToMap(2,"cancelled", reservationDAO.getReservationCount("Cancelled", startDate, endDate)));
        statsAll.add(new StatToMap(3,"submitted", reservationDAO.getReservationCount("Submitted", startDate, endDate)));
        statsAll.add(new StatToMap(4,"approved", reservationDAO.getReservationCount("Approved", startDate, endDate)));
        statsAll.add(new StatToMap(5,"pending", reservationDAO.getReservationCount("Pending", startDate, endDate)));

        
        
        List<DateToMap> dateEntries = new ArrayList<>();
        int id = 1; 

        for (int i = 0; i <= 6; i++) {
            LocalDate currentDate = startDate.plusDays(i);
            dateEntries.add(new DateToMap(id++, currentDate.toString())); 
        }
        
        Map<String,LocalDate> date_stats = new HashMap<>();
        Map<LocalDate,List<StatToMap>> statsPerDay = new HashMap<>();
        int id2 = 1;
        for (int i = 0; i <= 6; i++) {
            List<StatToMap> listStatsPerDay = new ArrayList<>();
            LocalDate currentDate = startDate.plusDays(i);
             listStatsPerDay.add(new StatToMap(1,"inprogress", reservationDAO.getReservationCount("In Progress", currentDate)));
        listStatsPerDay.add(new StatToMap(2,"cancelled", reservationDAO.getReservationCount("Cancelled", currentDate)));
        listStatsPerDay.add(new StatToMap(3,"wait", reservationDAO.getReservationCount("Waiting for payment", currentDate)));
        listStatsPerDay.add(new StatToMap(4,"arrived", reservationDAO.getReservationCount("Arrived", currentDate)));
        listStatsPerDay.add(new StatToMap(5,"examining", reservationDAO.getReservationCount("Examining", currentDate)));
        listStatsPerDay.add(new StatToMap(6,"all", reservationDAO.getReservationCount("", currentDate)));
        listStatsPerDay.add(new StatToMap(7,"examined", reservationDAO.getReservationCount("Examined", currentDate)));
        listStatsPerDay.add(new StatToMap(8,"completed", reservationDAO.getReservationCount("Completed", currentDate)));
        listStatsPerDay.add(new StatToMap(9,"pending", reservationDAO.getReservationCount("Pending", currentDate)));
        statsPerDay.put(currentDate, listStatsPerDay);
        }
        int i=1;
        List<StatsPerDay> result = new ArrayList<>();
        for(LocalDate day:statsPerDay.keySet()){
            result.add(new StatsPerDay(i,day.toString(),statsPerDay.get(day)));
        }
        
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("stats", statsAll);
        responseMap.put("dates", dateEntries);
        responseMap.put("statsPerDay", result);
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(responseMap);
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }
}
