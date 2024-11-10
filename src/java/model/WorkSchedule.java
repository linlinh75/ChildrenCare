/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

<<<<<<< HEAD
import java.time.LocalDate;

/**
 *
 * @author Admin
 */
public class WorkSchedule {
    private int reservationId;
    private int doctorId;
    private LocalDate startAt;
    private LocalDate endAt;

    public WorkSchedule(int reservationId, int doctorId, LocalDate startAt, LocalDate endAt) {
        this.reservationId = reservationId;
        this.doctorId = doctorId;
        this.startAt = startAt;
        this.endAt = endAt;
    }

    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public int getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }

    public LocalDate getStartAt() {
        return startAt;
    }

    public void setStartAt(LocalDate startAt) {
        this.startAt = startAt;
    }

    public LocalDate getEndAt() {
        return endAt;
    }

    public void setEndAt(LocalDate endAt) {
        this.endAt = endAt;
=======
import java.sql.Timestamp;

/**
 *
 * @author admin
 */
public class WorkSchedule {
    private int reservation_id;
    private int doctor_id ;
    Timestamp start_at;
    Timestamp end_at;
    public WorkSchedule(){
        
    }
    public WorkSchedule(int reservation_id, int doctor_id, Timestamp start_at, Timestamp end_at) {
        this.reservation_id = reservation_id;
        this.doctor_id = doctor_id;
        this.start_at = start_at;
        this.end_at = end_at;
    }

    public int getReservation_id() {
        return reservation_id;
    }

    public void setReservation_id(int reservation_id) {
        this.reservation_id = reservation_id;
    }

    public int getDoctor_id() {
        return doctor_id;
    }

    public void setDoctor_id(int doctor_id) {
        this.doctor_id = doctor_id;
    }

    public Timestamp getStart_at() {
        return start_at;
    }

    public void setStart_at(Timestamp start_at) {
        this.start_at = start_at;
    }

    public Timestamp getEnd_at() {
        return end_at;
    }

    public void setEnd_at(Timestamp end_at) {
        this.end_at = end_at;
>>>>>>> d8692e10150601cca1e17380dcd62da5cdac0335
    }
    
}
