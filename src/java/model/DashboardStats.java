package model;

import java.math.BigDecimal;
import java.util.Map;

public class DashboardStats {
    private int successfulReservations;
    private int cancelledReservations;
    private int submittedReservations;
    private int newReservations;

    public int getNewReservations() {
        return newReservations;
    }

    public void setNewReservations(int newReservations) {
        this.newReservations = newReservations;
    }
    private BigDecimal totalRevenue;
    private Map<String, BigDecimal> revenueByCategory;
    private int newCustomers;
    private int newReservingCustomers;

    // Getters and setters
    public int getSuccessfulReservations() {
        return successfulReservations;
    }

    public void setSuccessfulReservations(int successfulReservations) {
        this.successfulReservations = successfulReservations;
    }

    public int getCancelledReservations() {
        return cancelledReservations;
    }

    public void setCancelledReservations(int cancelledReservations) {
        this.cancelledReservations = cancelledReservations;
    }

    public int getSubmittedReservations() {
        return submittedReservations;
    }

    public void setSubmittedReservations(int submittedReservations) {
        this.submittedReservations = submittedReservations;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public Map<String, BigDecimal> getRevenueByCategory() {
        return revenueByCategory;
    }

    public void setRevenueByCategory(Map<String, BigDecimal> revenueByCategory) {
        this.revenueByCategory = revenueByCategory;
    }

    public int getNewCustomers() {
        return newCustomers;
    }

    public void setNewCustomers(int newCustomers) {
        this.newCustomers = newCustomers;
    }

    public int getNewReservingCustomers() {
        return newReservingCustomers;
    }

    public void setNewReservingCustomers(int newReservingCustomers) {
        this.newReservingCustomers = newReservingCustomers;
    }
} 