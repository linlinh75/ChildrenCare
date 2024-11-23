/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.util.List;

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
    List<ReservationService> list_service;
    String customer_name;
    String pay_option;
    int paid_cost;

    public Reservation(int id, int customer_id, Timestamp reservation_date, String status, int staff_id, Timestamp checkup_time, List<ReservationService> list_service, String customer_name, String pay_option, int paid_cost) {
        this.id = id;
        this.customer_id = customer_id;
        this.reservation_date = reservation_date;
        this.status = status;
        this.staff_id = staff_id;
        this.checkup_time = checkup_time;
        this.list_service = list_service;
        this.customer_name = customer_name;
        this.pay_option = pay_option;
        this.paid_cost= paid_cost;
    }

    public String getPay_option() {
        return pay_option;
    }

    public void setPay_option(String pay_option) {
        this.pay_option = pay_option;
    }
    
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

    public Reservation(int id, int customer_id, Timestamp reservation_date, String status, int staff_id, Timestamp checkup_time, List<ReservationService> list_service, String customer_name) {
        this.id = id;
        this.customer_id = customer_id;
        this.reservation_date = reservation_date;
        this.status = status;
        this.staff_id = staff_id;
        this.checkup_time = checkup_time;
        this.list_service = list_service;
        this.customer_name = customer_name;
    }
    public Reservation(int id, int customer_id, Timestamp reservation_date, String status, int staff_id, Timestamp checkup_time, List<ReservationService> list_service, String customer_name, String pay_option) {
        this.id = id;
        this.customer_id = customer_id;
        this.reservation_date = reservation_date;
        this.status = status;
        this.staff_id = staff_id;
        this.checkup_time = checkup_time;
        this.list_service = list_service;
        this.customer_name = customer_name;
        this.pay_option = pay_option;
    }
    public List<ReservationService> getList_service() {
        return list_service;
    }

    public void setList_service(List<ReservationService> list_service) {
        this.list_service = list_service;
    }

    public String getCustomer_name() {
        return customer_name;
    }

    public void setCustomer_name(String customer_name) {
        this.customer_name = customer_name;
    }

    public int getPaid_cost() {
        return paid_cost;
    }

    public void setPaid_cost(int paid_cost) {
        this.paid_cost = paid_cost;
    }

    public Reservation() {
    }

}
