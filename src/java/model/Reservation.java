/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author ACER
 */
public class Reservation {

    int id, customer_id;
    Timestamp reservation_date;
    String status;
    int staff_id;
    Timestamp checkup_time;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public Timestamp getReservation_date() {
        return reservation_date;
    }

    public void setReservation_date(Timestamp reservation_date) {
        this.reservation_date = reservation_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getStaff_id() {
        return staff_id;
    }

    public void setStaff_id(int staff_id) {
        this.staff_id = staff_id;
    }

    public Timestamp getCheckup_time() {
        return checkup_time;
    }

    public void setCheckup_time(Timestamp checkup_time) {
        this.checkup_time = checkup_time;
    }

    public Reservation(int id, int customer_id, Timestamp reservation_date, String status, int staff_id, Timestamp checkup_time) {
        this.id = id;
        this.customer_id = customer_id;
        this.reservation_date = reservation_date;
        this.status = status;
        this.staff_id = staff_id;
        this.checkup_time = checkup_time;
    }

    public Reservation() {
    }

}
