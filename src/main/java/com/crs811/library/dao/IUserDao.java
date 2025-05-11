package com.crs811.library.dao;

import com.crs811.library.entity.Page;
import com.crs811.library.entity.StaticInfo;
import com.crs811.library.entity.User;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface IUserDao {
    // 统计信息
    StaticInfo getStaticInfo() throws SQLException;

    // 用户登录
    User login(String username, String password);

    // 用户注册
    boolean register(User user);

    // 返回用户信息集合
    List<User> getUserAll(String type);

    // 根据id查询用户信息
    User getUserById(int id);

    // 根据id删除用户
    boolean deleteUser(int id);

    // 更新用户信息
    boolean updateUser(User user);

    // 更新用户密码
    boolean changePassword(int id, String oldPassword, String newPassword);

    // 根据条件查询用户总数
    Integer getUserCountByCondition(String type, Map<String, Object> searchParams);

    // 根据条件查询用户信息
    List<User> getUsersByPage(String type, Page page, Map<String, Object> searchParams);
}
