package com.example.controller;

import com.example.common.Result;
import com.example.entity.Account;
import com.example.entity.Arrange;
import com.example.entity.Course;
import com.example.service.ArrangeService;
import com.example.service.CourseService;
import com.example.service.TimetableService;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;


@RestController
@RequestMapping("/course")
public class CourseController {
    @Resource
    private CourseService courseService;
    @Resource
    private TimetableService timetableService;
    @Autowired
    private ArrangeService arrangeService;


    //    增加
    @PostMapping("/add")
    public Result add(@RequestBody Course course) {
        courseService.add(course);
        return Result.success();
    }


    //   、、、、、、、、、、、 选课
    @PostMapping("/choose/{id}")
    public Result chooseById(@PathVariable Integer id) {
        courseService.chooseById(id);


        Account account = TokenUtils.getCurrentUser();
        String username=account.getUsername();
        String name=account.getName();

        Arrange arrange=new Arrange();

        arrange.setTeacherId(username);
        arrange.setTeacherName(name);
        Course course= courseService.selectById(id);
        arrange.setCourseId(course.getCourseId());
        arrange.setCourseName(course.getName());
        arrangeService.add(arrange);

        return Result.success();
    }

    //    删除
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        courseService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        courseService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Course course) {
        courseService.updateById(course);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Course course = courseService.selectById(id);
        return Result.success(course);
    }


    //查询所有
    @GetMapping("/selectAll")
    public Result selectAll(Course course) {
        List<Course> list= courseService.selectAll(course);
        return Result.success(list);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(Course course,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Course> page = courseService.selectPage(course, pageNum, pageSize);
        return Result.success(page);
    }

}
