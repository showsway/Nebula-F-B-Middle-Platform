package com.sky.service.impl;

import com.sky.dto.GoodsSalesDTO;
import com.sky.entity.Orders;
import com.sky.mapper.OrderMapper;
import com.sky.mapper.UserMapper;
import com.sky.service.ReportService;
import com.sky.service.WorkspaceService;
import com.sky.vo.*;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Slf4j
public class ReportServiceImpl implements ReportService {

    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private WorkspaceService workSpaceService;
    /**
     * 获取营业额统计数据
     *
     * @param begin
     * @param end
     * @return
     */
    @Override
    public TurnoverReportVO getTurnoverStatistics(LocalDate begin, LocalDate end) {
        //获取begin到end的所有日期
        List<LocalDate> dateList = getLocalDates(begin, end);

        List<Double> turnoverList = new ArrayList<>();
        for (LocalDate localDate : dateList) {
            //查询localDate日期的营业额，营业额指状态为已完成的订单的订单金额总和
            LocalDateTime beginTime = LocalDateTime.of(localDate, LocalTime.MIN);
            LocalDateTime endTime = LocalDateTime.of(localDate, LocalTime.MAX);
            Map map = new HashMap();
            map.put("begin", beginTime);
            map.put("end", endTime);
            map.put("status", Orders.COMPLETED);
            Double turnover = orderMapper.sumByMap(map);
            turnover = turnover == null ? 0.0 : turnover;
            turnoverList.add(turnover);
        }

        return TurnoverReportVO.builder()
                .dateList(StringUtils.join(dateList, ","))
                .turnoverList(StringUtils.join(turnoverList, ","))
                .build();
    }

    //获取begin到end的所有日期
    private static List<LocalDate> getLocalDates(LocalDate begin, LocalDate end) {
        //当前集合存放begin到end的日期
        List<LocalDate> dateList = new ArrayList<>();
        dateList.add(begin);
        while (!begin.equals(end)) {
            //+1天
            begin = begin.plusDays(1);
            dateList.add(begin);
        }
        return dateList;
    }

    /**
     * 获取用户统计数据
     *
     * @param begin
     * @param end
     * @return
     */
    @Override
    public UserReportVO getUserStatistics(LocalDate begin, LocalDate end) {
        //获取begin到end的所有日期
        List<LocalDate> dateList = getLocalDates(begin, end);
        //用户总量
        List<Integer> totalUserList = new ArrayList<>();
        //新增用户
        List<Integer> newUserList = new ArrayList<>();

        for (LocalDate localDate : dateList) {
            //查询localDate日期的营业额，营业额指状态为已完成的订单的订单金额总和
            LocalDateTime beginTime = LocalDateTime.of(localDate, LocalTime.MIN);
            LocalDateTime endTime = LocalDateTime.of(localDate, LocalTime.MAX);
            Map map = new HashMap();

            map.put("end", endTime);
            Integer totalUser = userMapper.countByMap(map);

            map.put("begin", beginTime);
            Integer newUser = userMapper.countByMap(map);

            totalUserList.add(totalUser);
            newUserList.add(newUser);
        }
        //封装结果数据
        return UserReportVO.builder()
                .dateList(StringUtils.join(dateList, ","))
                .totalUserList(StringUtils.join(totalUserList, ","))
                .newUserList(StringUtils.join(newUserList, ","))
                .build();
    }


    /**
     * 订单统计
     *
     * @param begin
     * @param end
     * @return
     */
    @Override
    public OrderReportVO getOrderStatistics(LocalDate begin, LocalDate end) {
        //当前集合存放begin到end的日期
        List<LocalDate> dateList = getLocalDates(begin, end);
        List<Integer> orderCountList = new ArrayList<>();
        List<Integer> validOrderCountList = new ArrayList<>();
        Integer totalOrderCount = 0;
        Integer totalValidOrderCount = 0;
        for (LocalDate localDate : dateList) {
            //查询localDate日期的营业额，营业额指状态为已完成的订单的订单金额总和
            LocalDateTime beginTime = LocalDateTime.of(localDate, LocalTime.MIN);
            LocalDateTime endTime = LocalDateTime.of(localDate, LocalTime.MAX);
            Map map = new HashMap();

            map.put("end", endTime);
            map.put("begin", beginTime);

            Integer orderCount = orderMapper.countOrdersByMap(map);
            map.put("status", Orders.COMPLETED);
            Integer validOrderCount = orderMapper.countOrdersByMap(map);
            totalOrderCount += orderCount;
            totalValidOrderCount += validOrderCount;
            orderCountList.add(orderCount);
            validOrderCountList.add(validOrderCount);
        }
        Double orderCompletionRate = 0.0;
        if (totalOrderCount != 0) {
            orderCompletionRate = (double) totalValidOrderCount / totalOrderCount;
        }
        //封装结果数据
        return OrderReportVO.builder()
                .dateList(StringUtils.join(dateList, ","))
                .orderCountList(StringUtils.join(orderCountList, ","))
                .validOrderCountList(StringUtils.join(validOrderCountList, ","))
                .totalOrderCount(totalOrderCount)
                .validOrderCount(totalValidOrderCount)
                .orderCompletionRate(orderCompletionRate)
                .build();
    }

