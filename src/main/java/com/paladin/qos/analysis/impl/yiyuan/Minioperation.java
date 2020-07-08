package com.paladin.qos.analysis.impl.yiyuan;

import com.paladin.data.dynamic.SqlSessionContainer;
import com.paladin.qos.dynamic.mapper.yiyuan.HospitalPerformanceAppraisalMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * <微创手术>
 *
 */
@Component
public class Minioperation extends YiyuanDataProcessor{
    @Autowired
    private SqlSessionContainer sqlSessionContainer;

    public static final String EVENT_ID = "70015";

    @Override
    public String getEventId() {
        return EVENT_ID;
    }

    @Override
    public long getTotalNum(Date startTime, Date endTime, String unitId) {
        sqlSessionContainer.setCurrentDataSource(getDataSourceByUnit(unitId));
        return sqlSessionContainer.getSqlSessionTemplate().getMapper(HospitalPerformanceAppraisalMapper.class).getMinioperationTotalNum(startTime,endTime,unitId);
    }

    @Override
    public long getEventNum(Date startTime, Date endTime, String unitId) {
        return 0;
    }
}
