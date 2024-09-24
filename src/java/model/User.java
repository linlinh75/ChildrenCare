package model;


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
    private int status;

    public User() {
    }

    public User(int id, String email, String password, String fullName, boolean gender, String mobile, String address, String imageLink, int roleId, int status) {
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

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}