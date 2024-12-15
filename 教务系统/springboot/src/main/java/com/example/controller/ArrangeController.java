package com.example.controller;


import com.example.common.Result;
import com.example.entity.Account;
import com.example.entity.Arrange;
import com.example.entity.Timetable;
import com.example.service.ArrangeService;
import com.example.service.TimetableService;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/arrange")
public class ArrangeController {

    @Resource
    private ArrangeService arrangeService;
    @Resource
    private TimetableService timetableService;


//    @GetMapping("/arrangements")
//    public List<Arrange> getArrangements(@RequestParam String currentTeacherId) {
//        return arrangeService.getAllArrangements(currentTeacherId);
//    }


    //    增加
    @PostMapping("/add")
    public Result add(@RequestBody Arrange arrange) {
        arrangeService.add(arrange);
        return Result.success();
    }

    //   、、、、、、、、、、、 选课
    @PostMapping("/choose/{id}")
    public Result chooseById(@PathVariable Integer id) {
        arrangeService.chooseById(id);


        Account account = TokenUtils.getCurrentUser();
        String username=account.getUsername();
        String name=account.getName();

        Timetable timetable=new Timetable();

        timetable.setStudentId(username);
        timetable.setStudentName(name);
        Arrange arrange= arrangeService.selectById(id);
        timetable.setCourseId(arrange.getCourseId());
        timetable.setCourseName(arrange.getCourseName());
        timetable.setTeacherId(arrange.getTeacherId());
        timetable.setTeacherName(arrange.getTeacherName());
        timetableService.add(timetable);

        return Result.success();
    }




    //    删除
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        arrangeService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        arrangeService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Arrange arrange) {
        arrangeService.updateById(arrange);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Arrange arrange = arrangeService.selectById(id);
        return Result.success(arrange);
    }

    //查询所有
    @GetMapping("/selectAll")
    public Result SelectAll(Arrange arrange){
        List<Arrange> list=arrangeService.selectAll(arrange);
        return Result.success(list);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(Arrange arrange,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Arrange> page = arrangeService.selectPage(arrange, pageNum, pageSize);
        return Result.success(page);
    }








}
