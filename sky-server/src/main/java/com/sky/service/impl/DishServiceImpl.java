package com.sky.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sky.dto.DishDTO;
import com.sky.dto.DishPageQueryDTO;
import com.sky.entity.Dish;
import com.sky.entity.DishFlavor;
import com.sky.mapper.DishFlavorMapper;
import com.sky.mapper.DishMapper;
import com.sky.result.PageResult;
import com.sky.service.DishService;
import com.sky.vo.DishVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;



@Service
public class DishServiceImpl implements DishService {
    @Autowired
    private DishMapper dishMapper;
    @Autowired
    private DishFlavorMapper dishFlavorMapper;
    /**
     * 新增菜品
     *
     * @param dishDTO
     * @return
     */
    @Override
    public void saveWithFlavor(DishDTO dishDTO) {
        // 保存菜品的基本信息到菜品表dish
        // 保存菜品对应的口味数据到口味表dish_flavor
        // 注意：在保存菜品对应的口味数据到口味表dish_flavor时，需要为每条口味数据指定菜品id
        // 即：dish_flavor表中的dish_id字段
        // 可以通过菜品id来关联菜品和对应的口味数据
        Dish dish=new Dish();
        BeanUtils.copyProperties(dishDTO,dish);
        dishMapper.insert(dish);
        List<DishFlavor> flavors = dishDTO.getFlavors();
        //获取insert语句生成的主键值
        Long id = dish.getId();
        if (flavors != null && flavors.size() > 0) {
            flavors.forEach(flavor -> {
                flavor.setDishId(id);
            });
            //向口味表插入数据
            dishFlavorMapper.insertFlavor(flavors);
        }

    }
    /*
       分页查询菜品
       @param dishPageQueryDTO
       @return  PageResult
     */
    @Override
    public PageResult pageQuery(DishPageQueryDTO dishPageQueryDTO) {
        PageHelper.startPage(dishPageQueryDTO.getPage(), dishPageQueryDTO.getPageSize());
        Page<DishVO> page = dishMapper.pageQuery(dishPageQueryDTO);
        return new PageResult(page.getTotal(), page.getResult());
    }
}
