package com.example.controller;

import com.example.common.Result;
import com.example.entity.Type;
import com.example.service.TypeService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * 分类信息表前端操作接口
 **/
@RestController
@RequestMapping("/type")
public class TypeController {

    @Resource
    private TypeService typeService;


    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Type type ) {
        List<Type> list = typeService.selectAll(type);
        return Result.success(list);
    }



}