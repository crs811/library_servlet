package com.crs811.library.dao;

import com.crs811.library.entity.BorrowDetail;
import com.crs811.library.entity.Page;

import java.util.List;

public interface IBorrowDetailDao {

    //通过用户id查询借阅信息
    List<BorrowDetail> getBorrowByReaderID(Page page, String readerID);

    //通过用户id查询，未还书籍
    List<BorrowDetail> getUnreturnByReaderID(Page page, String readerID);

    //通过书籍id查询借阅信息
    List<BorrowDetail> getBorrowByBookID(Page page, String bookID);

    //通过书籍id查询，未还书籍
    List<BorrowDetail> getUnreturnByBookID(Page page, String bookID);

    //查找所有借阅信息
    List<BorrowDetail> getAllBorrow(Page page);

    //返还未归还的书籍
    List<BorrowDetail> getUnreturnBook(Page page);

    // ===================================================================
    //获取借阅数量

    int getUnreturnBookCount();

    int getAllBorrowCount();

    int getUnreturnByReaderIDCount(String readerID);

    int getBorrowByReaderIDCount(String readerID);

    int getUnreturnByBookIDCount(String bookID);

    int getBorrowByBookIDCount(String bookID);
}
