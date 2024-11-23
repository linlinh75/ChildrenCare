/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Reservation;
import model.ReservationService;
import model.User;

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
    public void assignWorkSchedule(int rid, int staff_id, Timestamp start_at) {
        try {
            String sql = "insert into work_schedule values(?,?,?,?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            Timestamp end_at = new Timestamp(start_at.getTime() + 2 * 60 * 60 * 1000);
            stm.setInt(1, rid);
            stm.setInt(2, staff_id);
            stm.setTimestamp(3, start_at);
            stm.setTimestamp(4, end_at);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public int getTotal(int rid) {
        try {
            String sql = "SELECT SUM(unit_price) as total\n"
                    + "FROM reservation_service\n"
                    + "WHERE reservation_id=?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, rid);
            rs=stm.executeQuery();
            int total =0;
            while(rs.next()){
                total = rs.getInt("total");
            }
            return total;
            
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    public User getStaffByReservationID(int reservation_id){
         try {
            String sql = "select * from user u join reservation r  on u.id=r.staff_id where r.id=?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, reservation_id);
            rs=stm.executeQuery();
            while(rs.next()){
                User u = new User();
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setMobile(rs.getString("mobile"));
                return u;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }return null;
    }
    public User getUserByReservationID(int reservation_id){
         try {
            String sql = "select * from user u join reservation r  on u.id=r.customer_id where r.id=?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, reservation_id);
            rs=stm.executeQuery();
            while(rs.next()){
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setMobile(rs.getString("mobile"));
                u.setGender(rs.getBoolean("gender"));
                u.setAddress(rs.getString("address"));
                u.setRoleId(rs.getInt("role_id"));
                u.setStatus(rs.getString("status"));
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                u.setCreated_date(LocalDate.parse(rs.getString("created_date"), formatter));
                u.setImageLink(rs.getString("image_link"));
                return u;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }return null;
    }
   public  void statusReservation(int reservation_id, String status) {
        try {
            String sql = "update reservation set reservation.status = ?\n"
                    + "where reservation.id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "Submitted");
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, reservation_id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int insertReservation(Reservation reservation) throws SQLException {
        connection.setAutoCommit(false);
        int reservationId = 0;

        try {
            // Insert into reservation table
            String sql = "INSERT INTO reservation (customer_id, reservation_date, status, checkup_time) "
                    + "VALUES (?, ?, ?, ?)";

            PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, reservation.getCustomer_id());
            stmt.setTimestamp(2, reservation.getReservation_date());
            stmt.setString(3, reservation.getStatus());
            stmt.setTimestamp(4, reservation.getCheckup_time());

            stmt.executeUpdate();

            // Get the generated reservation ID
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                reservationId = rs.getInt(1);
            }

            // Insert reservation services
            sql = "INSERT INTO reservation_service (reservation_id, service_id, quantity, unit_price) "
                    + "VALUES (?, ?, ?, ?)";
            stmt = connection.prepareStatement(sql);

            for (ReservationService service : reservation.getList_service()) {
                stmt.setInt(1, reservationId);
                stmt.setInt(2, service.getService_id());
                stmt.setInt(3, 1); // Quantity is always 1
                stmt.setFloat(4, service.getUnit_price());
                stmt.executeUpdate();
            }

            // Commit the transaction
            connection.commit();
            return reservationId;

        } catch (SQLException e) {
            // Rollback in case of error
            connection.rollback();
            throw e;
        } finally {
            // Reset auto-commit to true
            connection.setAutoCommit(true);
        }
    }

    public boolean updateReservationStatus(int reservationId, String newStatus) {
        String sql = "UPDATE reservation SET status = ? WHERE id = ?";
        try (Connection conn = new DBContext().connection;
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, reservationId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public int getReservationCount(String status, LocalDate startDate, LocalDate endDate) {
        String query = "SELECT COUNT(*) FROM reservation WHERE status = ? AND reservation_date BETWEEN ? AND ?";
        try  {
            stm  = connection.prepareStatement(query);
            stm.setString(1, status);
            stm.setString(2,  startDate.toString());
            stm.setString(3,  endDate.toString());
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public int getReservationCount(String status, LocalDate date) {
        if(!status.isEmpty()){
            String query = "SELECT COUNT(*) FROM reservation WHERE status = ? AND reservation_date BETWEEN ? AND ?  ";
            try  {
                stm  = connection.prepareStatement(query);

                stm.setString(1, status);
                stm.setString(2,  date.toString()+" 00:00:00");
                stm.setString(3,  date.toString()+" 23:59:59");
                ResultSet rs = stm.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return 0;
        }else{
            String query = "SELECT COUNT(*) FROM reservation WHERE reservation_date BETWEEN ? AND ?  ";
            try  {
                stm  = connection.prepareStatement(query);
                stm.setString(1,  date.toString()+" 00:00:00");
                stm.setString(2,  date.toString()+" 23:59:59");
                ResultSet rs = stm.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return 0;
        }
            
        }
    public static void main(String[] args) {
        ReservationDAO userdao = new ReservationDAO();
        List<Reservation> ulist = userdao.getAllReservation();
        userdao.getUserByReservationID(1).getFullName();
//        System.out.println(ulist.get(0).getCustomer_id());
//        System.out.println(ulist.get(0).getCheckup_time());
//        System.out.println(ulist.get(0).getList_service().get(0));

        for (Reservation u : ulist) {
            System.out.println(u.getId());
            //System.out.println(u.getId());
        }
//            System.out.println(userdao.getTotal(1));
//            String dateString = "2024-10-24 08:00:00";
//
//        try {
//            // Chuyển đổi chuỗi thành đối tượng Timestamp
//            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            java.util.Date parsedDate = dateFormat.parse(dateString);
//            Timestamp timestamp = new Timestamp(parsedDate.getTime());
//
//            // Gọi phương thức assignWorkSchedule với tham số thứ 2 là Timestamp
//            userdao.assignWorkSchedule(28,3, timestamp);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }
}
