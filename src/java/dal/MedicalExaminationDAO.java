/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.MedicalExamination;
import model.Medicine;
import model.Reservation;
import model.ReservationService;
import model.User;
import java.time.LocalDateTime;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Admin
 */
public class MedicalExaminationDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;
    ReservationDAO reservationDAO = new ReservationDAO();
    ServiceDAO serviceDAO = new ServiceDAO();
    UserDAO userDAO = new UserDAO();

   public List<Medicine> getMedicinesByExamination(int exam_id) {
    List<Medicine> listMed = new ArrayList<>();
    String sql = "SELECT * FROM medicines WHERE examination_id = ?";
    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        stm.setInt(1, exam_id);
        try (ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Medicine md = new Medicine();
                md.setId(rs.getInt("id"));
                md.setExaminationId(rs.getInt("examination_id"));
                md.setMedicineName(rs.getString("medicine_name"));
                md.setDosage(rs.getString("dosage"));
                md.setInstructions(rs.getString("instructions"));
                listMed.add(md);
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(MedicalExaminationDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
    return listMed;
   }

    public List<MedicalExamination> getAllExaminationByAuthor(int author_id) {
    List<MedicalExamination> list = new ArrayList<>();
    String sql = "SELECT m.id, m.reservation_id, m.user_id, u.full_name, " +
                 "u.gender, u.email, m.prescription, m.author_id, m.create_date " +
                 "FROM medical_examination m " +
                 "INNER JOIN user u ON m.user_id = u.id " +
                 "WHERE m.author_id = ?";
    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        stm.setInt(1, author_id);
        try (ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                MedicalExamination m = new MedicalExamination();
                m.setId(rs.getInt("id"));

                // Populate ReservationService
                ReservationService r = new ReservationService();
                r.setReservation_id(rs.getInt("reservation_id"));

                // Populate User
                User receiver = new User();
                receiver.setId(rs.getInt("user_id"));
                receiver.setFullName(rs.getString("full_name"));
                receiver.setGender(rs.getBoolean("gender"));
                receiver.setEmail(rs.getString("email"));

                // Populate MedicalExamination
                m.setPrescription(rs.getString("prescription"));
                m.setAuthor_id(rs.getInt("author_id"));
                m.setUser(receiver);
                m.setReservationService(r);
                m.setDate(rs.getTimestamp("create_date"));
                // Retrieve Medicines
                List<Medicine> listMed = getMedicinesByExamination(m.getId());
                m.setMedicines(listMed);

                list.add(m);
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(MedicalExaminationDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
    return list;
}


//    public boolean addMedicalExamination(MedicalExamination exam) {
//        try {
//            String sql = "INSERT INTO medical_examination (reservation_id, user_id, prescription, author_id) "
//                    + "VALUES (?, ?, ?, ?)";
//
//            stm = connection.prepareStatement(sql);
//            stm.setInt(1, exam.getReservationService().getReservation_id());
//            stm.setInt(2, exam.getUser().getId());
//            stm.setString(3, exam.getPrescription());
//            stm.setInt(4, exam.getAuthor_id());
//
//            return stm.executeUpdate() > 0;
//
//        } catch (SQLException ex) {
//            Logger.getLogger(MedicalExaminationDAO.class.getName()).log(Level.SEVERE, null, ex);
//            return false;
//        }
//    }
public boolean addMedicalExamination(MedicalExamination exam) {
    String insertExamSQL = "INSERT INTO medical_examination (reservation_id,user_id, prescription, author_id, create_date) VALUES (?, ?, ?,?,?)";
    String insertMedicineSQL = "INSERT INTO medicines (examination_id, medicine_name, dosage, instructions) VALUES (?, ?, ?, ?)";

    try (PreparedStatement examStm = connection.prepareStatement(insertExamSQL, PreparedStatement.RETURN_GENERATED_KEYS)) {
        // Insert Medical Examination
        examStm.setInt(1, exam.getReservationService().getReservation_id());
        examStm.setInt(2, exam.getUser().getId());
        examStm.setString(3, exam.getPrescription());
        examStm.setInt(4, exam.getAuthor_id());
        examStm.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
        int affectedRows = examStm.executeUpdate();

        if (affectedRows == 0) {
            throw new SQLException("Creating examination failed, no rows affected.");
        }

        // Retrieve the generated ID for the examination
        int examId;
        try (ResultSet generatedKeys = examStm.getGeneratedKeys()) {
            if (generatedKeys.next()) {
                examId = generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating examination failed, no ID obtained.");
            }
        }

        // Insert Medicines
        try (PreparedStatement medStm = connection.prepareStatement(insertMedicineSQL)) {
            for (Medicine med : exam.getMedicines()) {
                medStm.setInt(1, examId);
                medStm.setString(2, med.getMedicineName());
                medStm.setString(3, med.getDosage());
                medStm.setString(4, med.getInstructions());
                medStm.addBatch();
            }
            medStm.executeBatch(); // Execute all medicine inserts in a batch
        }
        return true;
    } catch (SQLException ex) {
        Logger.getLogger(MedicalExaminationDAO.class.getName()).log(Level.SEVERE, null, ex);
        return false;
    }
}

    public List<Reservation> getApprovedReservations(int staff_id) {
        List<Reservation> list = new ArrayList<>();
        try {
            String sql = "SELECT r.*, u.full_name "
                    + "FROM reservation r "
                    + "JOIN user u ON r.customer_id = u.id "
                    + "WHERE r.checkup_time <= NOW() "
                    + "AND r.id NOT IN (SELECT reservation_id FROM medical_examination)"
                    + "AND r.status='Examining' AND r.staff_id=?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, staff_id);
            rs = stm.executeQuery();

            while (rs.next()) {
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
            String sql = "SELECT m.id, m.reservation_id, m.user_id, u.full_name, "
                    + "u.gender, u.email, m.prescription, m.author_id "
                    + "FROM medical_examination m "
                    + "INNER JOIN user u ON m.user_id = u.id "
                    + "WHERE m.id = ?";

            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
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
