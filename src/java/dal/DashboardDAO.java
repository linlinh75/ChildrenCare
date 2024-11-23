
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
            // Get reservation stats for the current day
            String reservationSql = """
                SELECT 
                    COUNT(*) as total,
                    COUNT(CASE WHEN status = 'Completed' THEN 1 END) as successful,
                    COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) as cancelled,
                    COUNT(CASE WHEN status = 'Pending' THEN 1 END) as submitted
                FROM reservation 
                WHERE DATE(reservation_date) BETWEEN ? AND ?
                """;
            
            PreparedStatement pstmt = connection.prepareStatement(reservationSql);
            pstmt.setString(1, startDate.toString());
            pstmt.setString(2, endDate.toString());
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                stats.setNewReservations(rs.getInt("total"));
                stats.setSuccessfulReservations(rs.getInt("successful"));
                stats.setCancelledReservations(rs.getInt("cancelled"));
                stats.setSubmittedReservations(rs.getInt("submitted"));
            }
            
            // Get revenue stats
            String revenueSql = """
                SELECT 
                    sc.name as category,
                    SUM(rs.unit_price * rs.quantity) as revenue
                FROM reservation_service rs
                JOIN service s ON rs.service_id = s.id
                JOIN service_category sc ON s.category_id = sc.id
                JOIN reservation r ON rs.reservation_id = r.id
                WHERE r.status = 'Completed' and DATE(r.reservation_date) BETWEEN ? AND ?
                GROUP BY sc.id, sc.name
                """;
                
            pstmt = connection.prepareStatement(revenueSql);
            pstmt.setString(1, startDate.toString());
            pstmt.setString(2, endDate.toString());
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
            
            // Get customer stats for current day
            String customerSql = """
                SELECT 
                    COUNT(DISTINCT CASE WHEN DATE(created_date) = CURRENT_DATE THEN id END) as new_customers,
                    COUNT(DISTINCT CASE WHEN id IN (
                        SELECT DISTINCT customer_id 
                        FROM reservation 
                        WHERE DATE(reservation_date) BETWEEN ? AND ?
                    ) THEN id END) as new_reserving
                FROM user
                WHERE role_id = 4
                """;
                
            pstmt = connection.prepareStatement(customerSql);
            pstmt.setString(1, startDate.toString());
            pstmt.setString(2, endDate.toString());
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
