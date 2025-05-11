package com.crs811.library.entity;

public class BorrowDetail {
    //读者id
    private int readerID;
    //书籍id
    private String bookID;
    //读者昵称
    private String nickname;
    //书籍名称
    private String bookName;
    //借出时间
    private String borrowTime;
    //归还时间
    private String returnTime;

    public BorrowDetail(int readerID, String bookID, String nickname, String bookName, String borrowTime, String returnTime) {
        this.readerID = readerID;
        this.bookID = bookID;
        this.nickname = nickname;
        this.bookName = bookName;
        this.borrowTime = borrowTime;
        this.returnTime = returnTime;
    }

    public int getReaderID() {
        return readerID;
    }

    public void setReaderID(int readerID) {
        this.readerID = readerID;
    }

    public String getBookID() {
        return bookID;
    }

    public void setBookID(String bookID) {
        this.bookID = bookID;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getBorrowTime() {
        return borrowTime;
    }

    public void setBorrowTime(String borrowTime) {
        this.borrowTime = borrowTime;
    }

    public String getReturnTime() {
        return returnTime;
    }

    public void setReturnTime(String returnTime) {
        this.returnTime = returnTime;
    }
}
