/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Feedback {
    private int id;
    private int user_id;
    private int rated_star;
    private String content;
    private int service_id;
    private String image_link;
    private String status;

    public Feedback() {
    }

    public Feedback(int id, int user_id, int rated_star, String content, int service_id, String image_link,
            String status) {
        this.id = id;
        this.user_id = user_id;
        this.rated_star = rated_star;
        this.content = content;
        this.service_id = service_id;
        this.image_link = image_link;
        this.status = status;
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

    public int getService_id() {
        return service_id;
    }

    public void setService_id(int service_id) {
        this.service_id = service_id;
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

}
