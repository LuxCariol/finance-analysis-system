package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.qst.finance.model.ReportProperty;

/**
 * 取值配置 Mapper (t_report_property)
 */
public interface ReportPropertyMapper {

    @Select("SELECT * FROM t_report_property ORDER BY report_type, order_no, id")
    List<ReportProperty> selectAll();

    @Select("SELECT * FROM t_report_property WHERE report_type = #{reportType} AND is_active = 1 ORDER BY order_no, id")
    List<ReportProperty> selectByReportType(@Param("reportType") String reportType);

    @Insert("INSERT INTO t_report_property (report_type, report_code, subject_name, subject_level, source_column,"
            + " column_code, col_index, is_key, default_value, order_no, is_active)"
            + " VALUES (#{reportType}, #{reportCode}, #{subjectName}, #{subjectLevel}, #{sourceColumn}, #{columnCode},"
            + " #{colIndex}, #{isKey}, #{defaultValue}, #{orderNo}, #{isActive})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(ReportProperty property);

    @Update("UPDATE t_report_property SET subject_name = #{subjectName}, subject_level = #{subjectLevel},"
            + " source_column = #{sourceColumn}, column_code = #{columnCode}, col_index = #{colIndex}, is_key = #{isKey},"
            + " default_value = #{defaultValue}, order_no = #{orderNo}, is_active = #{isActive} WHERE id = #{id}")
    int update(ReportProperty property);

    @Delete("DELETE FROM t_report_property WHERE id = #{id}")
    int deleteById(@Param("id") Long id);
}
