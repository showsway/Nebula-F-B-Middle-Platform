package com.sky.mapper;

import com.sky.annotation.AutoFill;
import com.sky.entity.Setmeal;
import com.sky.entity.SetmealDish;
import com.sky.enumeration.OperationType;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface SetmealMapper {

    /**
     * 根据分类id查询套餐的数量
     * @param id
     * @return
     */
    @Select("select count(id) from setmeal where category_id = #{categoryId}")
    Integer countByCategoryId(Long id);

    /**
     * 根据id修改套餐
     * @param setMeal
     * @return
     */
    @AutoFill(value = OperationType.UPDATE)
    void update(Setmeal setMeal);

    /**
     * 新增套餐基本信息，操作setmeal表
     * @param setmeal
     * @return
     */

    @AutoFill(value = OperationType.INSERT)
    void insert(Setmeal setmeal);

    /**
     * 新增套餐和菜品的关联信息，操作setmeal_dish表
     * @param setmealDish
     */
    @Insert("insert into setmeal_dish (setmeal_id, dish_id, name, price, copies) " +
            "values (#{setmealId}, #{dishId}, #{name}, #{price}, #{copies})")
    void insertSetmealDish(SetmealDish setmealDish);
}
