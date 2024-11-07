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
    public DashboardStats getDashboardStats(LocalDate startDate, LocalDate endDate) {
        DashboardStats stats = new DashboardStats();
        
        try {
            // Get reservation stats
            String reservationSql = """
                SELECT 
                    COUNT(CASE WHEN status = 'Successful' THEN 1 END) as successful,
                    COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) as cancelled,
                    COUNT(CASE WHEN status = 'Submitted' THEN 1 END) as submitted,
                    COUNT(*) as total
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
                stats.setNewReservations(rs.getInt("total"));
            }
            
            // Get revenue stats
            String revenueSql = """
                SELECT 
                    sc.name as category,
                    SUM(rs.price) as revenue
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
            
            // Get customer stats
            String customerSql = """
                SELECT 
                    COUNT(DISTINCT CASE WHEN u.created_date BETWEEN ? AND ? THEN u.id END) as new_customers,
                    COUNT(DISTINCT CASE WHEN r.reservation_date BETWEEN ? AND ? THEN r.customer_id END) as new_reserving
                FROM user u
                LEFT JOIN reservation r ON u.id = r.customer_id
                WHERE u.role_id = 4
                """;
                
            pstmt = connection.prepareStatement(customerSql);
            pstmt.setDate(1, java.sql.Date.valueOf(startDate));
            pstmt.setDate(2, java.sql.Date.valueOf(endDate));
            pstmt.setDate(3, java.sql.Date.valueOf(startDate));
            pstmt.setDate(4, java.sql.Date.valueOf(endDate));
            
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