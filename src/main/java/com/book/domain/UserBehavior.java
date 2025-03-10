package com.book.domain;

import java.util.Date;

public class UserBehavior {
    private String userName;        // 用户名
    private int borrowCount;        // 借阅次数
    private Date lastBorrowTime;    // 最近借阅时间
    private String preferredCategory; // 常借类型
    private boolean hasOverdue;     // 是否有逾期
    private String activityLevel;   // 活跃度级别

    // 构造函数
    public UserBehavior() {}

    // getter和setter方法
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getBorrowCount() {
        return borrowCount;
    }

    public void setBorrowCount(int borrowCount) {
        this.borrowCount = borrowCount;
    }

    public Date getLastBorrowTime() {
        return lastBorrowTime;
    }

    public void setLastBorrowTime(Date lastBorrowTime) {
        this.lastBorrowTime = lastBorrowTime;
    }

    public String getPreferredCategory() {
        return preferredCategory;
    }

    public void setPreferredCategory(String preferredCategory) {
        this.preferredCategory = preferredCategory;
    }

    public boolean isHasOverdue() {
        return hasOverdue;
    }

    public void setHasOverdue(boolean hasOverdue) {
        this.hasOverdue = hasOverdue;
    }

    public String getActivityLevel() {
        return activityLevel;
    }

    public void setActivityLevel(String activityLevel) {
        this.activityLevel = activityLevel;
    }
} 