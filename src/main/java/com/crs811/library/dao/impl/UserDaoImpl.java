package com.crs811.library.dao.impl;

import com.crs811.library.dao.IUserDao;
import com.crs811.library.entity.Page;
import com.crs811.library.entity.StaticInfo;
import com.crs811.library.entity.User;
import com.crs811.library.util.JdbcUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class UserDaoImpl implements IUserDao {

    // 获取统计信息, 数据在 index.jsp 中展示
    @Override
    public StaticInfo getStaticInfo() throws SQLException {
        ResultSet rsBookCount = null;
        ResultSet rsUserCount = null;
        ResultSet rsBorrowCount = null;
        ResultSet rsBorrowUnreturnedCount = null;

        int tatalBookCount = 0;
        int totalUserCount = 0;
        int totalBorrowCount = 0;
        int totalBorrowUnreturnedCount = 0;

        try {
            rsBookCount = JdbcUtils.selectSql("select count(*) from book");
            rsUserCount = JdbcUtils.selectSql("select count(*) from user where type=1");
            rsBorrowCount = JdbcUtils.selectSql("select count(*) from borrow");
            rsBorrowUnreturnedCount = JdbcUtils.selectSql("select count(*) from borrow where returnTime is null");

            if (rsBookCount.next()) {
                tatalBookCount = rsBookCount.getInt(1);
            }
            if (rsUserCount.next()) {
                totalUserCount = rsUserCount.getInt(1);
            }
            if (rsBorrowCount.next()) {
                totalBorrowCount = rsBorrowCount.getInt(1);
            }
            if (rsBorrowUnreturnedCount.next()) {
                totalBorrowUnreturnedCount = rsBorrowUnreturnedCount.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, null);
            if (rsBookCount != null)    rsBookCount.close();
            if (rsUserCount != null)    rsUserCount.close();
            if (rsBorrowCount != null)  rsBorrowCount.close();
            if (rsBorrowUnreturnedCount != null)    rsBorrowUnreturnedCount.close();
        }

        // TODO: 可以使用 addBatch() / executeBatch() / clearBatch() 同时执行多条SQL语句提高性能

        return new StaticInfo(tatalBookCount, totalUserCount, totalBorrowCount, totalBorrowUnreturnedCount);
    }

    // Login
    @Override
    public User login(String username, String password) {
        User user = null;
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select * from user where username=? and password=? and status=0", username, password);
            if (rs.next()) {
                if (rs.getString("username").equals(username) && rs.getString("password").equals(password)) {
                    user = newUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return user;
    }

    @Override
    public boolean register(User user) {
        int i = JdbcUtils.executeSql("insert into user(username, password, nickname, avatar, telephone, email, type, status) " +
                "values(?, ?, ?, ?, ?, ?, ?, ?)",
                user.getUsername(), user.getPassword(), user.getNickname(), user.getAvatar(), user.getTelephone(),user.getEmail(), user.getType(), user.getStatus());
        return i > 0;
    }

    @Override
    public List<User> getUserAll(String type) {
        List<User> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select * from user where type=? order by nickname", type);
            while (rs.next()) {
                User user = newUser(rs);
                list.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return list;
    }

    @Override
    public User getUserById(int id) {
        User user = null;
        ResultSet rs = null;
        try {
            rs = JdbcUtils.selectSql("select * from user where id=?", id);
            if (rs.next()) {
                user = newUser(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return user;
    }

    @Override
    public boolean deleteUser(int id) {
        // 不能删除管理员 admin
        if (id == 1) {
            return false;
        }

        int i = JdbcUtils.executeSql("delete from user where id=?", id);
        return i > 0;
    }

    @Override
    public boolean updateUser(User user) {
        int i = JdbcUtils.executeSql("update user set username=?, password=?, nickname=?, avatar=?, telephone=?, email=?, type=?, status=?" +
                " where id=?",
                user.getUsername(), user.getPassword(), user.getNickname(), user.getAvatar(), user.getTelephone(),
                user.getEmail(), user.getType(), user.getStatus(), user.getId());
        return i > 0;
    }

    @Override
    public boolean changePassword(int id, String oldPassword, String newPassword) {
        int i = JdbcUtils.executeSql("update user set password=? where id=? and password=?", newPassword, id, oldPassword);
        return i > 0;
    }


    // 根据条件查询用户总数
    @Override
    public Integer getUserCountByCondition(String type, Map<String, Object> searchParams) {
        int count = 0;
        ResultSet rs = null;
        String sql = "select count(*) from user where type= " + type;
        List<Object> params = new ArrayList<>();

        if (searchParams.containsKey("nickname")) {
            sql += " and nickname like ? ";
            params.add("%" + searchParams.get("nickname") + "%");
        }
        try {
            rs = JdbcUtils.selectSql(sql, params.toArray());
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return count;
    }

    // 根据条件分页查询用户信息
    @Override
    public List<User> getUsersByPage(String type, Page page, Map<String, Object> searchParams) {
        String sql = "select * from user where type= " + type;
        List<Object> params = new ArrayList<>();

        if (searchParams.containsKey("nickname")) {
            sql += " and nickname like ? ";
            params.add("%" + searchParams.get("nickname") + "%");
        }

        sql += " order by nickname limit ?,? ";
        params.add(page.getStartNum());
        params.add(page.getPageSize());

        ResultSet rs = null;
        List<User> list = new ArrayList<>();
        try {
            rs = JdbcUtils.selectSql(sql, params.toArray());
            User user = null;
            while (rs.next()) {
                user = newUser(rs);
                list.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.close(JdbcUtils.conn, JdbcUtils.ps, rs);
        }
        return list;
    }

    private User newUser(ResultSet rs) throws SQLException {
        return new User(rs.getInt("id"),
                rs.getString("username"),
                rs.getString("password"),
                rs.getString("nickname"),
                rs.getString("avatar"),
                rs.getString("telephone"),
                rs.getString("email"),
                rs.getString("type"),
                rs.getString("status"));
    }
}