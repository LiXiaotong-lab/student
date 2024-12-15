package com.example.service;

import com.example.entity.Type;
import com.example.mapper.TypeMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 分类信息表业务处理
 **/
@Service
public class TypeService {

    @Resource
    private TypeMapper typeMapper;

    /**
     * 查询所有
     */
    public List<Type> selectAll(Type type) {
        return typeMapper.selectAll(type);
    }



}