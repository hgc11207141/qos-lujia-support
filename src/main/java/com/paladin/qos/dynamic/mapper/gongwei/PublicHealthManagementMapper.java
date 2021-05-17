package com.paladin.qos.dynamic.mapper.gongwei;

import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface PublicHealthManagementMapper {

    //2021新建档案数
    Long getNewArchives(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    //活动档案数
    Long getActiveArchives(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    //审核公开的健康档案数
    Long getPublicArchives(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    //档案更新率-1-看病档案更新数
    public List<String> getTreatRenewArchives(@Param("startDate") Date startTime, @Param("endDate") Date endTime,@Param("unitId") String unitId);

    //档案更新率-2-体检随访档案更新数
    public List<String> getCheckupRenewArchives(@Param("startDate") Date startTime, @Param("endDate") Date endTime,@Param("unitId") String unitId);

    //老年人体检数
    Long getPhysicalNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    //同辖区老人人数
    Long getOldPeopleNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    //有完整年度体检的老年人数
    Long getOldPeopleManageNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    //高血压人数
    Long getPressureNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    //高血压管理规范管理数
   Long getPressureManageNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    //高血压管理随访数
    Long getPressureFollowNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate,  @Param("unitId") String unitId);

    //高血压管理待随访数
    Long getPressureWaitFollowNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate,  @Param("unitId") String unitId);

    //高血压体检数
    Long getPressureCheckNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate,  @Param("unitId") String unitId);

    //糖尿病患病数
    Long getSugarNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    //糖尿病管理规范管理数
    Long getSugarManageNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    //糖尿病管理随访数
    Long getSugarFollowNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    //糖尿病管理待随访数
    Long getSugarWaitFollowNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    Long getSugarCheckNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    //辖区内对65岁以上老年人规范进行中医体质辨识和中医保健指导人数
    Long getGuideNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

    //特殊人群人数
    Long getSpecialPeopleNumber(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("unitId") String unitId);

}
