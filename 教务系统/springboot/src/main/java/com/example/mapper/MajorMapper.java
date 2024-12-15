package com.example.mapper;


import com.example.entity.Major;

import java.util.List;

public interface MajorMapper {
    //    新增
    int insert(Major major);


    //    删除
    int deleteById(Integer id);
    //    修改
    int updateById(Major major);

    //根据ID查询
    Major selectById(Integer id);
    List<Major> selectAll(Major major);

}
