package com.paladin.qos.task;

import com.paladin.qos.core.DataTask;
import com.paladin.qos.core.DataTaskConfiguration;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;


/**
 * @author TontoZhou
 * @since 2020/4/7
 */
@Component
public class MyDataTask extends DataTask {

    public MyDataTask() {
        super("my_data_task");
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
        System.out.println("这是一个数据任务");
    }

    @Override
    public String getExecuteSituation() {
        return null;
    }
}
