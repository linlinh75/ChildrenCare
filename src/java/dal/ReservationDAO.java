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
import model.ReservationService;

/**
 *
 * @author ACER
 */
public class ReservationDAO extends DBContext {

    ServiceDAO service = new ServiceDAO();
    static PreparedStatement stm;
    ResultSet rs;

    public List<Reservation> getAllReservation() {
        List<Reservation> ulist = new ArrayList<>();
        String s = "SELECT * \n"
                + "FROM swp.reservation r \n"
                + "JOIN swp.reservation_service s ON r.id = s.reservation_id \n"
                + "JOIN swp.user u ON r.customer_id = u.id;";

        try {
            stm = connection.prepareStatement(s);
            rs = stm.executeQuery();
            while (rs.next()) {
                Reservation reservation = null;
                for (Reservation res : ulist) {
                    if (res.getId() == rs.getInt("reservation_id")) {
                        reservation = res;
                        break;
                    }
                }

                if (reservation == null) {
                    List<ReservationService> serviceList = new ArrayList<>();
                    reservation = new Reservation(
                            rs.getInt("reservation_id"),
                            rs.getInt("customer_id"),
                            rs.getTimestamp("reservation_date"),
                            rs.getString("status"),
                            rs.getInt("staff_id"),
                            rs.getTimestamp("checkup_time"),
                            serviceList,
                            rs.getString("full_name")
                    );
                    ulist.add(reservation);
                }

                ReservationService reservationService = new ReservationService(
                        reservation.getId(), // reservation_id
                        rs.getInt("service_id"),
                        rs.getInt("quantity"),
                        rs.getFloat("unit_price"),
                        service.getServiceById(rs.getInt("service_id")).getFullname()
                );

                reservation.getList_service().add(reservationService);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return ulist;
    }

    public List<Reservation> getReservationbyCustomerId(int id) {
        List<Reservation> ulist = new ArrayList<>();
        String s = "SELECT * \n"
                + "FROM swp.reservation r \n"
                + "JOIN swp.reservation_service s ON r.id = s.reservation_id \n"
                + "JOIN swp.user u ON r.customer_id = u.id WHERE customer_id = ?";

        try {
            stm = connection.prepareStatement(s);
            stm.setInt(1, id);
            rs = stm.executeQuery();

            while (rs.next()) {
                Reservation reservation = null;
                for (Reservation res : ulist) {
                    if (res.getId() == rs.getInt("reservation_id")) {
                        reservation = res;
                        break;
                    }
                }

                if (reservation == null) {
                    List<ReservationService> serviceList = new ArrayList<>();
                    reservation = new Reservation(
                            rs.getInt("reservation_id"),
                            rs.getInt("customer_id"),
                            rs.getTimestamp("reservation_date"),
                            rs.getString("status"),
                            rs.getInt("staff_id"),
                            rs.getTimestamp("checkup_time"),
                            serviceList,
                            rs.getString("full_name")
                    );
                    ulist.add(reservation);
                }

                ReservationService reservationService = new ReservationService(
                        reservation.getId(), // reservation_id
                        rs.getInt("service_id"),
                        rs.getInt("quantity"),
                        rs.getFloat("unit_price"),
                        service.getServiceById(rs.getInt("service_id")).getFullname()
                );

                reservation.getList_service().add(reservationService);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return ulist;
    }

    public int addReservation(Reservation reser) throws SQLException {
        String sql = "INSERT INTO reser (customer_id, reservation_date, status, staff_id, checkup_time) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, reser.getCustomer_id());
            stmt.setTimestamp(2, reser.getReservation_date());
            stmt.setString(3, reser.getStatus());
            stmt.setInt(4, reser.getStaff_id());
            stmt.setTimestamp(5, reser.getCheckup_time());

            return stmt.executeUpdate();
        }
    }

    public Reservation getReservationById(int id) {
        Reservation reservation = null;
        String s = "SELECT * \n"
                + "FROM swp.reservation r \n"
                + "JOIN swp.reservation_service s ON r.id = s.reservation_id \n"
                + "JOIN swp.user u ON r.customer_id = u.id WHERE r.id = ?";

        try {
            stm = connection.prepareStatement(s);
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                List<ReservationService> serviceList = new ArrayList<>();
                reservation = new Reservation(
                        rs.getInt("reservation_id"),
                        rs.getInt("customer_id"),
                        rs.getTimestamp("reservation_date"),
                        rs.getString("status"),
                        rs.getInt("staff_id"),
                        rs.getTimestamp("checkup_time"),
                        serviceList,
                        rs.getString("full_name")
                );

                do {
                    ReservationService reservationService = new ReservationService(
                            reservation.getId(), // reservation_id
                            rs.getInt("service_id"),
                            rs.getInt("quantity"),
                            rs.getFloat("unit_price"),
                            service.getServiceById(rs.getInt("service_id")).getFullname()
                    );

                    reservation.getList_service().add(reservationService);
                } while (rs.next()); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return reservation;
    }
    public void changeStaffReservation(int reservation_id, int staff_id) {
        try {
            String sql = "update reservation set reservation.staff_id = ?\n"
                    + "where reservation.id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, staff_id);
            stm.setInt(2, reservation_id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public  void statusReservation(int reservation_id, String status) {
        try {
            String sql = "update reservation set reservation.status = ?\n"
                    + "where reservation.id = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, reservation_id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public static void main(String[] args) {
        ReservationDAO userdao = new ReservationDAO();
        List<Reservation> ulist = userdao.getAllReservation();
        System.out.println(ulist.get(0).getCustomer_id());
        System.out.println(ulist.get(0).getCheckup_time());
        System.out.println(ulist.get(0).getList_service().get(0));

//        for (Reservation u : ulist) {
//            System.out.println(u.getId());
//            //System.out.println(u.getId());
//        }
    }
}
