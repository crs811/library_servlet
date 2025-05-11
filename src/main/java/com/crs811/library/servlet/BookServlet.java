package com.crs811.library.servlet;

import com.crs811.library.dao.IBookDao;
import com.crs811.library.dao.IBorrowDao;
import com.crs811.library.dao.impl.BookDaoImpl;
import com.crs811.library.dao.impl.BorrowDaoImpl;
import com.crs811.library.entity.Book;
import com.crs811.library.entity.Page;
import com.crs811.library.entity.User;
import com.crs811.library.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@WebServlet("/book")
public class BookServlet extends HttpServlet {
    private final IBookDao bookDao = new BookDaoImpl();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // super.service(req, resp);
        String method = req.getParameter("method");

        switch (method) {
            case "bookSearch":
                bookSearch(req,resp);
                break;
            case "bookAdd":
                bookAdd(req, resp);
                break;
            case "bookEditPage":
                bookEditPage(req,resp);
            case "bookEdit":
                bookEdit(req,resp);
                break;
            case "bookDelete":
                bookDelete(req, resp);
                break;
        }
    }

    private void bookSearch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String bookID = req.getParameter("bookID");

        User user = (User)req.getSession().getAttribute("USER_IN_SESSION"); // 获取当前登录用户

        List<Book> bookList = null;

        if ( bookID != null ) {
            bookList = new ArrayList<>();
            bookList.add(bookDao.getBookById(bookID));
        } else {
            // 获取所有的查询条件参数（为了使用方便，所有查询条件的参数命名前缀都是"search_"）
            Map<String, Object> searchParams = WebUtils.getParametersStartingWith(req, "search_");
            // System.out.println("searchParams: " + searchParams);

            // 获取分页页码信息和每页条数
            int pageNum = PageUtil.getTargetPage(req);
            int pageSize = PageUtil.getPageSize(req);
            Page page = new Page(pageSize, pageNum);

            page.setTotalNumber(bookDao.getBookCountByCondition(searchParams));
            page.setPathPrefix("method=bookSearch&");

            // 查询需要展示的内容
            bookList = bookDao.getBookByPage(page, searchParams);

            req.setAttribute("page", page);
            // 将搜索条件编码成字符串，用于排序，分页的URL
            req.setAttribute("searchParams", PageUtil.encodeParameterStringWithPrefix(searchParams, "search_"));
        }

        if (Objects.equals(user.getType(), User.ADMIN)) {
            req.setAttribute("bookList", bookList);
            req.getRequestDispatcher("/admin/book_list.jsp").forward(req, resp);
        } else {
            // 读者 或 游客
            IBorrowDao borrowDao = new BorrowDaoImpl();
            boolean allow = borrowDao.getAllowByReaderID(user.getId()); // 是否允许借阅
            req.setAttribute("bookList", bookList);
            req.setAttribute("allow", allow);
            req.getRequestDispatcher("/reader/book_list.jsp").forward(req, resp);
        }
    }

    private void bookAdd(HttpServletRequest req, HttpServletResponse resp) {
        Book book = Book.setBook(req);
        IBookDao bookDao = new BookDaoImpl();
        if (bookDao.addBook(book)) {
            JSONUtil.toJSON(resp, Result.ok("添加成功"));
        } else {
            JSONUtil.toJSON(resp, Result.error("添加失败"));
        }
    }

    private void bookEditPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String bookId = req.getParameter("id");
        IBookDao bookDao = new BookDaoImpl();
        Book book = bookDao.getBookById(bookId);
        if (book != null) {
            JSONUtil.toJSON(resp, Result.ok(book));
        } else {
            JSONUtil.toJSON(resp, Result.error("查询失败"));
        }
    }

    private void bookEdit(HttpServletRequest req, HttpServletResponse resp) {
        Book book = Book.setBook(req);
        IBookDao bookDao = new BookDaoImpl();
        if (bookDao.updateBook(book)) {
            JSONUtil.toJSON(resp, Result.ok("修改成功"));
        } else {
            JSONUtil.toJSON(resp, Result.error("修改失败"));
        }
    }

    private void bookDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String bookId = req.getParameter("id");
        IBookDao bookDao = new BookDaoImpl();
        if (bookDao.deleteBook(bookId)) {
            bookSearch(req, resp);
        } else {
            resp.sendRedirect("index.jsp");
        }
    }
}
