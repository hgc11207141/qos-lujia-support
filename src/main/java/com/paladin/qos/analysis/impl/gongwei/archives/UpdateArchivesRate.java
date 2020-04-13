package com.paladin.qos.analysis.impl.gongwei.archives;

import com.paladin.data.dynamic.SqlSessionContainer;
import com.paladin.qos.analysis.impl.gongwei.GongWeiDataProcessor;
import com.paladin.qos.core.migration.CommonIncrementDataMigrator;
import com.paladin.qos.dynamic.DSConstant;
import com.paladin.qos.dynamic.mapper.familydoctor.DataFamilyDoctorMapper;
import com.paladin.qos.dynamic.mapper.gongwei.PublicHealthManagementMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.thymeleaf.util.StringUtils;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * 居民健康档案建档率
 *
 * @author wcw
 */
@Component
public class UpdateArchivesRate extends GongWeiDataProcessor {

    @Autowired
    private SqlSessionContainer sqlSessionContainer;

    public static final String EVENT_ID = "22020";
	private static Logger logger = LoggerFactory.getLogger(CommonIncrementDataMigrator.class);
    @Override
    public String getEventId() {
        return EVENT_ID;
    }

    @Override
    public long getTotalNum(Date startTime, Date endTime, String unitId) {
        return 0;
    }

    @Override
    public long getEventNum(Date startTime, Date endTime, String unitId) {
        String gongWeiUnitId = getMappingUnitId(unitId);
        if (StringUtils.isEmpty(gongWeiUnitId)) {
            return 0;
        }
        sqlSessionContainer.setCurrentDataSource(DSConstant.DS_GONGWEI);
        List<String> checkoutList= sqlSessionContainer.getSqlSessionTemplate().getMapper(PublicHealthManagementMapper.class).getCheckupRenewArchives(startTime, endTime, gongWeiUnitId);

			logger.info("体检"+checkoutList.size()+"个");
		sqlSessionContainer.setCurrentDataSource(DSConstant.DS_JCYL);
		List<String>  treatList = sqlSessionContainer.getSqlSessionTemplate().getMapper(PublicHealthManagementMapper.class).getTreatRenewArchives(startTime,
				endTime, unitId);
		logger.info("看病"+treatList.size()+"个");
		List<String> result = Stream.of(checkoutList, treatList)
				.flatMap(Collection::stream)
				.distinct()
				.collect(Collectors.toList());
		logger.info("结果"+result.size()+"个");
		return result.size();
    }
}
