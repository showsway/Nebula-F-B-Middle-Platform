package com.sky.service.impl;


import com.sky.context.BaseContext;
import com.sky.dto.ShoppingCartDTO;
import com.sky.entity.Dish;
import com.sky.entity.Setmeal;
import com.sky.entity.ShoppingCart;
import com.sky.mapper.DishMapper;
import com.sky.mapper.SetmealMapper;
import com.sky.mapper.ShoppingCartMapper;
import com.sky.service.ShoppingCartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Service
public class ShoppingCartServiceImpl implements ShoppingCartService {
    @Autowired
    private ShoppingCartMapper shoppingCartMapper;
    @Autowired
    private DishMapper dishMapper;
    @Autowired
    private SetmealMapper setmealMapper;

    /**
     * 添加购物车
     * @param shoppingCartDTO
     */
    @Override
    public void add(ShoppingCartDTO shoppingCartDTO) {
        //根据用户id查询购物车数据
        ShoppingCart shoppingCart=new ShoppingCart();
        BeanUtils.copyProperties(shoppingCartDTO,shoppingCart);
        shoppingCart.setUserId(BaseContext.getCurrentId());
        List<ShoppingCart> list = shoppingCartMapper.list(shoppingCart);
        //判断当前加入到购物车中的商品是否已经存在
        //如果已经存在，就在原来数量基础上加一
        if(list!=null&&list.size()>0){
            //当前商品已经存在，在原来数量基础上加一
            list.get(0).setNumber(list.get(0).getNumber()+1);
            shoppingCartMapper.updateNumberById(list.get(0));
        }
        else {
            //当前商品不存在，添加到购物车中，数量默认是一
            shoppingCart.setNumber(1);
            shoppingCart.setCreateTime(LocalDateTime.now());
            //判断当前加入到购物车中的商品是否是套餐
            if(shoppingCartDTO.getSetmealId()!=null){
                //是套餐
                Setmeal setmeal = setmealMapper.getById(shoppingCartDTO.getSetmealId());
                shoppingCart.setImage(setmeal.getImage());
                shoppingCart.setName(setmeal.getName());
                shoppingCart.setAmount(setmeal.getPrice());
            }
            else {
                //是菜品
                Dish dish = dishMapper.getById(shoppingCartDTO.getDishId());
                shoppingCart.setImage(dish.getImage());
                shoppingCart.setName(dish.getName());
                shoppingCart.setAmount(dish.getPrice());
            }
            shoppingCartMapper.insert(shoppingCart);
        }


    }

    /**
     * 查看购物车
     * @return
     */
    @Override
    public List<ShoppingCart> showShopingCart() {
        Long userid = BaseContext.getCurrentId();
        ShoppingCart shoppingCart=ShoppingCart.builder()
                .userId(userid)
                .build();
        List<ShoppingCart> list = shoppingCartMapper.list(shoppingCart);
        return list;
    }
}
