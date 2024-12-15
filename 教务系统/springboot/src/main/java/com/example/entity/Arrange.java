package com.example.entity;

public class Arrange {

    //序号
    private Integer id;
    //课程编号
    private String courseId;
    //课程名称
    private String courseName;
    //教师编号
    private String teacherId;
    //教师姓名
    private String teacherName;

//    获取当前登录教师信息
//    private String currentTeacherId;




    public Arrange() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

//    public String getCurrentTeacherId() {
//        return currentTeacherId;
//    }
//
//    public void setCurrentTeacherId(String currentTeacherId) {
//        this.currentTeacherId = currentTeacherId;
//    }
}
