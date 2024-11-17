
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


import java.sql.Date;
/**
 *
 * @author ADMIN
 */
public class Post {
    private int id;
    private String content;
    private String description;
    private Date updatedDate;
    private boolean featured;
    private String thumbnailLink;
    private int authorId;
    private int categoryId;
    private String statusId;
    private String title;

    public Post() {
    }

    public Post(int id, String content, String description, Date updatedDate, boolean featured, String thumbnailLink, int authorId, int categoryId, String statusId, String title) {
        this.id = id;
        this.content = content;
        this.description = description;
        this.updatedDate = updatedDate;
        this.featured = featured;
        this.thumbnailLink = thumbnailLink;
        this.authorId = authorId;
        this.categoryId = categoryId;
        this.statusId = statusId;
        this.title = title;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    public boolean isFeatured() {
        return featured;
    }

    public void setFeatured(boolean featured) {
        this.featured = featured;
    }

    public String getThumbnailLink() {
        return thumbnailLink;
    }

    public void setThumbnailLink(String thumbnailLink) {
        this.thumbnailLink = thumbnailLink;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getStatusId() {
        return statusId;
    }

    public void setStatusId(String statusId) {
        this.statusId = statusId;
    }
    
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    
}
