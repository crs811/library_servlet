package com.crs811.library.dao;

import com.crs811.library.entity.Book;
import com.crs811.library.entity.Page;
import com.crs811.library.entity.User;

import java.util.List;
import java.util.Map;

public interface IBookDao {

    // 返回书籍信息集合
    List<Book> getBookAll();

    // 根据书籍ID查询书籍
    Book getBookById(String id);

    // 添加新书籍
    boolean addBook(Book book);

    // 根据ID删除书籍
    boolean deleteBook(String id);

    // 更新书籍信息
    boolean updateBook(Book book);

    // 借出书籍
    boolean borrowBook(Book book);

    //归还书籍
    boolean returnBook(String bookID);

    // 根据条件查询用户总数
    Integer getBookCountByCondition(Map<String, Object> searchParams);

    // 根据条件查询用户信息
    List<Book> getBookByPage(Page page, Map<String, Object> searchParams);

}
