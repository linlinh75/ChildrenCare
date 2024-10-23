package model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ReservationCart {
    private Reservation reservation;
    
    public ReservationCart() {
        this.reservation = new Reservation();
        this.reservation.setList_service(new ArrayList<>());
        this.reservation.setStatus("PENDING"); // Initial status
        this.reservation.setReservation_date(new Timestamp(System.currentTimeMillis()));
    }
    
    public void addService(Service service) {
        List<ReservationService> services = reservation.getList_service();
        
        // Check if service already exists in cart
        for (ReservationService rs : services) {
            if (rs.getService_id() == service.getId()) {
                // Service already exists in cart, don't add again
                return;
            }
        }
        
        // If service doesn't exist, add new
        ReservationService newService = new ReservationService(
            0, // reservation_id will be set when saved to database
            service.getId(),
            1, // Always set quantity to 1
            service.getSalePrice(),
            service.getFullname()
        );
        
        services.add(newService);
    }
    
    public void removeService(int serviceId) {
        List<ReservationService> services = reservation.getList_service();
        services.removeIf(rs -> rs.getService_id() == serviceId);
    }
    
    public float getTotalPrice() {
        float total = 0;
        for (ReservationService rs : reservation.getList_service()) {
            total += rs.getUnit_price(); // No need to multiply by quantity since it's always 1
        }
        return total;
    }
    
    public void setCustomerInfo(int customerId, String customerName) {
        reservation.setCustomer_id(customerId);
        reservation.setCustomer_name(customerName);
    }
    
    public void setCheckupTime(Timestamp checkupTime) {
        reservation.setCheckup_time(checkupTime);
    }
    
    public Reservation getReservation() {
        return reservation;
    }
    
    public void clear() {
        reservation.getList_service().clear();
    }
    
    // Additional helper methods
    
    public boolean hasService(int serviceId) {
        return reservation.getList_service().stream()
                .anyMatch(rs -> rs.getService_id() == serviceId);
    }
    
    public int getServiceCount() {
        return reservation.getList_service().size();
    }
    
    public boolean isEmpty() {
        return reservation.getList_service().isEmpty();
    }
}