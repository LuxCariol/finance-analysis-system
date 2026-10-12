package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.qst.finance.model.CodeLibr;

/**
 * 编码字典 Mapper (t_code_libr)
 */
public interface CodeLibrMapper {

    @Select("SELECT * FROM t_code_libr ORDER BY report_type, order_no, id")
    List<CodeLibr> selectAll();

    @Select("SELECT * FROM t_code_libr WHERE code = #{code}")
    CodeLibr selectByCode(@Param("code") String code);

    @Select("SELECT * FROM t_code_libr WHERE report_type = #{reportType} ORDER BY order_no")
    List<CodeLibr> selectByReportType(@Param("reportType") String reportType);

    @Insert("INSERT INTO t_code_libr (code, code_name, report_type, report_group, chart_type, precision_scale, unit,"
            + " order_no, is_active, description) VALUES (#{code}, #{codeName}, #{reportType}, #{reportGroup}, #{chartType},"
            + " #{precisionScale}, #{unit}, #{orderNo}, #{isActive}, #{description})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(CodeLibr libr);

    @Update("UPDATE t_code_libr SET code = #{code}, code_name = #{codeName}, report_type = #{reportType},"
            + " report_group = #{reportGroup}, chart_type = #{chartType}, precision_scale = #{precisionScale}, unit = #{unit},"
            + " order_no = #{orderNo}, is_active = #{isActive}, description = #{description} WHERE id = #{id}")
    int update(CodeLibr libr);

    @Delete("DELETE FROM t_code_libr WHERE id = #{id}")
    int deleteById(@Param("id") Long id);
}
