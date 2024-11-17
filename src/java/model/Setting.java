package model;

public class Setting {
    private String type;
    private String name;
    private int value;
    private String description;
    private int status;

    // Constructor mặc định
    public Setting() {
    }

    // Constructor với các thuộc tính
    public Setting(String type, String name, int value, String description, int status) {
        this.type = type;
        this.name = name;
        this.value = value;
        this.description = description;
        this.status = status;
    }

    // Getters và Setters
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
