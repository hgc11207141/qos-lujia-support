package com.paladin.qos.analysis.impl.gongwei.family;

import com.github.pagehelper.util.StringUtil;
import com.paladin.data.dynamic.SqlSessionContainer;
import com.paladin.qos.analysis.impl.gongwei.GongWeiDataProcessor;
import com.paladin.qos.dynamic.DSConstant;
import com.paladin.qos.dynamic.mapper.familydoctor.DataFamilyDoctorMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 残疾人签约率
 * 
 * @author MyKite
 * @version 2019年9月11日 下午4:12:26
 */
@Component
public class FamilyDisabledSigningRate extends GongWeiDataProcessor {

	@Autowired
	private SqlSessionContainer sqlSessionContainer;

	public static final String EVENT_ID = "21021";

	@Override
	public String getEventId() {
		return EVENT_ID;
	}

	@Override
	public long getTotalNum(Date startTime, Date endTime, String unitId) {
		sqlSessionContainer.setCurrentDataSource(DSConstant.DS_GONGWEI);
		String unit = getMappingUnitId(unitId);
		if (StringUtil.isEmpty(unit)) {
			return 0;
		}
		return sqlSessionContainer.getSqlSessionTemplate().getMapper(DataFamilyDoctorMapper.class).singingServiceTotal(startTime, endTime, unit);
	}

	@Override
	public long getEventNum(Date startTime, Date endTime, String unitId) {
		sqlSessionContainer.setCurrentDataSource(DSConstant.DS_GONGWEI);
		String unit = getMappingUnitId(unitId);
		if (StringUtil.isEmpty(unit)) {
			return 0;
		}
		return sqlSessionContainer.getSqlSessionTemplate().getMapper(DataFamilyDoctorMapper.class).disabledSigningRate(startTime, endTime, unit);
	}
}
