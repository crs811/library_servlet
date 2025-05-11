package com.crs811.library.entity;

//import com.crs811.library.util.DateUtils;
//import java.sql.Timestamp;

/**
 * @program: library
 * @description: 借书记录实体类
 * @author:
 * @create: 2021-10-25 11:13
 **/
public class Borrow {
    //读者id
    private int readerID;
    //书籍id
    private String bookID;
    //借出时间
    private String borrowTime;
    //归还时间
    private String returnTime;

    public Borrow(int readerID, String bookID, String borrowTime, String returnTime) {
        this.readerID = readerID;
        this.bookID = bookID;
        this.borrowTime = borrowTime;
        this.returnTime = returnTime;
    }

    public Borrow(int readerID, String bookID, String borrowTime) {
        this.readerID = readerID;
        this.bookID = bookID;
        this.borrowTime = borrowTime;
        this.returnTime = null;
    }

    public Borrow() {
    }

    @Override
    public String toString() {
        return "borrow{" +
                "readerID='" + readerID + '\'' +
                ", bookID='" + bookID + '\'' +
                ", borrowTime=" + borrowTime +
                ", returnTime=" + returnTime +
                '}';
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
