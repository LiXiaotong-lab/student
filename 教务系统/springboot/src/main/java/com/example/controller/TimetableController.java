package com.example.controller;

import com.example.common.Result;
import com.example.entity.Account;
import com.example.entity.Timetable;
import com.example.service.TimetableService;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/timetable")
public class TimetableController {
    @Resource
    private TimetableService timetableService;


    //    增加
    @PostMapping("/add")
    public Result add(@RequestBody Timetable timetable) {
        timetableService.add(timetable);
        return Result.success();
    }









    //    删除
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        timetableService.deleteById(id);
        return Result.success();
    }
    
    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        timetableService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Timetable timetable) {
        timetableService.updateById(timetable);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Timetable timetable = timetableService.selectById(id);
        return Result.success(timetable);
    }

    //查询所有
    @GetMapping("/selectAll")
    public Result SelectAll(Timetable timetable){
        List<Timetable> list=timetableService.selectAll(timetable);
        return Result.success(list);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(Timetable timetable,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Timetable> page = timetableService.selectPage(timetable, pageNum, pageSize);
        return Result.success(page);
    }
}
