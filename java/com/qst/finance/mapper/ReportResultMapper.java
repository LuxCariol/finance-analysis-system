package com.qst.finance.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;

import com.qst.finance.model.ReportResult;

/**
 * 数据转换结果表 Mapper (t_report_result) —— 数据仓库结果表
 */
public interface ReportResultMapper {

    /** 批量写入(每批100条) */
    int insertBatch(@Param("list") List<ReportResult> list);

    /** 按公司 + 会计年月 + 报表类型 + 数据来源删除(重新执行转换时先清理) */
    @Delete("DELETE FROM t_report_result WHERE org_id = #{orgId} AND kjyear_month = #{kjyearMonth} AND data_source = #{dataSource}")
    int deleteByMonth(@Param("orgId") Long orgId, @Param("kjyearMonth") String kjyearMonth,
                      @Param("dataSource") String dataSource);

    /** 查询某月数据(算法计算的数据来源) */
    List<ReportResult> selectByMonth(@Param("orgId") Long orgId, @Param("kjyearMonth") String kjyearMonth,
                                     @Param("reportType") String reportType, @Param("dataSource") String dataSource);

    /** 查询多个会计年月的数据(趋势图) */
    List<ReportResult> selectByMonths(@Param("orgId") Long orgId, @Param("kjyearMonthList") List<String> months,
                                      @Param("code") String code, @Param("valueType") String valueType);

    /** 查询某月全部编码(明细列表) */
    List<ReportResult> selectCodesOfMonth(@Param("orgId") Long orgId, @Param("kjyearMonth") String kjyearMonth,
                                          @Param("codeList") List<String> codes, @Param("valueType") String valueType);

    /** 已存在的会计年月列表 */
    List<Map<String, Object>> selectMonthList(@Param("orgId") Long orgId, @Param("reportType") String reportType);
}
