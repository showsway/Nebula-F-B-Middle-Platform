package com.sky.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sky.constant.MessageConstant;
import com.sky.dto.SetmealDTO;
import com.sky.dto.SetmealPageQueryDTO;
import com.sky.entity.Dish;
import com.sky.entity.Setmeal;
import com.sky.entity.SetmealDish;
import com.sky.exception.DeletionNotAllowedException;
import com.sky.mapper.DishMapper;
import com.sky.mapper.SetmealDishMapper;
import com.sky.mapper.SetmealMapper;
import com.sky.result.PageResult;
import com.sky.service.SetmealService;
import com.sky.vo.SetmealVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Slf4j
public class SetmealServiceImpl implements SetmealService {
    @Autowired
    private SetmealMapper setmealMapper;
    @Autowired
    private SetmealDishMapper setmealDishMapper;
    @Autowired
    private DishMapper dishMapper;

    /**
     * 新增套餐，同时需要保存套餐和菜品的关联关系
     *
     * @param setmealDTO
     */
    @Transactional
    @Override
    public void saveWithDish(SetmealDTO setmealDTO) {
        Setmeal setmeal = new Setmeal();
        BeanUtils.copyProperties(setmealDTO, setmeal);
        log.info("新增套餐：{}", setmeal);
        //保存套餐的基本信息，操作setmeal表
        setmealMapper.insert(setmeal);
        //保存套餐和菜品的关联信息，操作setmeal_dish表
        //套餐id是自增主键，是在新增套餐时自动添加的，所以需要在新增套餐的同时才能获取到套餐id
        List<SetmealDish> setmealDishes = setmealDTO.getSetmealDishes();
        if (setmealDishes != null && setmealDishes.size() > 0) {
            setmealDishes.forEach(setmealDish -> {
                setmealDish.setSetmealId(setmeal.getId());
                log.info("新增套餐和菜品的关联信息：{}", setmealDish);
                setmealMapper.insertSetmealDish(setmealDish);
            });
        }
    }

    /**
     * 套餐分页查询
     *
     * @param setmealPageQueryDTO
     * @return
     */
    @Override
    public PageResult pageQuery(SetmealPageQueryDTO setmealPageQueryDTO) {
        PageHelper.startPage(setmealPageQueryDTO.getPage(), setmealPageQueryDTO.getPageSize());
        Page<SetmealVO> page = setmealMapper.pageQuery(setmealPageQueryDTO);
        return new PageResult(page.getTotal(), page.getResult());

    }

    /**
     * 批量删除套餐
     *
     * @param ids
     */
    @Override
    public void deleteBatch(List<Long> ids) {
        //判断当前套餐是否能够删除--是否存在起售中的套餐
        for (Long id : ids) {
            Setmeal setmeal = setmealMapper.getById(id);
            if (setmeal.getStatus() == 1) {
                //当前套餐处于起售状态，不能删除
                throw new DeletionNotAllowedException(MessageConstant.SETMEAL_ON_SALE);
            }
        }
        //当前套餐可以删除，先删除套餐表中的数据---setmeal
        for (Long id : ids) {
            setmealMapper.deleteById(id);
            //删除关系表中的数据---setmeal_dish
            setmealDishMapper.deleteBySetmealId(id);
        }
    }

    /**
     * 根据id查询套餐以及关联的菜品
     *
     * @param id
     * @return
     */
    @Transactional
    @Override
    public SetmealVO getWithDishById(Long id) {
        Setmeal setmeal = setmealMapper.getById(id);
        List<SetmealDish> setmealDishes = setmealDishMapper.getBySetmealId(id);
        SetmealVO setmealVO = new SetmealVO();
        BeanUtils.copyProperties(setmeal, setmealVO);
        setmealVO.setSetmealDishes(setmealDishes);
        return setmealVO;
    }

    /**
     * 修改套餐
     *
     * @param setmealDTO
     */
    @Transactional
    @Override
    public void updateWithDish(SetmealDTO setmealDTO) {
        //修改套餐表中的数据
        Setmeal setmeal = new Setmeal();
        BeanUtils.copyProperties(setmealDTO, setmeal);
        setmealMapper.update(setmeal);
        //删除关系表中的数据
        setmealDishMapper.deleteBySetmealId(setmeal.getId());
        //重新插入关系表中的数据
        List<SetmealDish> setmealDishes = setmealDTO.getSetmealDishes();
        if (setmealDishes != null && setmealDishes.size() > 0) {
            setmealDishes.forEach(setmealDish -> {
                setmealDish.setSetmealId(setmeal.getId());
                setmealMapper.insertSetmealDish(setmealDish);
            });
        }

    }

    /**
     * 套餐起售停售
     *
     * @param status
     * @param id
     */

    @Override
    public void startOrStop(Integer status, Long id) {
        //查询菜品是否存在停售中的菜品
        if (status == 1) {
            //起售
            //查询套餐是否存在起售中的菜品
/*            List<SetmealDish> setmealDishs = setmealDishMapper.getBySetmealId(id);
            if (setmealDishs != null && setmealDishs.size() > 0) {
               *//* List<Long> dishIds = setmealDish.stream().map(SetmealDishs::getDishId).toList();
                //查询菜品是否存在停售中的菜品
                dishIds.forEach(dishId -> {
                    Dish dish = dishMapper.getById(dishId);
                    if (dish.getStatus() == 0) {
                        //当前菜品处于停售状态，不能起售
                        throw new DeletionNotAllowedException(MessageConstant.DISH_ON_SALE);
                    }
                });*//*
                setmealDishs.forEach(setmealDish -> {
                    Dish dish = dishMapper.getById(setmealDish.getDishId());
                    if (dish.getStatus() == 0) {
                        //当前套餐存在菜品处于停售状态，不能起售
                        throw new DeletionNotAllowedException(MessageConstant.SETMEAL_ENABLE_FAILED);
                    }
                });
            }*/
            List<Dish> dishs = dishMapper.getBySetmealId(id);
            if (dishs != null && dishs.size() > 0) {
                dishs.forEach(dish -> {
                    if (dish.getStatus() == 0) {
                        //当前套餐存在菜品处于停售状态，不能起售
                        throw new DeletionNotAllowedException(MessageConstant.SETMEAL_ENABLE_FAILED);
                    }
                });
            }
        }
        //更新套餐
        Setmeal setmeal = Setmeal.builder()
                .id(id)
                .status(status)
                .build();
        setmealMapper.update(setmeal);
    }
}
