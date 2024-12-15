package com.example.entity;

public class Timetable {
    //序号
    private Integer id;
    //学生学号
    private String studentId;
    //课程号
    private String courseId;
    //教师编号
    private String teacherId;
    //上课时间
    private String time;
    //教室地点
    private String room;
    //考试时间
    private String testtime;
    //考试地点
    private String testroom;
    //课程得分
    private Double score;
    //教师评分
    private Double evaluate;

    private String studentName;
    private String courseName;
    private String teacherName;

    //    获取当前登录教师信息
//    private String currentTeacherId;
    // 获取当前登录学生信息
//    private String currentStudentId;


    public Timetable() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public String getTesttime() {
        return testtime;
    }

    public void setTesttime(String testtime) {
        this.testtime = testtime;
    }

    public String getTestroom() {
        return testroom;
    }

    public void setTestroom(String testroom) {
        this.testroom = testroom;
    }

    public Double getEvaluate() {
        return evaluate;
    }

    public void setEvaluate(Double evaluate) {
        this.evaluate = evaluate;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
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

//    public String getCurrentStudentId() {
//        return currentStudentId;
//    }
//
//    public void setCurrentStudentId(String currentStudentId) {
//        this.currentStudentId = currentStudentId;
//    }


}
