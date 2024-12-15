package com.example.service;

import com.example.entity.Major;
import com.example.mapper.MajorMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MajorService {

    @Resource
    private MajorMapper majorMapper;


    //    新增
    public void add(Major major) {
        majorMapper.insert(major);
    }





    //删除
    public void deleteById(Integer id) {
        majorMapper.deleteById(id);
    }

    //批量删除
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            majorMapper.deleteById(id);
        }
    }

    //修改
    public void updateById(Major major) {
        majorMapper.updateById(major);
    }

    //根据ID查询
    public Major selectById(Integer id) {
        return majorMapper.selectById(id);
    }




    //查询所有
    public List<Major>selectAll(Major major){
        return majorMapper.selectAll(major);
    }

    //分页查询
    public PageInfo<Major> selectPage(Major major, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Major> list = majorMapper.selectAll(major);
        return PageInfo.of(list);
    }


}
