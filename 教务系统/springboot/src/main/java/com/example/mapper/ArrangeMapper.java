package com.example.mapper;

import com.example.entity.Arrange;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ArrangeMapper {

    //获取当前登录教师信息
//    List<Arrange> selectAll(@Param("id") Integer id,
//                            @Param("courseId") String courseId,
//                            @Param("teacherId") String teacherId,
//                            @Param("currentTeacherId") String currentTeacherId);
    //新增
    int insert(Arrange arrange);
    //选课
    int chooseById(Integer id);

    /**
     * 删除
     */
    int deleteById(Integer id);

    /**
     * 修改
     */
    int updateById(Arrange arrange);

    /**
     * 根据ID查询
     */
    Arrange selectById(Integer id);


    //查询所有
    List<Arrange> selectAll(Arrange arrange);
}
