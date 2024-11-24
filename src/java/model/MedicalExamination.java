/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author Admin
 */
public class MedicalExamination {
   private int id;
    private ReservationService reservationService;
    private User user;
    private String prescription;
    private List<Medicine> medicines;
    private int author_id;
    private Timestamp date;

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }
    
    public int getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(int author_id) {
        this.author_id = author_id;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ReservationService getReservationService() {
        return reservationService;
    }

    public void setReservationService(ReservationService reservationService) {
        this.reservationService = reservationService;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    

    public String getPrescription() {
        return prescription;
    }

    public void setPrescription(String prescription) {
        this.prescription = prescription;
    }

    public List<Medicine> getMedicines() {
        return medicines;
    }

    public void setMedicines(List<Medicine> medicines) {
        this.medicines = medicines;
    }
    
    
}

