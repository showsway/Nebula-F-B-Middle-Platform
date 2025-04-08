package com.sky.vo;

import com.sky.entity.OrderDetail;
import com.sky.entity.Orders;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
//这里继承了Orders，所以OrderVO里面就有Orders的属性了
public class OrderVO extends Orders implements Serializable {

    //订单菜品信息

    private String orderDishes;

    //订单详情
    private List<OrderDetail> orderDetailList;

}
