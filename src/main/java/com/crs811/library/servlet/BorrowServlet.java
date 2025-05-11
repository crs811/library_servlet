package com.crs811.library.servlet;

import com.crs811.library.dao.IBorrowDao;
import com.crs811.library.dao.IBorrowDetailDao;
import com.crs811.library.dao.impl.BookDaoImpl;
import com.crs811.library.dao.impl.BorrowDaoImpl;
import com.crs811.library.dao.impl.BorrowDetailDaoImpl;
import com.crs811.library.dao.impl.UserDaoImpl;
import com.crs811.library.entity.*;
import com.crs811.library.util.JSONUtil;
import com.crs811.library.util.PageUtil;
import com.crs811.library.util.Result;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/borrow")
public class BorrowServlet extends HttpServlet {
    IBorrowDetailDao borrowDetailDao = new BorrowDetailDaoImpl();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // super.service(req, resp);
        String method = req.getParameter("method");

        switch (method) {
            case "borrowDetailSearch":
                borrowDetailSearch(req,resp);
                break;
            case "borrowAddPage":
                borrowAddPage(req, resp);
                break;
            case "borrowAdd":
                borrowAdd(req, resp);
                break;
            case "borrowDelete":
                borrowDelete(req,resp);
                break;
        }
    }

    private void borrowDetailSearch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<BorrowDetail> borrowDetailList = null;
        //根据id查找借阅信息
        String bookID = req.getParameter("bookID");
        String readerID = req.getParameter("readerID");
        //是否只查询未归还的数据
        String isNull = req.getParameter("isNull");
        //borrowDAO.getBorrowByBookID()

        User user = (User) req.getSession().getAttribute("USER_IN_SESSION");

        // 获取分页页码信息和每页条数
        int pageNum = PageUtil.getTargetPage(req);
        int pageSize = PageUtil.getPageSize(req);
        Page page = new Page(pageSize, pageNum);

        page.setPathPrefix("method=borrowDetailSearch&");

        //当bookID和readerID都为空，说明显示全部
        if ((bookID == null || bookID.isEmpty()) && (readerID == null || readerID.isEmpty())) {
            //如果isNull为T，查询未归还的书籍
            if ("T".equals(isNull)) {
                // 查询总数，设置分页参数
                page.setTotalNumber(borrowDetailDao.getUnreturnBookCount());
                // 分页查询
                borrowDetailList = borrowDetailDao.getUnreturnBook(page);
            } else {
                page.setTotalNumber(borrowDetailDao.getAllBorrowCount());
                borrowDetailList = borrowDetailDao.getAllBorrow(page);
            }
        } else if (bookID == null || bookID.isEmpty()) {
            //readerID不为空，查询某人所有借阅记录
            //如果isNull为T，查询此人未归还的书籍
            if ("T".equals(isNull)) {
                page.setTotalNumber(borrowDetailDao.getUnreturnByReaderIDCount(readerID));
                borrowDetailList = borrowDetailDao.getUnreturnByReaderID(page, readerID);
            } else {
                page.setTotalNumber(borrowDetailDao.getBorrowByReaderIDCount(readerID));
                borrowDetailList = borrowDetailDao.getBorrowByReaderID(page, readerID);
            }
        } else {
            //bookID不为空，查询某书籍所有借阅记录
            //如果isNull为T，查询某书籍未归还的记录
            if ("T".equals(isNull)) {
                page.setTotalNumber(borrowDetailDao.getUnreturnByBookIDCount(bookID));
                borrowDetailList = borrowDetailDao.getUnreturnByBookID(page, bookID);
            } else {
                page.setTotalNumber(borrowDetailDao.getBorrowByBookIDCount(bookID));
                borrowDetailList = borrowDetailDao.getBorrowByBookID(page, bookID);
            }
        }

        req.setAttribute("page", page);
        req.setAttribute("borrowDetailList", borrowDetailList);

        // 判断用户类型，跳转到相应页面
        if (user.getType().equals(User.READER)) {
            req.getRequestDispatcher("/reader/borrow_list.jsp").forward(req, resp);
        }else {
            req.getRequestDispatcher("/admin/borrow_list.jsp").forward(req, resp);
        }
    }

    private void borrowAddPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> readerList = new UserDaoImpl().getUserAll(User.READER);
        List<Book> bookList = new BookDaoImpl().getBookAll();
        req.setAttribute("readerList", readerList);
        req.setAttribute("bookList", bookList);
        req.getRequestDispatcher("/admin/borrow_add.jsp").forward(req, resp);
    }

    private void borrowAdd(HttpServletRequest req, HttpServletResponse resp) {
        int readerID = Integer.parseInt(req.getParameter("readerID"));
        String bookID = req.getParameter("bookID");
        //System.out.println("AddBookServlet -> doPost(25): " + borrow);

        IBorrowDao borrowDao = new BorrowDaoImpl();
        int result = borrowDao.addBorrow(readerID, bookID);
        // System.out.println("AddBookServlet -> doPost(27): " + result);

        switch (result) {
            case 0:
                JSONUtil.toJSON(resp, Result.ok("借阅成功！"));
                break;
            case 1:
                JSONUtil.toJSON(resp, Result.error("借阅信息已存在！"));
                break;
            case 2:
                JSONUtil.toJSON(resp, Result.error("达到最大借书数量！请尽快归还！"));
                break;
            case 3:
                JSONUtil.toJSON(resp, Result.error("库存不足！"));
                break;
            default:
                JSONUtil.toJSON(resp, Result.error("借阅失败！"));
                break;
        }
    }

    private void borrowDelete(HttpServletRequest req, HttpServletResponse resp) {
        // System.out.println("borrowDelete");
        if (new BorrowDaoImpl().updateBorrow(Integer.parseInt(req.getParameter("readerID")), req.getParameter("bookID"))) {
            JSONUtil.toJSON(resp, Result.ok("归还成功！"));
        } else {
            JSONUtil.toJSON(resp, Result.error("归还失败！"));
        }
    }
}
