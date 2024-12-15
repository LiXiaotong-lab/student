package com.example.mapper;

import com.example.entity.Live;

import java.util.List;

public interface LiveMapper {

    //新增
    int insert(Live live);

    /**
     * 删除
     */
    int deleteById(Integer id);

    /**
     * 修改
     */
    int updateById(Live live);

    /**
     * 根据ID查询
     */
    Live selectById(Integer id);


//查询所有
    List<Live> selectAll(Live live);
}
