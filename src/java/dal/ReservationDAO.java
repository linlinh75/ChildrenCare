/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
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
import model.Service;

/**
 *
 * @author ACER
 */
public class ReservationDAO extends DBContext {

    ServiceDAO service = new ServiceDAO();
    PreparedStatement stm;
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

                // Nếu Reservation chưa tồn tại, tạo mới
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
    
    public ArrayList<Reservation> getReservation(int userid) {
        try {
            ArrayList<Reservation> list = new ArrayList<Reservation>();
            String sql = "SELECT\n"
                    + "reservation.id,\n"
                    + "reservation.customer_id,\n"
                    + "reservation.reservation_date,\n"
                    + "reservation.status,\n"
                    + "reservation.staff_id,\n"
                    + "reservation.checkup_time\n"
                    + "FROM\n"
                    + "reservation\n"
                    + "WHERE customer_id =?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, userid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt("id"));
                r.setCustomer_id(rs.getInt("customer_id"));
                r.setReservation_date(rs.getTimestamp("reservation_date"));
                r.setStaff_id(rs.getInt("staff_id"));
                r.setCheckup_time(rs.getTimestamp("checkup_time"));
                r.setStatus(rs.getString("status"));
                list.add(r);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int addReservation(Reservation reser) throws SQLException {
        String sql = "INSERT INTO reservation (customer_id, reservation_date, status, staff_id, checkup_time) "
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

    public ArrayList<ReservationService> getReservationServices(Reservation reservation) {
        ArrayList<ReservationService> services = new ArrayList<>();

        try {
            String sql = "SELECT\n"
                    + "reservation_service.reservation_id,\n"
                    + "reservation_service.service_id,\n"
                    + "reservation_service.quantity,\n"
                    + "reservation_service.unit_price\n"
                    + "FROM\n"
                    + "reservation_service\n"
                    + "WHERE reservation_id=?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, reservation.getId());
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                ReservationService rerserReservationService = new ReservationService();
                rerserReservationService.setReservation_id(reservation.getId());
                rerserReservationService.setService_id(rs.getInt("service_id"));
                rerserReservationService.setQuantity(rs.getInt("quantity"));
                rerserReservationService.setUnit_price(rs.getFloat("unit_price"));
                services.add(rerserReservationService);
            }
            return services;
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public ArrayList<ReservationService> getReservationServices(Reservation reservation, Service service) {
        ArrayList<ReservationService> services = new ArrayList<>();

        try {
            String sql = "SELECT\n"
                    + "reservation_service.reservation_id,\n"
                    + "reservation_service.service_id,\n"
                    + "reservation_service.quantity,\n"
                    + "reservation_service.unit_price\n"
                    + "FROM\n"
                    + "reservation_service\n"
                    + "WHERE reservation_id=? and service_id =?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, reservation.getId());
            stm.setInt(2, service.getId());
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                ReservationService rerserReservationService = new ReservationService();
                rerserReservationService.setReservation_id(rs.getInt("reservation_id"));
                rerserReservationService.setService_id(rs.getInt("service_id"));
                rerserReservationService.setQuantity(rs.getInt("quantity"));
                rerserReservationService.setUnit_price(rs.getFloat("unit_price"));
                services.add(rerserReservationService);
            }
            return services;
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Reservation getReservationById(int id) {
        try {
            String sql = "SELECT\n"
                    + "reservation.id,\n"
                    + "reservation.customer_id,\n"
                    + "reservation.reservation_date,\n"
                    + "reservation.status,\n"
                    + "reservation.staff_id,\n"
                    + "reservation.checkup_time\n"
                    + "FROM\n"
                    + "reservation\n"
                    + "WHERE id =?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {

                Reservation s = new Reservation();
                s.setId(id);
                s.setCheckup_time(rs.getTimestamp("checkup_time"));
                s.setReservation_date(rs.getTimestamp("reservation_date"));
                s.setStatus(rs.getString("status"));
                s.setCustomer_id(rs.getInt("customer_id"));
                s.setStaff_id(rs.getInt("staff_id"));
                return s;

            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }
    
    public void editReservationService(int rid, int sid, int quantity) {
        try {
            String sql = "UPDATE reservation_service set quantity = ? where reservation_id =? and service_id=? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, quantity);
            stm.setInt(2, rid);
            stm.setInt(3, sid);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void deleteReservationService(Reservation r) {
        try {
            String sql = "delete from reservation_service where reservation_id =?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, r.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void deleteReservationService(int rid, int sid) {
        try {
            String sql = "delete from reservation_service where reservation_id =? and service_id =?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, rid);
            stm.setInt(2, sid);

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public int addPendingReservation(int userid) {
        int id = 0;
        try {
            String sql = "INSERT INTO `swp`.`reservation` (`customer_id`, `status`) VALUES (?, ?);";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, userid);
            stm.setString(2, "Pending");
            stm.executeUpdate();
            sql = "SELECT LAST_INSERT_ID() as id";
            stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                id = rs.getInt("id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;
    }
    
    public int getPendingReservation(int customerid) {
        int i = 0;
        try {
            String sql = "select id \n"
                    + "from reservation r\n"
                    + "where customer_id = ? and status='Pending'";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, customerid);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                i = rs.getInt("id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return i;
    }


    public void addReservationService(Reservation r, Service s, int quantity) {
        try {
            int current_quantity = checkReservationServiceExists(r, s);
            String sql = "select * from reservation_service";
            PreparedStatement stm = connection.prepareStatement(sql);
            if (current_quantity == 0) {
                sql = "INSERT INTO `swp`.`reservation_service`\n"
                        + "(`reservation_id`,\n"
                        + "`service_id`,\n"
                        + "`quantity`,\n"
                        + "`unit_price`)\n"
                        + "VALUES\n"
                        + "(?,\n"
                        + "?,\n"
                        + "?,\n"
                        + "?);";
                stm = connection.prepareStatement(sql);
                stm.setInt(1, r.getId());
                stm.setInt(2, s.getId());
                stm.setInt(3, quantity);
                stm.setFloat(4, s.getSalePrice());
            } else if (current_quantity > 0) {
                sql = "UPDATE `swp`.`reservation_service`\n"
                        + "SET\n"
                        + "`quantity` = ?\n"
                        + "WHERE `reservation_id` = ? AND `service_id` = ?";
                stm = connection.prepareStatement(sql);
                stm.setInt(1, current_quantity + quantity);
                stm.setInt(2, r.getId());
                stm.setInt(3, s.getId());
            }
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int checkReservationServiceExists(Reservation r, Service s) {
        int quantity = 0;
        try {
            String sql = "select * from reservation_service where reservation_id = ? and service_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, r.getId());
            stm.setInt(2, s.getId());
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("quantity");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return quantity;
    }

    public static void main(String[] args) {
        ReservationDAO userdao = new ReservationDAO();
        List<Reservation> ulist = userdao.getReservation(5);
        System.out.println(ulist.get(0).getCustomer_id());
        System.out.println(ulist.get(0).getCheckup_time());
//        System.out.println(ulist.get(0).getList_service().get(0));
        Timestamp reservationDate = Timestamp.valueOf("2021-07-29 00:00:00");
        Timestamp updateDate = Timestamp.valueOf("2021-07-27 00:00:00");
        List <ReservationService> servicelist = new ArrayList<ReservationService>();
        Reservation newReser = new Reservation(115, 131, reservationDate, "Pending", 4, updateDate, servicelist, "njas");
//        try {
//            System.out.println(userdao.addReservation(newReser));
//        } catch (SQLException ex) {
//            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
        System.out.println(userdao.getPendingReservation(131));
//        System.out.println(userdao.getPendingReservation(1));
//        for (Reservation u : ulist) {
//            System.out.println(u.getId());
//            //System.out.println(u.getId());
//        }
    }

    public void editCheckupTime(int rid, Date sqlDate) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
