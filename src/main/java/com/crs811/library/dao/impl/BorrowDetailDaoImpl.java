package com.crs811.library.dao.impl;

import com.crs811.library.dao.IBorrowDetailDao;
import com.crs811.library.entity.BorrowDetail;
import com.crs811.library.entity.Page;
import com.crs811.library.util.JdbcUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BorrowDetailDaoImpl implements IBorrowDetailDao {

    // 根据ID查询某人的借阅信息
    @Override
    public List<BorrowDetail> getBorrowByReaderID(Page page, String readerID) {
        List<BorrowDetail> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select * from borrow_detail where readerID=? order by borrowTime desc limit ?,?",
                    readerID, page.getStartNum(), page.getPageSize());
            while (rs.next()) {
                BorrowDetail borrow = newBorrowDetail(rs);
                list.add(borrow);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        //如果取到数据，则返回该对象
        return list;
    }

    // 根据ID查询某人的未归还借阅信息
    @Override
    public List<BorrowDetail> getUnreturnByReaderID(Page page, String readerID) {
        List<BorrowDetail> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select * from borrow_detail where readerID=? and returnTime is null limit ?,?",
                    readerID, page.getStartNum(), page.getPageSize());
            while (rs.next()) {
                BorrowDetail borrow = newBorrowDetail(rs);
                list.add(borrow);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        //如果取到数据，则返回该对象
        //borrows.stream().forEach(s-> System.out.println(s));
        return list;
    }

    // 根据ID查询某书籍的借阅信息
    @Override
    public List<BorrowDetail> getBorrowByBookID(Page page, String bookID) {
        List<BorrowDetail> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select * from borrow_detail where bookID=? order by borrowTime desc limit ?,?",
                    bookID, page.getStartNum(), page.getPageSize());
            while (rs.next()) {
                BorrowDetail borrow = newBorrowDetail(rs);
                list.add(borrow);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        //如果取到数据，则返回该对象
        //borrows.stream().forEach(s-> System.out.println(s));
        return list;
    }

    // 根据ID查询某书籍的未归还借阅信息
    @Override
    public List<BorrowDetail> getUnreturnByBookID(Page page, String bookID) {
        List<BorrowDetail> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select * from borrow_detail where bookID=? and returnTime is null order by borrowTime desc limit ?,?",
                    bookID, page.getStartNum(), page.getPageSize());
            while (rs.next()) {
                BorrowDetail borrow = newBorrowDetail(rs);
                list.add(borrow);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        //如果取到数据，则返回该对象
        //borrows.stream().forEach(s-> System.out.println(s));
        return list;
    }

    // 分页查询所有借阅信息
    @Override
    public List<BorrowDetail> getAllBorrow(Page page) {
        List<BorrowDetail> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select * from borrow_detail order by borrowTime desc limit ?,?",
                    page.getStartNum(), page.getPageSize());
            while (rs.next()) {
                BorrowDetail borrow = newBorrowDetail(rs);
                list.add(borrow);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        //如果取到数据，则返回该对象
        //borrows.stream().forEach(s-> System.out.println(s));
        return list;
    }

    // 分页查询所有未归还图书的信息
    @Override
    public List<BorrowDetail> getUnreturnBook(Page page) {
        List<BorrowDetail> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select * from borrow_detail where returnTime is null limit ?,?",
                    page.getStartNum(), page.getPageSize());
            while (rs.next()) {
                BorrowDetail borrow = newBorrowDetail(rs);
                list.add(borrow);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        //如果取到数据，则返回该对象
        //borrows.stream().forEach(s-> System.out.println(s));
        return list;
    }

    @Override
    public int getUnreturnBookCount() {
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select count(*) from borrow_detail where returnTime is null");
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return 0;
    }

    @Override
    public int getAllBorrowCount() {
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select count(*) from borrow_detail");
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return 0;
    }

    @Override
    public int getUnreturnByReaderIDCount(String readerID) {
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select count(*) from borrow_detail where readerID=? and returnTime is null order by borrowTime desc", readerID);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return 0;
    }

    @Override
    public int getBorrowByReaderIDCount(String readerID) {
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select count(*) from borrow_detail where readerID=? order by borrowTime desc", readerID);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return 0;
    }

    @Override
    public int getUnreturnByBookIDCount(String bookID) {
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select count(*) from borrow_detail where bookID=? and returnTime is null", bookID);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return 0;
    }

    @Override
    public int getBorrowByBookIDCount(String bookID) {
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select count(*) from borrow_detail where bookID=?", bookID);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return 0;
    }

    private BorrowDetail newBorrowDetail(ResultSet rs) throws SQLException {
        return new BorrowDetail(
            rs.getInt("readerID"),
            rs.getString("bookID"),
            rs.getString("nickname"),
            rs.getString("bookName"),
            rs.getString("borrowTime"),
            rs.getString("returnTime"));
    }
}
