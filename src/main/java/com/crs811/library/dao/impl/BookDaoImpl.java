package com.crs811.library.dao.impl;

import com.crs811.library.dao.IBookDao;
import com.crs811.library.entity.Book;
import com.crs811.library.entity.Page;
import com.crs811.library.entity.User;
import com.crs811.library.util.JdbcUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class BookDaoImpl implements IBookDao {
    @Override
    public List<Book> getBookAll() {
        List<Book> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select * from book order by bookName");
            while (rs.next()) {
                Book book = newBook(rs);
                list.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return list;
    }

    @Override
    public Book getBookById(String id) {
        Book book = null;
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select * from book where bookID=?", id);
            if (rs.next()) {
                book = newBook(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return book;
    }

    @Override
    public boolean addBook(Book book) {
        // UUID() 生成随机ID
        int i = JdbcUtils.executeSql("insert into book(bookID, bookName, bookAuthor, bookPublisher, publishTime, bookPrice, bookSum, bookLend, tag, isbn) " +
                        "values(REPLACE(UUID(),'-',''),?,?,?,?,?,?,?,?,?)",
                book.getBookName(),book.getBookAuthor(),book.getBookPublisher(),book.getPublishTime(),
                book.getBookPrice(),book.getBookSum(),book.getBookLend(),book.getTag(),book.getIsbn());
        return i > 0;
    }

    @Override
    public boolean deleteBook(String bookID) {
        // TODO: 判断是否有借阅记录，有则不允许删除

        int i = JdbcUtils.executeSql("delete from book where bookID=?", bookID);
        return i > 0;
    }

    @Override
    public boolean updateBook(Book book) {
        // System.out.println(book.toString());
        int i = JdbcUtils.executeSql("update book set bookName=?, bookAuthor=?, bookPublisher=?, publishTime=?, bookPrice=?, bookSum=?, bookLend=?, tag=?, isbn=? " +
                        " where bookID=?",
                book.getBookName(),book.getBookAuthor(),book.getBookPublisher(),book.getPublishTime(),
                book.getBookPrice(),book.getBookSum(),book.getBookLend(),book.getTag(),book.getIsbn(),
                book.getBookID());
        return i > 0;
    }

    @Override
    public boolean borrowBook(Book book) {
        //如果库存小于等于借出数量，返回不成功
        if (book.getBookSum() <= book.getBookLend() || book.getBookLend() < 0) {
            return false;
        }
        int i = JdbcUtils.executeSql("update book set bookLend=? where bookID=?", book.getBookLend() + 1, book.getBookID());
        return i > 0;
    }

    @Override
    public boolean returnBook(String bookID) {
        Book book = getBookById(bookID);
        //System.out.println("BookDAOImpl -> returnBook(75): " + book);
        //如果借出数量大于库存,已借数量小于等于0，返回不成功
        if (book.getBookSum() < book.getBookLend() || book.getBookLend() < 1) {
            return false;
        }
        int i = JdbcUtils.executeSql("update book set bookLend=? where bookID=?", book.getBookLend() - 1, book.getBookID());
        return i > 0;
    }

    @Override
    public Integer getBookCountByCondition(Map<String, Object> searchParams) {
        String sql = "select count(*) from book where 1=1 ";
        List<Object> params = new ArrayList<>();

        // 判断是否有查询内容
        if (searchParams.containsKey("field")) {
            sql += " and " + searchParams.get("field") + " like ? ";
            params.add("%" + searchParams.get("text") + "%");
        }

        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql(sql, params.toArray());
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

    // 分页查询书籍信息
    @Override
    public List<Book> getBookByPage(Page page, Map<String, Object> searchParams) {
        String sql = "select * from book where 1=1 ";
        List<Object> params = new ArrayList<>();

        // 判断是否有查询内容
        if (searchParams.containsKey("field")) {
            sql += " and " + searchParams.get("field") + " like ? ";
            params.add("%" + searchParams.get("text") + "%");
        }

        sql += " order by bookName limit ?,? ";
        params.add(page.getStartNum());
        params.add(page.getPageSize());
        ResultSet rs = null;
        List<Book> list = new ArrayList<>();
        try {
            rs = JdbcUtils.selectSql(sql, params.toArray());
            while (rs.next()) {
                Book book = newBook(rs);
                list.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return list;
    }

    private Book newBook(ResultSet rs) throws SQLException {
        return new Book(rs.getString("bookID"),
                rs.getString("bookName"),
                rs.getString("bookAuthor"),
                rs.getString("bookPublisher"),
                rs.getString("publishTime"),
                rs.getFloat("bookPrice"),
                rs.getInt("bookSum"),
                rs.getInt("bookLend"),
                rs.getString("tag"),
                rs.getString("isbn"));
    }
}
