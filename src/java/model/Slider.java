package model;

public class Slider {
    private int id;
    private String title;
    private String imageLink;
    private String backlink;
    private boolean status; 
    private String notes;

    public Slider() {
    }

    public Slider(int id, String title, String imageLink, String backlink, boolean status, String notes) {
        this.id = id;
        this.title = title;
        this.imageLink = imageLink;
        this.backlink = backlink;
        this.status = status;
        this.notes = notes;
    }

    // Getters and Setters
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
