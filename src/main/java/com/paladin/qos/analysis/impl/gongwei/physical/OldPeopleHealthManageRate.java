package com.paladin.qos.analysis.impl.gongwei.physical;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.thymeleaf.util.StringUtils;

import com.paladin.data.dynamic.SqlSessionContainer;
import com.paladin.qos.analysis.impl.gongwei.GongWeiDataProcessor;
import com.paladin.qos.dynamic.DSConstant;
import com.paladin.qos.dynamic.mapper.gongwei.PublicHealthManagementMapper;

/**
 * 老年人健康管理率
 * 
 * @author wcw
 *
 */
@Deprecated
public class OldPeopleHealthManageRate extends GongWeiDataProcessor {
	
	@Autowired
	private SqlSessionContainer sqlSessionContainer;

	public static final String EVENT_ID = "22012";

	@Override
	public String getEventId() {
		return EVENT_ID;
	}

	@Override
	public long getTotalNum(Date startTime, Date endTime, String unitId) {
		String gongWeiUnitId = getMappingUnitId(unitId);
		if (StringUtils.isEmpty(gongWeiUnitId)) {
			return 0;
		}
		sqlSessionContainer.setCurrentDataSource(DSConstant.DS_GONGWEI);
		return sqlSessionContainer.getSqlSessionTemplate().getMapper(PublicHealthManagementMapper.class).getOldPeopleNumber(startTime, endTime, gongWeiUnitId);
	}

	@Override
	public long getEventNum(Date startTime, Date endTime, String unitId) {
		String gongWeiUnitId = getMappingUnitId(unitId);
		if (StringUtils.isEmpty(gongWeiUnitId)) {
			return 0;
		}
		sqlSessionContainer.setCurrentDataSource(DSConstant.DS_GONGWEI);
		return sqlSessionContainer.getSqlSessionTemplate().getMapper(PublicHealthManagementMapper.class).getOldPeopleManageNumber(startTime, endTime, gongWeiUnitId);
	}
}
