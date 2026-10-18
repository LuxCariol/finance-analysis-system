package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.qst.finance.model.ReportName;

/**
 * 报表名称(导入模板) Mapper (t_report_name)
 */
public interface ReportNameMapper {

    @Select("SELECT * FROM t_report_name ORDER BY order_no, id")
    List<ReportName> selectAll();

    @Select("SELECT * FROM t_report_name WHERE report_type = #{reportType}")
    ReportName selectByReportType(@Param("reportType") String reportType);

    @Insert("INSERT INTO t_report_name (report_code, report_type, report_name, table_name, map_mode, order_no, is_active, description)"
            + " VALUES (#{reportCode}, #{reportType}, #{reportName}, #{tableName}, #{mapMode}, #{orderNo}, #{isActive}, #{description})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(ReportName report);

    @Update("UPDATE t_report_name SET report_code = #{reportCode}, report_name = #{reportName}, table_name = #{tableName},"
            + " map_mode = #{mapMode}, order_no = #{orderNo}, is_active = #{isActive}, description = #{description} WHERE id = #{id}")
    int update(ReportName report);

    @Delete("DELETE FROM t_report_name WHERE id = #{id}")
    int deleteById(@Param("id") Long id);
}
