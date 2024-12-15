package com.example.mapper;

import com.example.entity.Arrange;
import com.example.entity.Timetable;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TimetableMapper {

//    List<Timetable> selectAll(@Param("id") Integer id,
//                              @Param("studentId") String studentId,
//                              @Param("courseId") String courseId,
//                              @Param("teacherId") String teacherId,
//                              @Param("time") String time,
//                              @Param("room") String room,
//                              @Param("testtime") String testtime,
//                              @Param("testroom") String testroom,
//                              @Param("score") Integer score,
//                              @Param("evaluate") String evaluate,
//                              @Param("currentTeacherId") String currentTeacherId);
    /**
     * 新增
     */
    int insert(Timetable timetable);


    /**
     * 删除
     */
    int deleteById(Integer id);

    /**
     * 修改
     */
    int updateById(Timetable timetable);

    /**
     * 根据ID查询
     */
    Timetable selectById(Integer id);

    //查询所有
    List<Timetable> selectAll(Timetable timetable);


}
