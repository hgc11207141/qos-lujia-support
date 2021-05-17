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
 * <貧困人群簽約率>
 *
 * @author Huangguochen
 * @create 2021/5/17 11:05
 */
@Component
public class FamilyPoorSigningRate extends GongWeiDataProcessor {
    @Autowired
    private SqlSessionContainer sqlSessionContainer;

    public static final String EVENT_ID = "21031";

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
        return sqlSessionContainer.getSqlSessionTemplate().getMapper(DataFamilyDoctorMapper.class).poorCadRate(startTime, endTime, unit);
    }
}
