package com.paladin.qos.analysis.impl.yiyuan.opd;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.paladin.data.dynamic.SqlSessionContainer;
import com.paladin.qos.analysis.impl.yiyuan.YiyuanDataProcessor;
import com.paladin.qos.dynamic.mapper.yiyuan.opd.OpdStatisticsMapper;

/**
 * 门急诊使用药品数
 * 
 * @author MyKite
 * @version 2019年9月17日 上午10:39:21
 */
@Component
public class OPDDrugTotal extends YiyuanDataProcessor {

	@Autowired
	private SqlSessionContainer sqlSessionContainer;

	public static final String EVENT_ID = "31003";

	@Override
	public String getEventId() {
		return EVENT_ID;
	}

	@Override
	public long getTotalNum(Date startTime, Date endTime, String unitId) {
		sqlSessionContainer.setCurrentDataSource(getDataSourceByUnit(unitId));
		int xy = sqlSessionContainer.getSqlSessionTemplate().getMapper(OpdStatisticsMapper.class).OPDDrugxyTotal(startTime, endTime, unitId);
		int zy = sqlSessionContainer.getSqlSessionTemplate().getMapper(OpdStatisticsMapper.class).OPDDrugzyTotal(startTime, endTime, unitId);
		int total = xy + zy;
		return total;
	}

	@Override
	public long getEventNum(Date startTime, Date endTime, String unitId) {
		return 0;
	}
}
