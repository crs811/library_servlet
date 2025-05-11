package com.crs811.library.entity;

public class StaticInfo {
    int bookCount;
    int userCount;
    int borrowCount;
    int borrowUnreturnedCount;

    public StaticInfo(int bookCount, int userCount, int borrowCount, int borrowUnreturnedCount) {
        this.bookCount = bookCount;
        this.userCount = userCount;
        this.borrowCount = borrowCount;
        this.borrowUnreturnedCount = borrowUnreturnedCount;
    }

    public StaticInfo() {
    }

    public int getBookCount() {
        return bookCount;
    }

    public void setBookCount(int bookCount) {
        this.bookCount = bookCount;
    }

    public int getUserCount() {
        return userCount;
    }

    public void setUserCount(int userCount) {
        this.userCount = userCount;
    }

    public int getBorrowCount() {
        return borrowCount;
    }

    public void setBorrowCount(int borrowCount) {
        this.borrowCount = borrowCount;
    }

    public int getBorrowUnreturnedCount() {
        return borrowUnreturnedCount;
    }

    public void setBorrowUnreturnedCount(int borrowUnreturnedCount) {
        this.borrowUnreturnedCount = borrowUnreturnedCount;
    }
}
