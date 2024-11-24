/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class ReservationService {
    int reservation_id;
    int service_id;
    int quantity;
    float unit_price;
    String service_name;

    public ReservationService() {
    }
    
    public ReservationService(int reservation_id){
         this.reservation_id = reservation_id;
    }

    public ReservationService(int reservation_id, int service_id, int quantity, float unit_price, String service_name) {
        this.reservation_id = reservation_id;
        this.service_id = service_id;
        this.quantity = quantity;
        this.unit_price = unit_price;
        this.service_name = service_name;
    }

    public int getReservation_id() {
        return reservation_id;
    }

    public void setReservation_id(int reservation_id) {
        this.reservation_id = reservation_id;
    }

    public int getService_id() {
        return service_id;
    }

    public void setService_id(int service_id) {
        this.service_id = service_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(float unit_price) {
        this.unit_price = unit_price;
    }

    public String getService_name() {
        return service_name;
    }

    public void setService_name(String service_name) {
        this.service_name = service_name;
    }

   
}
