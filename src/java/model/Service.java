/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 * Represents a service offered by the application.
 */
public class Service {
    private int id;
    private String fullname;
    private float originalPrice;
    private float salePrice;
    private String thumbnailLink;
    private int categoryId;
    private String description;
    private String details;
    private Date updatedDate;
    private boolean featured;
    private String status;
    private int author_id;
    public Service() {
    }

    public Service(int id, String fullname, float originalPrice, float salePrice, String thumbnailLink, int categoryId, String description, String details, Date updatedDate, boolean featured, String status, int author_id) {
        this.id = id;
        this.fullname = fullname;
        this.originalPrice = originalPrice;
        this.salePrice = salePrice;
        this.thumbnailLink = thumbnailLink;
        this.categoryId = categoryId;
        this.description = description;
        this.details = details;
        this.updatedDate = updatedDate;
        this.featured = featured;
        this.status = status;
        this.author_id = author_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public float getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(float originalPrice) {
        this.originalPrice = originalPrice;
    }

    public float getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(float salePrice) {
        this.salePrice = salePrice;
    }

    public String getThumbnailLink() {
        return thumbnailLink;
    }

    public void setThumbnailLink(String thumbnailLink) {
        this.thumbnailLink = thumbnailLink;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(int author_id) {
        this.author_id = author_id;
    }
    
}