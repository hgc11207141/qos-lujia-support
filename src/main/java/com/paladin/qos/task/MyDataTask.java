package com.paladin.qos.task;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.paladin.data.dynamic.SqlSessionContainer;
import com.paladin.framework.utils.time.DateFormatUtil;
import com.paladin.qos.analysis.DataConstantContainer;
import com.paladin.qos.core.DataTask;
import com.paladin.qos.core.DataTaskConfiguration;
import com.paladin.qos.core.view.DataViewCreateTask;
import com.paladin.qos.core.view.DataViewCreator;
import com.paladin.qos.dynamic.DSConstant;
import com.paladin.qos.dynamic.mapper.core.DataViewCreateMapper;
import com.paladin.qos.dynamic.mapper.gongwei.PublicHealthManagementMapper;
import com.paladin.qos.model.data.DataUnit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.thymeleaf.util.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;


/**
 * @author TontoZhou
 * @since 2020/4/7
 */
@Component
public class MyDataTask extends DataTask {

    private static Logger logger = LoggerFactory.getLogger(DataViewCreateTask.class);

    private Date updateTime;
    private boolean success;

    private ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    private SqlSessionContainer sqlSessionContainer;

    public MyDataTask() {
        super("archives_update_task");
        DataTaskConfiguration config =  new DataTaskConfiguration();
        config.setEnabled(1);
        config.setExecuteHours(5);
        config.setRealTimeEnabled(0);
        config.setScheduleHour(5);
        config.setScheduleStrategy(DataTaskConfiguration.SCHEDULE_STRATEGY_EVERY_DAY);

        this.setConfiguration(config);
        List<Object> labels = new ArrayList<>();
        labels.add("我的任务");
        this.setLabels(labels);
    }

    @Override
    public void doTask() {
        List<DataUnit> units = DataConstantContainer.getCommunityList();
        long number =0;
        Map<String, Object> view=new HashMap();
        for (DataUnit unit:units){
            number=getNumber(unit.getId());
            view.put(unit.getId(),number);
        }

        try {
            String result=objectMapper.writeValueAsString(view);
            sqlSessionContainer.setCurrentDataSource(DSConstant.DS_LOCAL);
            DataViewCreateMapper mapper = sqlSessionContainer.getSqlSessionTemplate().getMapper(DataViewCreateMapper.class);
            if (mapper.updateViewData("archives_update_task", result) <= 0) {
                success=mapper.insertViewData("archives_update_task", result) > 0;
                updateTime = new Date();
                logger.info("更新视图[archives_update_task]" + (success ? "成功" : "失败"));
            }
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }


    }

    @Override
    public String getExecuteSituation() {
        if (success) {
            String time = DateFormatUtil.getThreadSafeFormat("yyyy-MM-dd HH:mm:ss").format(updateTime);
            return "在" + time + "更新视图成功";
        } else {
            if (updateTime != null) {
                String time = DateFormatUtil.getThreadSafeFormat("yyyy-MM-dd HH:mm:ss").format(updateTime);
                return "在" + time + "更新视图失败";
            } else {
                return "还未执行";
            }
        }
    }

    private  long getNumber(String unitId){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate=null;
        try {
            startDate = format.parse("2017-01-01");
        } catch (ParseException e) {

        }
        String gongWeiUnitId = getMappingUnitId(unitId);
        if (StringUtils.isEmpty(gongWeiUnitId)) {
            return 0;
        }
        sqlSessionContainer.setCurrentDataSource(DSConstant.DS_GONGWEI);
        List<String> checkoutList= sqlSessionContainer.getSqlSessionTemplate().getMapper(PublicHealthManagementMapper.class).getCheckupRenewArchives(startDate, null, gongWeiUnitId);

        logger.info("体检"+checkoutList.size()+"个");
        sqlSessionContainer.setCurrentDataSource(DSConstant.DS_JCYL);
        List<String>  treatList = sqlSessionContainer.getSqlSessionTemplate().getMapper(PublicHealthManagementMapper.class).getTreatRenewArchives(startDate,
                null, unitId);
        logger.info("看病"+treatList.size()+"个");
        List<String> result = Stream.of(checkoutList, treatList)
                .flatMap(Collection::stream)
                .distinct()
                .collect(Collectors.toList());
        logger.info("结果"+result.size()+"个");
        return result.size();
    }

    private String getMappingUnitId(String unitId) {
        DataUnit unit = DataConstantContainer.getUnit(unitId);
        return unit == null ? null : unit.getGongweiCode();
    }
}
