package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import model.DashboardStats;

public class DashboardDAO extends DBContext {
    public DashboardStats getStats(LocalDate startDate, LocalDate endDate) {
        DashboardStats stats = new DashboardStats();
        
        try {
            // Get reservation statistics
            String reservationSql = """
                SELECT 
                    COUNT(CASE WHEN status = 'Successful' THEN 1 END) as successful,
                    COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) as cancelled,
                    COUNT(CASE WHEN status = 'Submitted' THEN 1 END) as submitted
                FROM reservation 
                WHERE reservation_date BETWEEN ? AND ?
                """;
            
            PreparedStatement pstmt = connection.prepareStatement(reservationSql);
            pstmt.setDate(1, java.sql.Date.valueOf(startDate));
            pstmt.setDate(2, java.sql.Date.valueOf(endDate));
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                stats.setSuccessfulReservations(rs.getInt("successful"));
                stats.setCancelledReservations(rs.getInt("cancelled"));
                stats.setSubmittedReservations(rs.getInt("submitted"));
            }
            
            // Get revenue statistics
            String revenueSql = """
                SELECT 
                    sc.name as category,
                    SUM(rs.quantity * rs.unit_price) as revenue
                FROM reservation_service rs
                JOIN service s ON rs.service_id = s.id
                JOIN service_category sc ON s.category_id = sc.id
                JOIN reservation r ON rs.reservation_id = r.id
                WHERE r.status = 'Successful'
                AND r.reservation_date BETWEEN ? AND ?
                GROUP BY sc.id, sc.name
                """;
            
            pstmt = connection.prepareStatement(revenueSql);
            pstmt.setDate(1, java.sql.Date.valueOf(startDate));
            pstmt.setDate(2, java.sql.Date.valueOf(endDate));
            
            rs = pstmt.executeQuery();
            Map<String, BigDecimal> revenueByCategory = new HashMap<>();
            BigDecimal totalRevenue = BigDecimal.ZERO;
            
            while (rs.next()) {
                String category = rs.getString("category");
                BigDecimal revenue = rs.getBigDecimal("revenue");
                revenueByCategory.put(category, revenue);
                totalRevenue = totalRevenue.add(revenue);
            }
            
            stats.setRevenueByCategory(revenueByCategory);
            stats.setTotalRevenue(totalRevenue);
            
            // Get customer statistics
            String customerSql = """
                SELECT 
                    COUNT(DISTINCT u.id) as new_customers,
                    COUNT(DISTINCT r.customer_id) as new_reserving
                FROM user u
                LEFT JOIN reservation r ON u.id = r.customer_id 
                    AND r.reservation_date BETWEEN ? AND ?
                WHERE u.role_id = 4 
                AND u.id IN (
                    SELECT id FROM user 
                    WHERE role_id = 4 
                    AND id NOT IN (
                        SELECT DISTINCT customer_id 
                        FROM reservation 
                        WHERE reservation_date < ?
                    )
                )
                """;
            
            pstmt = connection.prepareStatement(customerSql);
            pstmt.setDate(1, java.sql.Date.valueOf(startDate));
            pstmt.setDate(2, java.sql.Date.valueOf(endDate));
            pstmt.setDate(3, java.sql.Date.valueOf(startDate));
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
                stats.setNewCustomers(rs.getInt("new_customers"));
                stats.setNewReservingCustomers(rs.getInt("new_reserving"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return stats;
    }
} 