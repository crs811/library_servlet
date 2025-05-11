package com.crs811.library.dao.impl;

import com.crs811.library.dao.IBookDao;
import com.crs811.library.dao.IBorrowDao;
import com.crs811.library.entity.Book;
import com.crs811.library.entity.Borrow;
import com.crs811.library.util.JdbcUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BorrowDaoImpl implements IBorrowDao {
    //设置最大借书数量
    static final public int MAX_LEND_NUM = 8;

    @Override
    public int addBorrow(int readerID, String bookID) {
        // System.out.println("BorrowDAOImpl -> addBorrow(25)borrow: " + readerID + " bookID: " + bookID);
        IBookDao bookDao = new BookDaoImpl();
        Book book = bookDao.getBookById(bookID);

        // 借阅信息已存在
        if (isBorrowExist(readerID, bookID)) {
            return 1;
        }

        // 当前读者借书量大于最大值
        if (!getAllowByReaderID(readerID)) {
            return 2;
        }

        // 添加借阅信息
        int i = JdbcUtils.executeSql("insert into borrow(readerID,bookID) values(?,?)",readerID, bookID);
        if (i > 0) {
            //借阅信息成功入表后，更改书的借阅数量
            if (bookDao.borrowBook(book)) {
                //借书成功
                return 0;
            } else {
                //借书失败删除借书记录 - 回滚
                // 库存不足
                delBorrowReturnIsNull(readerID, bookID);
                return 3;
            }
        }
        // 未知错误
        return 4;
    }

    @Override
    public boolean delBorrowReturnIsNull(int readerID, String bookID){
        // System.out.println("BorrowDAOImpl -> delBorrowReturnIsNull (12)readerID: " + readerID + " bookID: " + bookID);
        int i = JdbcUtils.executeSql("delete from borrow where readerID=? and bookID=? and returnTime is null",
                readerID, bookID);
        return i > 0;
    }

    //还书
    @Override
    public boolean updateBorrow(int readerID, String bookID) {
        // System.out.println("BorrowDAOImpl -> updateBorrow(11)borrow: " + readerID + " bookID: " + bookID);
        // 更新书籍数量
        boolean bOK = new BookDaoImpl().returnBook(bookID);
        // System.out.println("bOK: " + bOK);
        int j = 0;
        // 更新成功才更新借阅表
        if (bOK) {
            j = JdbcUtils.executeSql("update borrow set returnTime=now() where readerID=? and bookID=? and returnTime is null",
                readerID, bookID);
        }
        return bOK && j>0;
    }

    @Override
    public int getBorrowNumByReaderID(int readerID) {
        int lendSum = 0;
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select count(*) from borrow where readerID=? and returnTime is null", readerID);
            if (rs.next()) {
                lendSum = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        // System.out.println("BorrowDAOImpl -> getBorrowNumByReaderID(11)lendSum: " + lendSum);
        return lendSum;
    }

    @Override
    public boolean getAllowByReaderID(int readerID) {
        //必须小于最大值才能借书
        return getBorrowNumByReaderID(readerID) < MAX_LEND_NUM;
    }

    @Override
    public boolean isBorrowExist(int readerID, String bookID) {
        int num = 0;
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select count(*) from borrow where readerID=? and bookID=? and returnTime is null",
                    readerID, bookID);
            if (rs.next()) {
                num = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return num > 0;
    }

    private Borrow newBorrow(ResultSet rs) throws SQLException {
        return new Borrow(
                rs.getInt("readerID"),
                rs.getString("bookID"),
                rs.getString("borrowTime"),
                rs.getString("returnTime")
        );
    }
}
