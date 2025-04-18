package com.sky.controller.user;

import com.sky.constant.StatusConstant;
import com.sky.entity.Dish;
import com.sky.result.Result;
import com.sky.service.DishService;
import com.sky.vo.DishVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController("userDishController")
@RequestMapping("/user/dish")
@Slf4j
public class DishController {
    @Autowired
    private DishService dishService;
    @Autowired
    private RedisTemplate redisTemplate;
    /**
     * 根据分类id查询菜品
     *
     * @param categoryId
     * @return
     */
    @GetMapping("/list")
    public Result<List<DishVO>> list(Long categoryId) {
        //查询redis中是否存在菜品数据
        String key = "dish_" + categoryId;
        List<DishVO> list = (List<DishVO>)redisTemplate.opsForValue().get(key);
        if(list != null&&list.size()>0){
            //如果存在，直接返回，无需查询数据库
            return Result.success(list);
        }

        //如果不存在，查询数据库，将查询到的菜品数据存入redis，并且返回结果
        Dish dish = new Dish();
        dish.setCategoryId(categoryId);
        dish.setStatus(StatusConstant.ENABLE);//查询起售中的菜品
        list = dishService.listWithFlavor(dish);
        //将查询到的菜品数据缓存到redis中
        redisTemplate.opsForValue().set(key,list);

        return Result.success(list);
    }

}
