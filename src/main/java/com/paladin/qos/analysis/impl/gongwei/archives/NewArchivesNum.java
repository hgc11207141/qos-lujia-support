package com.paladin.qos.analysis.impl.gongwei.archives;

import com.paladin.data.dynamic.SqlSessionContainer;
import com.paladin.qos.analysis.impl.gongwei.GongWeiDataProcessor;
import com.paladin.qos.dynamic.DSConstant;
import com.paladin.qos.dynamic.mapper.gongwei.PublicHealthManagementMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.thymeleaf.util.StringUtils;

import java.util.Date;

/**
 * <2021新建档案数>
 *
 * @author Huangguochen
 * @create 2021/5/17 13:38
 */
@Component
public class NewArchivesNum extends GongWeiDataProcessor {
    @Autowired
    private SqlSessionContainer sqlSessionContainer;

    public static final String EVENT_ID = "22021";

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
        return sqlSessionContainer.getSqlSessionTemplate().getMapper(PublicHealthManagementMapper.class).getNewArchives(startTime, endTime, gongWeiUnitId);
    }

    @Override
    public long getEventNum(Date startTime, Date endTime, String unitId) {
        return 0;
    }
}
