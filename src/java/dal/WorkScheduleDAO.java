/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;

import model.WorkSchedule;

public class WorkScheduleDAO extends DBContext {

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public List<WorkSchedule> getWorkScheduleByDoctorId(int serviceId) {
        List<WorkSchedule> listWorkSchedules = new ArrayList<>();
        String sql = "SELECT * FROM swp.work_schedule WHERE doctor_id =? order by start_at desc;";
        try {
            if (connection != null) {
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setObject(1, serviceId);
                ResultSet rs = statement.executeQuery();
                while (rs.next()) {
                    WorkSchedule ws = getFromResultSet(rs);
                    listWorkSchedules.add(ws);
                }
            } else {
                System.out.println("Connection is null, cannot execute query.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listWorkSchedules;
    }

    public WorkSchedule getFromResultSet(ResultSet rs) throws SQLException {
        DateTimeFormatter formatte = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        WorkSchedule ws = new WorkSchedule(
                rs.getInt("reservation_id"),
                rs.getInt("doctor_id"),
                LocalDateTime.parse(rs.getString("start_at").trim(), formatte), 
                LocalDateTime.parse(rs.getString("end_at").trim(), formatte) 
        );

        return ws;
    }

    public static void main(String[] args) {
//        WorkScheduleDAO ws = new WorkScheduleDAO();
//        List<WorkSchedule> wlist = ws.getWorkScheduleByDoctorId(3);
//        for (WorkSchedule w : wlist) {
//            System.out.println(w.getReservation_id());
//        }
//    }
    }
}
