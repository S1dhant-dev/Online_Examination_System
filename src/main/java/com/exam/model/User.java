package com.exam.model;

public class User {
    private int userId;
    private String username;
    private String fullName;
    private String uidNo;
    private String classSection;
    private String role;

    public User(int userId, String username, String fullName, String uidNo, String classSection, String role) {
        this.userId = userId;
        this.username = username;
        this.fullName = fullName;
        this.uidNo = uidNo;
        this.classSection = classSection;
        this.role = role;
    }

    public int getUserId() { return userId; }
    public String getUsername() { return username; }
    public String getFullName() { return fullName; }
    public String getUidNo() { return uidNo; }
    public String getClassSection() { return classSection; }
    public String getRole() { return role; }
}
