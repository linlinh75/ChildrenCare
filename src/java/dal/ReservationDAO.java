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
import model.Service;
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
                            rs.getString("full_name"),
                            rs.getString("payment_method"),
                            rs.getInt("paid_cost")
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
                        rs.getString("full_name"),
                        rs.getString("payment_method")
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
            Timestamp end_at = new Timestamp(start_at.getTime() + 60 * 60 * 1000);
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
            rs = stm.executeQuery();
            int total = 0;
            while (rs.next()) {
                total = rs.getInt("total");
            }
            return total;

        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public User getStaffByReservationID(int reservation_id) {
        try {
            String sql = "select * from user u join reservation r  on u.id=r.staff_id where r.id=?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, reservation_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setMobile(rs.getString("mobile"));
                return u;
            }

        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public User getUserByReservationID(int reservation_id) {
        try {
            String sql = "select * from user u join reservation r  on u.id=r.customer_id where r.id=?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, reservation_id);
            rs = stm.executeQuery();
            while (rs.next()) {
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
        }
        return null;
    }

    public void statusReservation(int reservation_id, String status, int user_id) {
        try {
            String sqlUpdateStatus = "UPDATE reservation SET reservation.status = ? WHERE reservation.id = ?";
            PreparedStatement stm = connection.prepareStatement(sqlUpdateStatus);
            stm.setString(1, status);
            stm.setInt(2, reservation_id);
            stm.executeUpdate();

            if ("Completion".equalsIgnoreCase(status)) {
                Reservation reservation = getReservationById(reservation_id);
                List<ReservationService> services = reservation.getList_service();

                String sqlInsertFeedback = "INSERT INTO swp.feedback (user_id, rated_star, content, service_id, image_link, status, reservation_id) "
                        + "VALUES (?, 0, '', ?, '', 'Processing', ?)";
                PreparedStatement insertStm = connection.prepareStatement(sqlInsertFeedback);

                for (ReservationService service : services) {
                    insertStm.setInt(1, user_id);
                    insertStm.setInt(2, service.getService_id());
                    insertStm.setInt(3, reservation_id);
                    insertStm.addBatch();
                }

                // Thực thi batch
                insertStm.executeBatch();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int insertReservation(Reservation reservation) throws SQLException {
        connection.setAutoCommit(false);
        int reservationId = 0;

        try {
            // Insert into reservation table
            String sql = "INSERT INTO reservation (customer_id, reservation_date, status, checkup_time,payment_method) "
                    + "VALUES (?, ?, ?, ?,?)";

            PreparedStatement stmt = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, reservation.getCustomer_id());
            stmt.setTimestamp(2, reservation.getReservation_date());
            stmt.setString(3, reservation.getStatus());
            stmt.setTimestamp(4, reservation.getCheckup_time());
            stmt.setString(5, reservation.getPay_option());
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
        try (Connection conn = new DBContext().connection; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, reservationId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void addService(int reservationId, Reservation reservation) throws SQLException {
        if (reservation.getList_service() == null || reservation.getList_service().isEmpty()) {
            throw new IllegalArgumentException("The service list is empty or null.");
        }

        // SQL kiểm tra xem service đã tồn tại hay chưa
        String checkSql = "SELECT COUNT(*) FROM reservation_service WHERE reservation_id = ? AND service_id = ?";

        // SQL thêm service nếu chưa tồn tại
        String insertSql = "INSERT INTO reservation_service (reservation_id, service_id, quantity, unit_price) VALUES (?, ?, ?, ?)";

        connection.setAutoCommit(false); // Bắt đầu transaction

        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql); PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {

            for (ReservationService service : reservation.getList_service()) {
                checkStmt.setInt(1, reservationId);
                checkStmt.setInt(2, service.getService_id());
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        continue;
                    }
                }

                insertStmt.setInt(1, reservationId);
                insertStmt.setInt(2, service.getService_id());
                insertStmt.setInt(3, 1);
                insertStmt.setFloat(4, service.getUnit_price());
                insertStmt.addBatch();
            }

            insertStmt.executeBatch();
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        } finally {
            connection.setAutoCommit(true);
        }
    }

    public boolean checkin(int reservationId, int totalcost) {
        String sql = "UPDATE reservation SET status = ?, paid_cost=? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "Arrived");
            ps.setInt(2, totalcost);
            ps.setInt(3, reservationId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean setPaid(int reservationId, int totalcost) {
        String sql = "UPDATE reservation SET paid_cost=? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, totalcost);
            ps.setInt(2, reservationId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean checkout(int reservationId, int totalcost, int userId) {
        String updateReservationSql = "UPDATE reservation SET status = ?, paid_cost = ? WHERE id = ?";
        String insertFeedbackSql = "INSERT INTO swp.feedback (user_id, rated_star, content, service_id, image_link, status, reservation_id) "
                + "VALUES (?, 0, '', ?, '', 'Processing', ?)";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement updateStm = conn.prepareStatement(updateReservationSql); PreparedStatement insertFeedbackStm = conn.prepareStatement(insertFeedbackSql)) {
            updateStm.setString(1, "Completed");
            updateStm.setInt(2, totalcost);
            updateStm.setInt(3, reservationId);
            int rowsAffected = updateStm.executeUpdate();

            if (rowsAffected > 0) {
                Reservation reservation = getReservationById(reservationId);
                List<ReservationService> services = reservation.getList_service();

                for (ReservationService service : services) {
                    insertFeedbackStm.setInt(1, userId);
                    insertFeedbackStm.setInt(2, service.getService_id());
                    insertFeedbackStm.setInt(3, reservationId);
                    insertFeedbackStm.addBatch();
                }
                insertFeedbackStm.executeBatch();
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public int getReservationCount(String status, LocalDate startDate, LocalDate endDate) {
        String query = "SELECT COUNT(*) FROM reservation WHERE status = ? AND reservation_date BETWEEN ? AND ?";
        try {
            stm = connection.prepareStatement(query);
            stm.setString(1, status);
            stm.setString(2, startDate.toString());
            stm.setString(3, endDate.toString());
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
        if (!status.isEmpty()) {
            String query = "SELECT COUNT(*) FROM reservation WHERE status = ? AND reservation_date BETWEEN ? AND ?  ";
            try {
                stm = connection.prepareStatement(query);

                stm.setString(1, status);
                stm.setString(2, date.toString() + " 00:00:00");
                stm.setString(3, date.toString() + " 23:59:59");
                ResultSet rs = stm.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return 0;
        } else {
            String query = "SELECT COUNT(*) FROM reservation WHERE reservation_date BETWEEN ? AND ?  ";
            try {
                stm = connection.prepareStatement(query);
                stm.setString(1, date.toString() + " 00:00:00");
                stm.setString(2, date.toString() + " 23:59:59");
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

    }
}
