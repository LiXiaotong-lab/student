package com.example.controller;

import com.example.common.Result;
import com.example.entity.Video;
import com.example.service.VideoService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/video")
public class VideoController {

    @Resource
    private VideoService videoService;


    //    增加
    @PostMapping("/add")
    public Result add(@RequestBody Video video) {
        videoService.add(video);
        return Result.success();
    }
    //    删除
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        videoService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        videoService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Video video) {
        videoService.updateById(video);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Video video = videoService.selectById(id);
        return Result.success(video);
    }


    //    查询所有
    @GetMapping("/selectAll")
     public Result selectAll(Video video){
    List<Video> list = videoService.selectAll(video);
    return Result.success(list);
     }
//     分页查询
    @GetMapping("/selectPage")
    public Result selectPage(Video video,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Video> page = videoService.selectPage(video, pageNum, pageSize);
        return Result.success(page);
    }
}

