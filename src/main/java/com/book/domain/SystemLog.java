package com.book.domain;

import java.sql.Timestamp;

public class SystemLog {
    private int id;
    private Timestamp timestamp;
    private int userId;
    private String userName;
    private String operationType;
    private String description;
    private String result;
    private String ipAddress;

    // 默认构造函数
    public SystemLog() {}

    // 带参数的构造函数
    public SystemLog(int userId, String userName, String operationType, String description, String result, String ipAddress) {
        this.userId = userId;
        this.userName = userName;
        this.operationType = operationType;
        this.description = description;
        this.result = result;
        this.ipAddress = ipAddress;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getOperationType() {
        return operationType;
    }

    public void setOperationType(String operationType) {
        this.operationType = operationType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }
}