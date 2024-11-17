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
public class Feedback {

    private int id;
    private int user_id;
    private int reservation_id;
    private int service_id;
    private int rated_star;
    private String content;
    private String image_link;
    private String status;
    private Timestamp feedback_time;
    private boolean isPublic;

    public Feedback() {
    }

    public Feedback(int id, int user_id, int reservation_id, int service_id, int rated_star, String content, String image_link, String status, Timestamp feedback_time, boolean isPublic) {
        this.id = id;
        this.user_id = user_id;
        this.reservation_id = reservation_id;
        this.service_id = service_id;
        this.rated_star = rated_star;
        this.content = content;
        this.image_link = image_link;
        this.status = status;
        this.feedback_time = feedback_time;
        this.isPublic = isPublic;
    }

    public boolean isIsPublic() {
        return isPublic;
    }

    public void setIsPublic(boolean isPublic) {
        this.isPublic = isPublic;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
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

    public int getRated_star() {
        return rated_star;
    }

    public void setRated_star(int rated_star) {
        this.rated_star = rated_star;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage_link() {
        return image_link;
    }

    public void setImage_link(String image_link) {
        this.image_link = image_link;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getFeedback_time() {
        return feedback_time;
    }

    public void setFeedback_time(Timestamp feedback_time) {
        this.feedback_time = feedback_time;
    }

}
