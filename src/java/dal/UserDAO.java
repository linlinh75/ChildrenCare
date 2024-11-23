package dal;

import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import static java.time.LocalDateTime.now;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import model.WorkSchedule;

/**
 * Data Access Object (DAO) for User entity.
 */
public class UserDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    public boolean updateProfile(User user) {
        String sql = "UPDATE user "
                + "SET full_name = ?, gender = ?, mobile = ?, address = ?, image_link = ? "
                + "WHERE id = ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, user.getFullName());
            stmt.setBoolean(2, user.isGender());
            stmt.setString(3, user.getMobile());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getImageLink());
            stmt.setInt(6, user.getId());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Retrieves the user's profile information by their ID.
     *
     * @param userId The ID of the user.
     * @return The User object containing the user's profile information.
     * @throws SQLException If there is an error executing the SQL query.
     */
    public User getProfileById(int userId) throws SQLException {
        String sql = "SELECT * FROM user WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("full_name"),
                            rs.getBoolean("gender"),
                            rs.getString("mobile"),
                            rs.getString("address"),
                            rs.getString("image_link"),
                            rs.getInt("role_id"),
                            rs.getString("status")
                    );
                }
            }
        }

        return null;
    }

    public User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM user WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("full_name"),
                            rs.getBoolean("gender"),
                            rs.getString("mobile"),
                            rs.getString("address"),
                            rs.getString("image_link"),
                            rs.getInt("role_id"),
                            rs.getString("status")
                    );
                }
            }
        }
        return null;
    }

    public User getUserByPhoneNumber(String phone) throws SQLException {
        String sql = "SELECT * FROM user WHERE mobile = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, phone);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("full_name"),
                            rs.getBoolean("gender"),
                            rs.getString("mobile"),
                            rs.getString("address"),
                            rs.getString("image_link"),
                            rs.getInt("role_id"),
                            rs.getString("status")
                    );
                }
            }
        }
        return null;
    }

    public void updateToken(String email, String token) {
        String s = "Update password_reset_tokens set token";
    }

    public String addToken(String email) {
        int leftLimit = 97; // letter 'a'
        int rightLimit = 122; // letter 'z'
        int targetStringLength = 20;
        Random random = new Random();
        StringBuilder buffer = new StringBuilder(targetStringLength);
        for (int i = 0; i < targetStringLength; i++) {
            int randomLimitedInt = leftLimit + (int) (random.nextFloat() * (rightLimit - leftLimit + 1));
            buffer.append((char) randomLimitedInt);
        }
        String token = buffer.toString();
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime expiresAt = now.plusMinutes(10); // Token valid for 10 minutes

        try {
            stm = connection.prepareStatement("INSERT INTO password_reset_tokens (token, email, created_at, expires_at, user_id) VALUES (?, ?, ?, ?,?)");
            stm.setString(1, token);
            stm.setString(2, email);
            stm.setTimestamp(3, Timestamp.valueOf(now));
            stm.setTimestamp(4, Timestamp.valueOf(expiresAt));
            stm.setInt(5, getUserByEmail(email).getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return token;
    }

    public boolean isTokenValid(String token) {
        try {
            stm = connection.prepareStatement("SELECT expires_at FROM password_reset_tokens WHERE token = ?");
            stm.setString(1, token);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Timestamp expiresAt = rs.getTimestamp("expires_at");
                return expiresAt.after(Timestamp.valueOf(LocalDateTime.now()));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void cleanupExpiredTokens() {
        try {
            stm = connection.prepareStatement("DELETE FROM password_reset_tokens WHERE expires_at < ?");
            stm.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int changePassword(String email, String password) {
        String s = "update user set password = ? where email=?";
        int count = 0;
        try {
            stm = connection.prepareStatement(s);
            stm.setString(1, password);
            stm.setString(2, email);
            count = stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public List<User> getAllUser() {
        List<User> ulist = new ArrayList<>();
        String sql = "SELECT * FROM user";
        try {
            System.out.println("Executing getAllUser query");
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getBoolean("gender"),
                        rs.getString("mobile"),
                        rs.getString("address"),
                        rs.getString("image_link"),
                        rs.getInt("role_id"),
                        rs.getString("status")
                );
                ulist.add(u);
            }
            System.out.println("Found " + ulist.size() + " users");
        } catch (SQLException ex) {
            System.out.println("Error in getAllUser: " + ex.getMessage());
            ex.printStackTrace();
        }
        return ulist;
    }

    public int addUser(User user) throws SQLException {
        // Kiểm tra email và số điện thoại đã tồn tại chưa
        if (isEmailExistsExceptUser(user.getEmail(), 0)) {
            return -1; // Email đã tồn tại
        }
        if (isMobileExistsExceptUser(user.getMobile(), 0)) {
            return -2; // Số điện thoại đã tồn tại
        }

        String sql = "INSERT INTO user (email, password, full_name, gender, mobile, address, image_link, role_id, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getFullName());
            stmt.setBoolean(4, user.isGender());
            stmt.setString(5, user.getMobile());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getImageLink());
            stmt.setInt(8, user.getRoleId());
            stmt.setString(9, user.getStatus());

            return stmt.executeUpdate(); // Trả về số dòng được thêm
        }
    }

    public String getRoleString(int role) {
        String sql = "SELECT role_name FROM role\n"
                + "where id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setObject(1, role);
            ResultSet resultSet = stmt.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateProfileImage(int userId, String imagePath) {
        String sql = "UPDATE user SET image_link = ? WHERE id = ?";
        try (Connection conn = new DBContext().connection; PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, imagePath);
            stmt.setInt(2, userId);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<WorkSchedule> listDoctorBusy(Timestamp registeredTime) {
        List<WorkSchedule> busyDoctors = new ArrayList<>();
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String sql = "Select * from work_schedule where start_at=?";
            stm = connection.prepareStatement(sql);
            stm.setTimestamp(1, registeredTime);
            rs = stm.executeQuery();
            while (rs.next()) {
                WorkSchedule w = new WorkSchedule(rs.getInt("reservation_id"), rs.getInt("doctor_id"), LocalDateTime.parse(rs.getString("start_at"), formatter), LocalDateTime.parse(rs.getString("end_at"), formatter));
                busyDoctors.add(w);
            }
            return busyDoctors;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }

    }

    public static void main(String[] args) {
        UserDAO userdao = new UserDAO();
        String dateString = "2024-11-27 09:00:00.0";
        Timestamp timestamp = Timestamp.valueOf(dateString);
        System.out.println(timestamp);
        List<WorkSchedule> listw = userdao.listDoctorBusy(timestamp);
        for (WorkSchedule w : listw) {
            System.out.println(w.getDoctorId());
        }
        List<User> allDoctors = userdao.getUserByRoleId(3);
        System.out.println("Number of doctor:" + allDoctors.size());
        for (User u : allDoctors) {
            System.out.println(u.getId());
        }
//        List<User> ulist = userdao.getAllUser();
//        for (User u : ulist) {
//            System.out.println(u.getId());
//            //System.out.println(u.getId());
//        }
//        User newUser = new User();
//            newUser.setEmail("thanhthanh16102004@gmail.com");
//            newUser.setPassword("Thanhcute16");
//            newUser.setFullName("Thanhne");
//            newUser.setGender(false);
//            newUser.setMobile("0902004117");
//            newUser.setAddress("123 Test Street");
//            newUser.setImageLink("assets/images/default.png");
//            newUser.setRoleId(4);
//            newUser.setStatus("Activate");
//
//            try {
//            int result = userdao.addUser(newUser);
//            if (result > 0) {
//            System.out.println("User added successfully!");
//            } else {
//            System.out.println("Failed to add user.");
//            }
//            } catch (SQLException ex) {
//            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        try {
//            System.out.println(userdao.getUserByEmail("thanhthanh16102004@gmail.com"));
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        //        LocalDateTime dateTime = LocalDateTime.parse(request.getParameter("registeredTime"), formatter);
        LocalDateTime dateTime = LocalDateTime.parse("2024-10-20 08:19:10", formatter);
        Timestamp registeredTime = Timestamp.valueOf(dateTime);

    }

    public List<User> searchUsersByName(String name) {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE full_name LIKE ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, "%" + name + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getBoolean("gender"),
                        rs.getString("mobile"),
                        rs.getString("address"),
                        rs.getString("image_link"),
                        rs.getInt("role_id"),
                        rs.getString("status")
                );
                userList.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userList;
    }

    public boolean deleteUser(int userId) {
        String sql = "delete from swp.user where id= ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public List<User> getUsersWithPagination(int offset, int recordsPerPage) {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM user LIMIT ? OFFSET ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, recordsPerPage);
            stmt.setInt(2, offset);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getBoolean("gender"),
                        rs.getString("mobile"),
                        rs.getString("address"),
                        rs.getString("image_link"),
                        rs.getInt("role_id"),
                        rs.getString("status")
                );
                userList.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userList;
    }

    public List<User> getAllUsersWithPagination(int page, int recordsPerPage) {
        List<User> userList = new ArrayList<>();
        int start = (page - 1) * recordsPerPage;

        String sql = "SELECT u.*, r.role_name FROM user u "
                + "LEFT JOIN role r ON u.role_id = r.id "
                + "ORDER BY u.id "
                + "LIMIT ? OFFSET ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, recordsPerPage);
            stmt.setInt(2, start);

            System.out.println("Executing query with recordsPerPage=" + recordsPerPage + ", start=" + start); // Debug log

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setGender(rs.getBoolean("gender"));
                user.setMobile(rs.getString("mobile"));
                user.setAddress(rs.getString("address"));
                user.setImageLink(rs.getString("image_link"));
                user.setRoleId(rs.getInt("role_id"));
                user.setStatus(rs.getString("status"));
                userList.add(user);
            }

            System.out.println("Found " + userList.size() + " users"); // Debug log

        } catch (SQLException ex) {
            System.out.println("Error in getAllUsersWithPagination: " + ex.getMessage());
            ex.printStackTrace();
        }
        return userList;
    }

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM user";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<User> searchUsers(String keyword) {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT u.*, r.role_name FROM user u "
                + "JOIN role r ON u.role_id = r.id "
                + "WHERE u.full_name LIKE ? OR u.email LIKE ? OR u.mobile LIKE ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setGender(rs.getBoolean("gender"));
                user.setMobile(rs.getString("mobile"));
                user.setAddress(rs.getString("address"));
                user.setImageLink(rs.getString("image_link"));
                user.setRoleId(rs.getInt("role_id"));
                user.setStatus(rs.getString("status"));
                userList.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userList;
    }

    public boolean updateUserStatus(int userId, String status) {
        String sql = "UPDATE user SET status = ? WHERE id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public List<User> getFilteredUsers(String roleFilter, String statusFilter, int page, int recordsPerPage) {
        List<User> userList = new ArrayList<>();
        int start = (page - 1) * recordsPerPage;

        StringBuilder sql = new StringBuilder("SELECT u.*, r.role_name FROM user u "
                + "JOIN role r ON u.role_id = r.id WHERE 1=1");

        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql.append(" AND u.role_id = ?");
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND u.status = ?");
        }

        sql.append(" ORDER BY u.id LIMIT ? OFFSET ?");

        try {
            PreparedStatement stmt = connection.prepareStatement(sql.toString());
            int paramIndex = 1;

            if (roleFilter != null && !roleFilter.isEmpty()) {
                stmt.setInt(paramIndex++, Integer.parseInt(roleFilter));
            }
            if (statusFilter != null && !statusFilter.isEmpty()) {
                stmt.setString(paramIndex++, statusFilter);
            }

            stmt.setInt(paramIndex++, recordsPerPage);
            stmt.setInt(paramIndex, start);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setGender(rs.getBoolean("gender"));
                user.setMobile(rs.getString("mobile"));
                user.setAddress(rs.getString("address"));
                user.setImageLink(rs.getString("image_link"));
                user.setRoleId(rs.getInt("role_id"));
                user.setStatus(rs.getString("status"));
                userList.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userList;
    }

    public int getTotalFilteredUsers(String roleFilter, String statusFilter) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM user WHERE 1=1");

        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql.append(" AND role_id = ?");
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND status = ?");
        }

        try {
            PreparedStatement stmt = connection.prepareStatement(sql.toString());
            int paramIndex = 1;

            if (roleFilter != null && !roleFilter.isEmpty()) {
                stmt.setInt(paramIndex++, Integer.parseInt(roleFilter));
            }
            if (statusFilter != null && !statusFilter.isEmpty()) {
                stmt.setString(paramIndex, statusFilter);
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    // Thêm phương thức kiểm tra email tồn tại (trừ user hiện tại)
    private boolean isEmailExistsExceptUser(String email, int userId) {
        String sql = "SELECT COUNT(*) FROM user WHERE email = ? AND id != ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // Thêm phương thức kiểm tra số điện thoại tồn tại (trừ user hiện tại)
    private boolean isMobileExistsExceptUser(String mobile, int userId) {
        String sql = "SELECT COUNT(*) FROM user WHERE mobile = ? AND id != ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, mobile);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // Sửa lại phương thức updateUser
    public int updateUser(User user) {
        // Kiểm tra email và số điện thoại đã tồn tại với user khác chưa
        if (isEmailExistsExceptUser(user.getEmail(), user.getId())) {
            return -1; // Email đã tồn tại
        }
        if (isMobileExistsExceptUser(user.getMobile(), user.getId())) {
            return -2; // Số điện thoại đã tồn tại
        }

        String sql = "UPDATE user SET email=?, full_name=?, gender=?, mobile=?, "
                + "address=?, role_id=?, status=? WHERE id=?";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getFullName());
            stmt.setBoolean(3, user.isGender());
            stmt.setString(4, user.getMobile());
            stmt.setString(5, user.getAddress());
            stmt.setInt(6, user.getRoleId());
            stmt.setString(7, user.getStatus());
            stmt.setInt(8, user.getId());

            return stmt.executeUpdate(); // Trả về số dòng được cập nhật
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
            return -3; // Lỗi SQL
        }
    }

    public List<User> getUserByRoleId(int roleId) {
        String sql = "SELECT * FROM user WHERE role_id = ?";
        List<User> usersByRole = new ArrayList<>();
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, roleId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                usersByRole.add(new User(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getBoolean("gender"),
                        rs.getString("mobile"),
                        rs.getString("address"),
                        rs.getString("image_link"),
                        rs.getInt("role_id"),
                        rs.getString("status"),
                        LocalDateTime.parse(rs.getString("created_date").trim(), formatter).toLocalDate()
                ));
            }
            return usersByRole;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public User getUserById(int id) {
        String sql = "SELECT * FROM user WHERE id = ?";
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getBoolean("gender"),
                        rs.getString("mobile"),
                        rs.getString("address"),
                        rs.getString("image_link"),
                        rs.getInt("role_id"),
                        rs.getString("status"),
                        LocalDateTime.parse(rs.getString("created_date").trim(), formatter).toLocalDate() // Ensure no extra spaces
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (DateTimeParseException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, "Date parsing error: " + ex.getMessage(), ex);
        }
        return null;
    }

    public List<User> getFilteredAndSortedUsers(String genderFilter, String roleFilter, String statusFilter,
            String searchKeyword, String sortBy, String sortOrder,
            int page, int recordsPerPage) {
        List<User> userList = new ArrayList<>();
        int start = (page - 1) * recordsPerPage;

        StringBuilder sql = new StringBuilder("SELECT * FROM user WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Add filters
        if (genderFilter != null && !genderFilter.isEmpty()) {
            sql.append(" AND gender = ?");
            params.add(Boolean.parseBoolean(genderFilter));
        }
        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql.append(" AND role_id = ?");
            params.add(Integer.parseInt(roleFilter));
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(statusFilter);
        }

        // Add search
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append(" AND (full_name LIKE ? OR email LIKE ? OR mobile LIKE ?)");
            String searchPattern = "%" + searchKeyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        // Add sorting
        if (sortBy != null && !sortBy.isEmpty()) {
            sql.append(" ORDER BY ").append(sortBy);
            if ("desc".equalsIgnoreCase(sortOrder)) {
                sql.append(" DESC");
            } else {
                sql.append(" ASC");
            }
        } else {
            sql.append(" ORDER BY id ASC");
        }

        // Add pagination
        sql.append(" LIMIT ? OFFSET ?");
        params.add(recordsPerPage);
        params.add(start);

        try {
            PreparedStatement stmt = connection.prepareStatement(sql.toString());
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User user = new User(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getBoolean("gender"),
                        rs.getString("mobile"),
                        rs.getString("address"),
                        rs.getString("image_link"),
                        rs.getInt("role_id"),
                        rs.getString("status")
                );
                userList.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userList;
    }

    public int getTotalFilteredUsers(String genderFilter, String roleFilter, String statusFilter, String searchKeyword) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM user WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (genderFilter != null && !genderFilter.isEmpty()) {
            sql.append(" AND gender = ?");
            params.add(Boolean.parseBoolean(genderFilter));
        }
        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql.append(" AND role_id = ?");
            params.add(Integer.parseInt(roleFilter));
        }
        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(statusFilter);
        }

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            sql.append(" AND (full_name LIKE ? OR email LIKE ? OR mobile LIKE ?)");
            String searchPattern = "%" + searchKeyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        try {
            PreparedStatement stmt = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

}
