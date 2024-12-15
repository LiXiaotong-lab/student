package com.example.service;

import com.example.entity.Live;
import com.example.mapper.LiveMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

//直播业务处理
@Service
public class LiveService {

    @Resource
    private LiveMapper liveMapper;

//    新增
    public void add(Live live) {
        liveMapper.insert(live);
    }

    //删除
    public void deleteById(Integer id) {
        liveMapper.deleteById(id);
    }

    //批量删除
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            liveMapper.deleteById(id);
        }
    }

    //修改
    public void updateById(Live live) {
        liveMapper.updateById(live);
    }

    //根据ID查询
    public Live selectById(Integer id) {
        return liveMapper.selectById(id);
    }

    //查询所有
    public List<Live> selectAll(Live live){
        return liveMapper.selectAll(live);
    }


    //分页查询
    public PageInfo<Live> selectPage(Live live, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Live> list = liveMapper.selectAll(live);
        return PageInfo.of(list);
    }
}
