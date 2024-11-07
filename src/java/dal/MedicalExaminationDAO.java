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
            String sql = "SELECT m.id, m.reservation_id, m.user_id, u.full_name, " +
                        "u.gender, u.email, m.prescription, m.author_id " +
                        "FROM medical_examination m " +
                        "INNER JOIN user u ON m.user_id = u.id " +
                        "WHERE m.author_id = ? ";
                     
            stm = connection.prepareStatement(sql);
            stm.setInt(1, author_id);
            rs = stm.executeQuery();
            
            while(rs.next()) {
                MedicalExamination m = new MedicalExamination();
                m.setId(rs.getInt("id"));
                
                ReservationService r = new ReservationService();
                r.setReservation_id(rs.getInt("reservation_id"));
                
                User receiver = new User();
                receiver.setId(rs.getInt("user_id"));
                receiver.setFullName(rs.getString("full_name"));
                receiver.setGender(rs.getBoolean("gender"));
                receiver.setEmail(rs.getString("email"));
                m.setUser(receiver);
                m.setReservationService(r);
                m.setPrescription(rs.getString("prescription"));
                m.setAuthor_id(rs.getInt("author_id"));
                
                list.add(m);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(MedicalExaminationDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public boolean addMedicalExamination(MedicalExamination exam) {
        try {
            String sql = "INSERT INTO medical_examination (reservation_id, user_id, prescription, author_id) " +
                        "VALUES (?, ?, ?, ?)";
                    
            stm = connection.prepareStatement(sql);
            stm.setInt(1, exam.getReservationService().getReservation_id());
            stm.setInt(2, exam.getUser().getId());
            stm.setString(3, exam.getPrescription());
            stm.setInt(4, exam.getAuthor_id());
            
            return stm.executeUpdate() > 0;
            
        } catch (SQLException ex) {
            Logger.getLogger(MedicalExaminationDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public List<Reservation> getPendingReservations() {
        List<Reservation> list = new ArrayList<>();
        try {
            String sql = "SELECT r.*, u.full_name " +
                        "FROM reservation r " +
                        "JOIN user u ON r.customer_id = u.id " + 
                        "WHERE r.checkup_time <= NOW() " +
                        "AND r.id NOT IN (SELECT reservation_id FROM medical_examination)";
                    
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            
            while(rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setCustomer_id(rs.getInt("customer_id")); 
                r.setReservation_date(rs.getTimestamp("reservation_date"));
                r.setStatus(rs.getString("status"));
                r.setStaff_id(rs.getInt("staff_id"));
                r.setCheckup_time(rs.getTimestamp("checkup_time"));
                r.setCustomer_name(rs.getString("full_name"));
                
                list.add(r);
            }
        } catch (SQLException ex) {
            Logger.getLogger(MedicalExaminationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public MedicalExamination getExaminationById(int id) {
        try {
            String sql = "SELECT m.id, m.reservation_id, m.user_id, u.full_name, " +
                        "u.gender, u.email, m.prescription, m.author_id " +
                        "FROM medical_examination m " +
                        "INNER JOIN user u ON m.user_id = u.id " +
                        "WHERE m.id = ?";
                 
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            
            if(rs.next()) {
                MedicalExamination m = new MedicalExamination();
                m.setId(rs.getInt("id"));
                
                ReservationService r = new ReservationService();
                r.setReservation_id(rs.getInt("reservation_id"));
                
                User receiver = new User();
                receiver.setId(rs.getInt("user_id"));
                receiver.setFullName(rs.getString("full_name"));
                receiver.setGender(rs.getBoolean("gender"));
                receiver.setEmail(rs.getString("email"));
                
                m.setUser(receiver);
                m.setReservationService(r);
                m.setPrescription(rs.getString("prescription"));
                m.setAuthor_id(rs.getInt("author_id"));
                
                return m;
            }
            return null;
        } catch (SQLException ex) {
            Logger.getLogger(MedicalExaminationDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public boolean updateMedicalExamination(MedicalExamination exam) {
        try {
            String sql = "UPDATE medical_examination SET prescription = ? WHERE id = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, exam.getPrescription());
            stm.setInt(2, exam.getId());
            
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(MedicalExaminationDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean deleteMedicalExamination(int id) {
        try {
            String sql = "DELETE FROM medical_examination WHERE id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(MedicalExaminationDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}
