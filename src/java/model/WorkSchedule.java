/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

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
    }
    
}
