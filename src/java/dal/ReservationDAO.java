/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Reservation;

/**
 *
 * @author ACER
 */
public class ReservationDAO extends DBContext{

    PreparedStatement stm;
    ResultSet rs;

    public List<Reservation> getAllReservation() {
        List<Reservation> ulist = new ArrayList<>();
        String s = "Select * from reservation";
        try {
            stm = connection.prepareStatement(s);
            rs = stm.executeQuery();
            while (rs.next()) {
                Reservation u = new Reservation(rs.getInt("id"), rs.getInt("customer_id"), rs.getTimestamp("reservation_date"), rs.getInt("status_id"), rs.getInt("staff_id"), rs.getInt("receiver_id"), rs.getTimestamp("checkup_time"));
                ulist.add(u);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ulist;
    }

    public int addReservation(Reservation reser) throws SQLException {
        String sql = "INSERT INTO reser (customer_id, reservation_date, status_id, staff_id, receiver_id, checkup_time) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, reser.getCustomer_id());
            stmt.setTimestamp(2, reser.getReservation_date());
            stmt.setInt(3, reser.getStatus_id());
            stmt.setInt(4, reser.getStaff_id());
            stmt.setInt(5, reser.getReceiver_id());
            stmt.setTimestamp(6, reser.getCheckup_time());

            return stmt.executeUpdate();
        }
    }

    public static void main(String[] args) {
        ReservationDAO userdao = new ReservationDAO();
        List<Reservation> ulist = userdao.getAllReservation();
        System.out.println(ulist.get(0).getCustomer_id());
        System.out.println(ulist.get(0).getCheckup_time());
        
//        for (Reservation u : ulist) {
//            System.out.println(u.getId());
//            //System.out.println(u.getId());
//        }
//        Reservation newReservation = new Reservation();
//            newReservation.setEmail("giangtthe153299@fpt.edu.vn");
//            newReservation.setPassword("password123");
//            newReservation.setFullName("Test Reservation");
//            newReservation.setGender(true);
//            newReservation.setMobile("1234567890");
//            newReservation.setAddress("123 Test Street");
//            newReservation.setImageLink("default.jpg");
//            newReservation.setRoleId(4);
//            newReservation.setStatus(17);

//            try {
//            // Gọi phương thức addReservation để thêm người dùng mới
//            int result = userdao.addReservation(newReservation);
//            if (result > 0) {
//            System.out.println("Reservation added successfully!");
//            } else {
//            System.out.println("Failed to add user.");
//            }
//            } catch (SQLException ex) {
//            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        try {
//            System.out.println(userdao.getReservationByEmail("thanhthanh16102004@gmail.com"));
//        } catch (SQLException ex) {
//            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
    }
}
