package com.sky.mapper;

import com.sky.entity.DishFlavor;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DishFlavorMapper {

    /**
     * 批量插入菜品口味数据
     * @param flavors
     */
    void insertFlavor(List<DishFlavor> flavors);

    /**
     * 根据菜品id删除对应的口味数据
     * @param ids
     */
    void deleteByDishIds(List<Long> ids);
}
