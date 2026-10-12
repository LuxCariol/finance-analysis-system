package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.qst.finance.model.AnalysisReport;

/**
 * 报告表 Mapper (t_report: 投资预测报告等)
 */
public interface AnalysisReportMapper {

    @Select("SELECT * FROM t_report ORDER BY create_time DESC, id DESC")
    List<AnalysisReport> selectAll();

    @Select("SELECT * FROM t_report WHERE id = #{id}")
    AnalysisReport selectById(@Param("id") Long id);

    @Insert("INSERT INTO t_report (report_code, report_name, report_type, org_id, kjyear_month, summary, content, creator, create_time)"
            + " VALUES (#{reportCode}, #{reportName}, #{reportType}, #{orgId}, #{kjyearMonth}, #{summary}, #{content}, #{creator}, #{createTime})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(AnalysisReport report);

    @Delete("DELETE FROM t_report WHERE id = #{id}")
    int deleteById(@Param("id") Long id);
}