    /**
     * 销量排名top10
     *
     * @param begin
     * @param end
     * @return
     */
    @Override
    public SalesTop10ReportVO getSalesTop10(LocalDate begin, LocalDate end) {

        //查询localDate日期的营业额，营业额指状态为已完成的订单的订单金额总和
        LocalDateTime beginTime = LocalDateTime.of(begin, LocalTime.MIN);
        LocalDateTime endTime = LocalDateTime.of(end, LocalTime.MAX);

        List<GoodsSalesDTO> salesTop10 = orderMapper.getSalesTop10(beginTime, endTime);

        List<String> nameList = salesTop10.stream().map(GoodsSalesDTO::getName).collect(Collectors.toList());
        List<Integer> numberList = salesTop10.stream().map(GoodsSalesDTO::getNumber).collect(Collectors.toList());

        return SalesTop10ReportVO.builder()
                .nameList(StringUtils.join(nameList, ","))
                .numberList(StringUtils.join(numberList, ","))
                .build();
    }

    /**
     * 导出运营数据报表
     *
     * @param response
     */
    @Override
    public void exportBusinessData(HttpServletResponse response) {
        //查询数据库获取营业数据
        LocalDate dateBegin = LocalDate.now().minusDays(30);
        LocalDate dateEnd = LocalDate.now().minusDays(1);
        BusinessDataVO businessData = workSpaceService.getBusinessData(LocalDateTime.of(dateBegin, LocalTime.MIN), LocalDateTime.of(dateEnd, LocalTime.MAX));
        //通过POI将查询到的营业数据写入到excel文件中
        InputStream resourceAsStream = this.getClass().getClassLoader().getResourceAsStream("template/运营数据报表模板.xlsx");
        //通过输入流读入模板,创建新的excel文件
        XSSFWorkbook excel = null;
        try {
            excel = new XSSFWorkbook(resourceAsStream);
            //获取sheet页
            XSSFSheet sheet = excel.getSheet("Sheet1");
            //填充数据--时间
            sheet.getRow(1).getCell(1).setCellValue("时间："+dateBegin+"至"+dateEnd);
            //填充数据--营业额
            sheet.getRow(3).getCell(2).setCellValue(businessData.getTurnover());
            //填充数据--订单完成率
            sheet.getRow(3).getCell(4).setCellValue(businessData.getOrderCompletionRate());
            //填充数据--新用户
            sheet.getRow(3).getCell(6).setCellValue(businessData.getNewUsers());
            //填充数据--有效订单
            sheet.getRow(4).getCell(2).setCellValue(businessData.getValidOrderCount());
            //填充数据--订单总数
            sheet.getRow(4).getCell(4).setCellValue(businessData.getUnitPrice());
            XSSFRow row;
            //填充明细数据
            for (int i = 0; i < 30; i++) {
                LocalDate date = dateEnd.plusDays(-i);
                //查询某天营业数据
                BusinessDataVO businessData1 = workSpaceService.getBusinessData(LocalDateTime.of(date, LocalTime.MIN), LocalDateTime.of(date, LocalTime.MAX));
                row= sheet.getRow(7 + i);
                row.getCell(1).setCellValue(date.toString());
                row.getCell(2).setCellValue(businessData1.getTurnover());
                row.getCell(3).setCellValue(businessData1.getValidOrderCount());
                row.getCell(4).setCellValue(businessData1.getOrderCompletionRate());
                row.getCell(5).setCellValue(businessData1.getUnitPrice());
                row.getCell(6).setCellValue(businessData1.getNewUsers());
            }
            //通过输出流将excel文件下载到客户端浏览器
            ServletOutputStream outputStream = response.getOutputStream();
            excel.write(outputStream);
            //关闭资源
            outputStream.close();
            excel.close();
            resourceAsStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
