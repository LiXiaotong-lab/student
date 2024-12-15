package com.example.service;
import com.example.entity.Arrange;
import com.example.mapper.ArrangeMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;


@Service
public class ArrangeService {


    @Resource
    private ArrangeMapper arrangeMapper;


//获取当前教师信息
//public List<Arrange> getAllArrangements(String currentTeacherId) {
//    return arrangeMapper.selectAll(null, null, null, currentTeacherId);
//}

    //    新增
    public void add(Arrange arrange) {
        arrangeMapper.insert(arrange);
    }


    //选课
    public void chooseById(Integer id) {
        arrangeMapper.chooseById(id);
    }

    //删除
    public void deleteById(Integer id) {
        arrangeMapper.deleteById(id);
    }

    //批量删除
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            arrangeMapper.deleteById(id);
        }
    }

    //修改
    public void updateById(Arrange arrange) {
        arrangeMapper.updateById(arrange);
    }

    //根据ID查询
    public Arrange selectById(Integer id) {
        return arrangeMapper.selectById(id);
    }






    //查询所有
    public List<Arrange> selectAll(Arrange arrange){
        return arrangeMapper.selectAll(arrange);}
    //分页查询
    public PageInfo<Arrange> selectPage(Arrange arrange, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Arrange> list = arrangeMapper.selectAll(arrange);
        return PageInfo.of(list);
    }


}
