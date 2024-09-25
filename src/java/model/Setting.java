package model;

public class Setting {
    private int id;
    private String type;
    private String name;
    private int value;
    private String description;
    private String status;

    // Constructor mặc định
    public Setting() {
    }

    // Constructor với tất cả các thuộc tính
    public Setting(int id, String type, String name, int value, String description, String status) {
        this.id = id;
        this.type = type;
        this.name = name;
        this.value = value;
        this.description = description;
        this.status = status;
    }

    // Getters và Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
