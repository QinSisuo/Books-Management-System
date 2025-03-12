package com.book.domain;

public class StatisticsData {
    private int todayBorrows;
    private int todayReturns;
    private int currentBorrows;
    private int overdueCount;

    // 构造函数
    public StatisticsData() {}

    public StatisticsData(int todayBorrows, int todayReturns, int currentBorrows, int overdueCount) {
        this.todayBorrows = todayBorrows;
        this.todayReturns = todayReturns;
        this.currentBorrows = currentBorrows;
        this.overdueCount = overdueCount;
    }

    // Getter 和 Setter
    public int getTodayBorrows() {
        return todayBorrows;
    }

    public void setTodayBorrows(int todayBorrows) {
        this.todayBorrows = todayBorrows;
    }

    public int getTodayReturns() {
        return todayReturns;
    }

    public void setTodayReturns(int todayReturns) {
        this.todayReturns = todayReturns;
    }

    public int getCurrentBorrows() {
        return currentBorrows;
    }

    public void setCurrentBorrows(int currentBorrows) {
        this.currentBorrows = currentBorrows;
    }

    public int getOverdueCount() {
        return overdueCount;
    }

    public void setOverdueCount(int overdueCount) {
        this.overdueCount = overdueCount;
    }

    @Override
    public String toString() {
        return "StatisticsData{" +
                "todayBorrows=" + todayBorrows +
                ", todayReturns=" + todayReturns +
                ", currentBorrows=" + currentBorrows +
                ", overdueCount=" + overdueCount +
                '}';
    }
}
