package com.example.entity;

import java.io.Serializable;

public class Teacher extends Account implements Serializable {
    private static final long serialVersionUID = 1L;
    //序号
    private Integer id;
    //教师编号
    private String username;
    // 教师姓名
    private String name;
    //密码
    private String password;
    //教师头像
    private String avatar;
    //教师性别
    private String sex;
    //角色标识
    private String role;
    //教师电话
    private String phone;
    //电子邮箱
    private String email;
    //办公室
    private String office;
    //学院外键
    private String collegeId;
    //学院
    private String collegeName;
    private String condi;


    public Teacher() {
    }
@Override
    public Integer getId() {
        return id;
    }

    @Override
    public void setId(Integer id) {
        this.id = id;
    }


    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String getAvatar() {
        return avatar;
    }

    @Override
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOffice() {
        return office;
    }

    public void setOffice(String office) {
        this.office = office;
    }
    @Override
    public String getRole() {
        return role;
    }

    @Override
    public void setRole(String role) {
        this.role = role;
    }

    public String getCollegeId() {
        return collegeId;
    }

    public void setCollegeId(String collegeId) {
        this.collegeId = collegeId;
    }

    public String getCollegeName() {
        return collegeName;
    }

    public void setCollegeName(String collegeName) {
        this.collegeName = collegeName;
    }

    public String getCondi() {
        return condi;
    }

    public void setCondi(String condi) {
        this.condi = condi;
    }
}
