package com.example.mapper;

import com.example.entity.Video;
import com.example.entity.Video;

import java.util.List;

public interface VideoMapper {


    int insert(Video video);
    /**
     * 删除
     */
    int deleteById(Integer id);

    /**
     * 修改
     */
    int updateById(Video video);

    /**
     * 根据ID查询
     */
    Video selectById(Integer id);

    List<Video> selectAll(Video video);
}
