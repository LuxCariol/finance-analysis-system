package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.qst.finance.model.CodeMapper;

/**
 * 编码映射(编码转换) Mapper (t_code_mapper)
 */
public interface CodeMapperMapper {

    @Select("SELECT * FROM t_code_mapper ORDER BY source_table, order_no, id")
    List<CodeMapper> selectAll();

    @Select("SELECT * FROM t_code_mapper WHERE is_active = 1 ORDER BY source_table, order_no, id")
    List<CodeMapper> selectActive();

    @Insert("INSERT INTO t_code_mapper (source_table, source_column, value_type, report_type, code, map_type,"
            + " calc_expression, order_no, is_active) VALUES (#{sourceTable}, #{sourceColumn}, #{valueType}, #{reportType},"
            + " #{code}, #{mapType}, #{calcExpression}, #{orderNo}, #{isActive})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(CodeMapper mapper);

    @Update("UPDATE t_code_mapper SET source_table = #{sourceTable}, source_column = #{sourceColumn}, value_type = #{valueType},"
            + " report_type = #{reportType}, code = #{code}, map_type = #{mapType}, calc_expression = #{calcExpression},"
            + " order_no = #{orderNo}, is_active = #{isActive} WHERE id = #{id}")
    int update(CodeMapper mapper);

    @Delete("DELETE FROM t_code_mapper WHERE id = #{id}")
    int deleteById(@Param("id") Long id);
}
