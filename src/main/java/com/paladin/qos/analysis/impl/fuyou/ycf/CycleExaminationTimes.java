package com.paladin.qos.analysis.impl.fuyou.ycf;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.paladin.data.dynamic.SqlSessionContainer;
import com.paladin.qos.analysis.impl.fuyou.FuyouDataProcessor;
import com.paladin.qos.dynamic.DSConstant;
import com.paladin.qos.dynamic.mapper.exhibition.MaternalManagementMapper;

/**
 * <孕产妇体检复检>
 *
 * @author Huangguochen
 * @create 2019/9/11 11:14
 */
@Component
public class CycleExaminationTimes extends FuyouDataProcessor {

	@Autowired
	private SqlSessionContainer sqlSessionContainer;

	public static final String EVENT_ID = "13316";

	@Override
	public String getEventId() {
		return EVENT_ID;
	}

	@Override
	public long getTotalNum(Date startTime, Date endTime, String unitId) {
		sqlSessionContainer.setCurrentDataSource(DSConstant.DS_FUYOU);
		return sqlSessionContainer.getSqlSessionTemplate().getMapper(MaternalManagementMapper.class).getCycleExaminationTimesNumber(startTime, endTime, unitId);
	}

	@Override
	public long getEventNum(Date startTime, Date endTime, String unitId) {
		return 0;
	}
}
