package com.example.service;
import com.example.entity.Timetable;
import com.example.mapper.TimetableMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

@Service
public class TimetableService {
    @Resource
    private TimetableMapper timetableMapper;

////获取当前登录信息
//    public List<Timetable> getAllTimetables(String currentTeacherId) {
//        return timetableMapper.selectAll(null, null, null, null, null, null, null, null, null, null, currentTeacherId);
//    }

    //    新增
    public void add(Timetable timetable) {
        timetableMapper.insert(timetable);
    }




    //删除
    public void deleteById(Integer id) {
        timetableMapper.deleteById(id);
    }

    //批量删除
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            timetableMapper.deleteById(id);
        }
    }

    //修改
    public void updateById(Timetable timetable) {
        timetableMapper.updateById(timetable);
    }

    //根据ID查询
    public Timetable selectById(Integer id) {
        return timetableMapper.selectById(id);
    }






    //查询所有
    public List<Timetable> selectAll(Timetable timetable){
        return timetableMapper.selectAll(timetable);}
    //分页查询
        public PageInfo<Timetable> selectPage(Timetable timetable, Integer pageNum, Integer pageSize) {
            PageHelper.startPage(pageNum, pageSize);
            List<Timetable> list = timetableMapper.selectAll(timetable);
            return PageInfo.of(list);
        }


}
