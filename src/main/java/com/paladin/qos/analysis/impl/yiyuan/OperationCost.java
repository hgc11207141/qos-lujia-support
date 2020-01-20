package com.paladin.qos.analysis.impl.yiyuan;

import com.paladin.data.dynamic.SqlSessionContainer;
import com.paladin.qos.dynamic.mapper.yiyuan.CostDetailMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 颅、脑手术死亡率
 * 
 * @author FM
 *
 */
@Component
public class OperationCost extends YiyuanDataProcessor {

	@Autowired
	private SqlSessionContainer sqlSessionContainer;

	public static final String EVENT_ID = "42002";

	@Override
	public String getEventId() {
		return EVENT_ID;
	}

	@Override
	public long getTotalNum(Date startTime, Date endTime, String unitId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		sqlSessionContainer.setCurrentDataSource(getDataSourceByUnit(unitId));
		double cost=sqlSessionContainer.getSqlSessionTemplate().getMapper(CostDetailMapper.class).getTotalCost(params)*100;
		return (long)cost;
	}

	@Override
	public long getEventNum(Date startTime, Date endTime, String unitId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		sqlSessionContainer.setCurrentDataSource(getDataSourceByUnit(unitId));
		double cost=sqlSessionContainer.getSqlSessionTemplate().getMapper(CostDetailMapper.class).getOperationCost(params)*100;
		return (long)cost;
	}
}
