/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Medicine {
     private int id;                // Unique identifier for the medicine
    private int examinationId;     // Foreign key to link with an examination
    private String medicineName;   // Name of the medicine
    private String dosage;         // Dosage information
    private String instructions;   // Additional instructions for usage

    // Constructor
    public Medicine() {
    }

    public Medicine(int id, int examinationId, String medicineName, String dosage, String instructions) {
        this.id = id;
        this.examinationId = examinationId;
        this.medicineName = medicineName;
        this.dosage = dosage;
        this.instructions = instructions;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getExaminationId() {
        return examinationId;
    }

    public void setExaminationId(int examinationId) {
        this.examinationId = examinationId;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }

    public String getInstructions() {
        return instructions;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }

    // toString Method for debugging and logging
    @Override
    public String toString() {
        return "Medicine{" +
                "id=" + id +
                ", examinationId=" + examinationId +
                ", medicineName='" + medicineName + '\'' +
                ", dosage='" + dosage + '\'' +
                ", instructions='" + instructions + '\'' +
                '}';
    }
}
