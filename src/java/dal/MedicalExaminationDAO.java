/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.MedicalExamination;
import model.Reservation;
import model.ReservationService;
import model.Service;
import model.User;

/**
 *
 * @author Admin
 */
public class MedicalExaminationDAO extends DBContext{
    PreparedStatement stm;
    ResultSet rs;
    ReservationDAO reservationDAO = new ReservationDAO();
    ServiceDAO  serviceDAO = new ServiceDAO();
    UserDAO userDAO = new UserDAO();
    public List<MedicalExamination> getAllExaminationByAuthor (int author_id){
        List<MedicalExamination> list = new ArrayList<>();
        try {
            String sql = "select m.reservation_id, m.service_id, s.fullname as service_name, m.user_id, r.full_name as receiver_name, \n" +
"                        r.gender, r.email, m.prescription, m.author_id\n" +
"                         from medical_examination m INNER JOIN service s\n" +
"                         on m.service_id = s.id\n" +
"                        join user r on m.user_id = r.id\n" +
"                         where m.author_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, author_id);
            rs = stm.executeQuery();
            while(rs.next()){
                MedicalExamination m = new MedicalExamination();
                ReservationService r = new ReservationService();
                Reservation re = reservationDAO.getReservationById(rs.getInt("reservation_id"));
                r.setReservation_id(re.getId());
                Service s = serviceDAO.getServiceById(rs.getInt("service_id"));
                r.setService_id(s.getId());
                m.setReservationService(r);
                User receiver = userDAO.getProfileById(rs.getInt("receiver_id"));
                m.setUser(receiver);
                m.setPrescription(rs.getString("prescription"));
                list.add(m);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        
    }
    
}
