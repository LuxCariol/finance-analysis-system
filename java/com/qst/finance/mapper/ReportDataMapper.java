package com.qst.finance.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

/**
 * 报表数据查询 Mapper: 账龄分析、科目余额表、数据概况
 */
public interface ReportDataMapper {

    /** 科目余额表(一级/二级科目) */
    List<Map<String, Object>> selectKmye(@Param("orgId") Long orgId, @Param("kjyearMonth") String kjyearMonth,
                                         @Param("subjectCode") String subjectCode);

    /** 账龄明细 */
    List<Map<String, Object>> selectAgingList(@Param("orgId") Long orgId, @Param("kjyearMonth") String kjyearMonth,
                                              @Param("agingType") String agingType, @Param("projectCode") String projectCode);

    /** 账龄区间汇总 */
    List<Map<String, Object>> selectAgingSummary(@Param("orgId") Long orgId, @Param("kjyearMonth") String kjyearMonth);

    /** 数据导入情况统计 */
    List<Map<String, Object>> selectImportStat(@Param("orgId") Long orgId);
}
