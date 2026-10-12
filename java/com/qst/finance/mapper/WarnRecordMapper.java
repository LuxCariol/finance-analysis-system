package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.qst.finance.model.WarnRecord;

/**
 * 预警结果 Mapper (t_warn_record)
 */
public interface WarnRecordMapper {

    int insertBatch(@Param("list") List<WarnRecord> list);

    @Delete("DELETE FROM t_warn_record WHERE org_id = #{orgId} AND kjyear_month = #{kjyearMonth}")
    int deleteByMonth(@Param("orgId") Long orgId, @Param("kjyearMonth") String kjyearMonth);

    @Select("SELECT * FROM t_warn_record WHERE org_id = #{orgId} AND kjyear_month = #{kjyearMonth} ORDER BY warn_level DESC, id")
    List<WarnRecord> selectByMonth(@Param("orgId") Long orgId, @Param("kjyearMonth") String kjyearMonth);
}
