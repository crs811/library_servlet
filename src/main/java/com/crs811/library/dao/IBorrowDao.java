package com.crs811.library.dao;

//import javax.crypto.interfaces.PBEKey;

import com.crs811.library.entity.Borrow;

import java.util.Date;
import java.util.List;

public interface IBorrowDao {
    //增加借阅信息
    int addBorrow(int readerID, String bookID);

    //删除某条记录 - returnTime为空的记录
    boolean delBorrowReturnIsNull(int readerID, String bookID);

    //通过id更改借阅信息(还书)
    boolean updateBorrow(int readerID, String bookID);

    //通过用户id查询已借数量
    int getBorrowNumByReaderID(int readerID);

    //通过用户id查询是否可以借书
    boolean getAllowByReaderID(int readerID);

    //通过用户id和书籍id, 时间查询借阅信息
    boolean isBorrowExist(int readerID, String bookID);

}
