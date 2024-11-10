package model;

import java.time.LocalDate;

/**
 * Represents a user of the application.
 */
public class User {

    private int id;
    private String email;
    private String password;
    private String fullName;
    private boolean gender;
    private String mobile;
    private String address;
    private String imageLink;
    private int roleId;
    private String status;
    private LocalDate created_date;

    public User(int id, String email, String password, String fullName, boolean gender, String mobile, String address, String imageLink, int roleId, String status, LocalDate created_date) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.gender = gender;
        this.mobile = mobile;
        this.address = address;
        this.imageLink = imageLink;
        this.roleId = roleId;
        this.status = status;
        this.created_date = created_date;
    }

    

    public LocalDate getCreated_date() {
        return created_date;
    }

    public void setCreated_date(LocalDate created_date) {
        this.created_date = created_date;
    }
    public User() {
    }

    public User(int id, String email, String password, String fullName, boolean gender, String mobile, String address, String imageLink, int roleId, String status) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.gender = gender;
        this.mobile = mobile;
        this.address = address;
        this.imageLink = imageLink;
        this.roleId = roleId;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getImageLink() {
        return imageLink;
    }

    public void setImageLink(String imageLink) {
        this.imageLink = imageLink;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", email=" + email + ", password=" + password + ", fullName=" + fullName + ", gender=" + gender + ", mobile=" + mobile + ", address=" + address + ", imageLink=" + imageLink + ", roleId=" + roleId + ", status=" + status + '}';
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isAdmin() {
        return roleId == 1;
    }
    
    public boolean isManager() {
        return roleId == 2;
    }
    
    public boolean isStaff() {
        return roleId == 3;
    }
    
    public boolean isCustomer() {
        return roleId == 4;
    }
}
