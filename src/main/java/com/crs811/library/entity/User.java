package com.crs811.library.entity;

import java.util.Objects;

/**
 * @program: library
 * @description: 管理员实体类
 * @author:
 * @create: 2021-10-25 11:06
 **/
public class User {

    //管理员id
    private int id;
    private String username;
    private String password;
    private String nickname;
    private String avatar;    //电
    private String telephone;    //邮
    private String email;
    private String type; //用户型  0:管理员  1:普通用户 -1:游客
    private String status; //状态 0-正常 1-停用

    // 用户类型常量
    public static final String ADMIN = "0";
    public static final String READER = "1";
    public static final String VISITOR = "-1";

    public User(int id, String username, String password, String nickname, String avatar, String telephone, String email, String type, String status) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.nickname = nickname;
        this.avatar = avatar;
        this.telephone = telephone;
        this.email = email;
        this.type = type;
        this.status = status;
    }

    public User(String username, String nickname, String password, String avatar, String telephone, String email, String type, String status) {
        this.username = username;
        this.password = password;
        this.nickname = nickname;
        this.avatar = avatar;
        this.telephone = telephone;
        this.email = email;
        this.type = type;
        this.status = status;
    }

    public static User setUser(int id, String username, String password, String nickname, String avatar, String telephone, String email, String type, String status) {
        //实例化一个对象，组装属性
        User user = new User();
        if (id > 0) {
            user.setId(id);
        }
        user.setUsername(username);
        user.setPassword(password);
        user.setNickname(nickname);
        if (avatar.trim().isEmpty()) {
            user.setAvatar("avatar.jpg");
        } else {
            user.setAvatar(avatar);
        }
        user.setTelephone(telephone);
        user.setEmail(email);
        user.setType(type);
        user.setStatus(status);
        return user;
    }

    public User() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
