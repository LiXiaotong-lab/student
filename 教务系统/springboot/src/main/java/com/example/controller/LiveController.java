package com.example.controller;

import com.example.common.Result;
import com.example.entity.Live;
import com.example.service.LiveService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/live")
public class LiveController {
    @Resource
    private LiveService liveService;
    //新增
    @PostMapping("/add")
    public Result add(@RequestBody Live live) {
        liveService.add(live);
        return Result.success();
    }
    //    删除
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        liveService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        liveService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Live live) {
        liveService.updateById(live);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Live live = liveService.selectById(id);
        return Result.success(live);
    }


    //查询所有
    @GetMapping("/selectAll")
    public Result SelectAll(Live live){
        List<Live> list=liveService.selectAll(live);
        return Result.success(list);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(Live live,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Live> page = liveService.selectPage(live, pageNum, pageSize);
        return Result.success(page);
    }


}
