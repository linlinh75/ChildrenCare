package model;
import java.sql.Date;

public class Slider {
    private int id;
    private String title;
    private String imageLink;
    private String backlink;
    private String status; 
    private String notes;
    private Date update_date;
    private int author_id;
    public Slider() {
    }

    public Slider(int id, String title, String imageLink, String backlink, String status, String notes, Date update_date, int author_id) {
        this.id = id;
        this.title = title;
        this.imageLink = imageLink;
        this.backlink = backlink;
        this.status = status;
        this.notes = notes;
        this.update_date = update_date;
        this.author_id = author_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImageLink() {
        return imageLink;
    }

    public void setImageLink(String imageLink) {
        this.imageLink = imageLink;
    }

    public String getBacklink() {
        return backlink;
    }

    public void setBacklink(String backlink) {
        this.backlink = backlink;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Date getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(Date update_date) {
        this.update_date = update_date;
    }

    public int getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(int author_id) {
        this.author_id = author_id;
    }

    
    
}
