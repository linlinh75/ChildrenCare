/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

/**
 *
 * @author Admin
 */
public class StatsPerDay {
    private int id;
    private String date;
    private List<StatToMap> stats;

    public StatsPerDay(int id, String date, List<StatToMap> list) {
        this.id = id;
        this.date = date;
        this.stats = list;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public List<StatToMap> getList() {
        return stats;
    }

    public void setList(List<StatToMap> list) {
        this.stats = list;
    }

    @Override
    public String toString() {
        return "StatsPerDate{" + "id=" + id + ", date=" + date + ", list=" + stats + '}';
    }
    
}
