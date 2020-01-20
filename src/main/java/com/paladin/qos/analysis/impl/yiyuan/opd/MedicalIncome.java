package com.paladin.qos.analysis.impl.yiyuan.opd;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.paladin.data.dynamic.SqlSessionContainer;
import com.paladin.qos.analysis.impl.yiyuan.YiyuanDataProcessor;
import com.paladin.qos.dynamic.mapper.yiyuan.opd.OpdStatisticsMapper;

/**医疗收入   
 * @author MyKite
 * @version 2019年9月27日 下午1:47:58 
 */
@Component
public class MedicalIncome extends YiyuanDataProcessor{

	@Autowired
	private SqlSessionContainer sqlSessionContainer;

	public static final String EVENT_ID = "31013";

	@Override
	public String getEventId() {
		return EVENT_ID;
	}

	@Override
	public long getTotalNum(Date startTime, Date endTime, String unitId) {
		sqlSessionContainer.setCurrentDataSource(getDataSourceByUnit(unitId));
		return sqlSessionContainer.getSqlSessionTemplate().getMapper(OpdStatisticsMapper.class).medicalIncome(startTime, endTime);
	}

	@Override
	public long getEventNum(Date startTime, Date endTime, String unitId) {
		return 0;
	}
}
