package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.qst.finance.model.Mode;

/**
 * 算法模型 Mapper (t_mode)
 */
public interface ModeMapper {

    @Select("SELECT * FROM t_mode ORDER BY mode_type, order_no, id")
    List<Mode> selectAll();

    @Select("SELECT * FROM t_mode WHERE mode_type = #{modeType} AND is_active = 1 ORDER BY order_no, id")
    List<Mode> selectByType(@Param("modeType") String modeType);

    @Select("SELECT * FROM t_mode WHERE mode_code = #{modeCode}")
    Mode selectByCode(@Param("modeCode") String modeCode);

    @Insert("INSERT INTO t_mode (mode_code, mode_name, mode_type, parent_code, calc_expression, result_code, result_name,"
            + " result_type, unit, precision_scale, warn_mode, warn_lower, warn_upper, warn_level, main_factor, advantage,"
            + " disadvantage, advise, order_no, is_active, description)"
            + " VALUES (#{modeCode}, #{modeName}, #{modeType}, #{parentCode}, #{calcExpression}, #{resultCode}, #{resultName},"
            + " #{resultType}, #{unit}, #{precisionScale}, #{warnMode}, #{warnLower}, #{warnUpper}, #{warnLevel},"
            + " #{mainFactor}, #{advantage}, #{disadvantage}, #{advise}, #{orderNo}, #{isActive}, #{description})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(Mode mode);

    @Update("UPDATE t_mode SET mode_code = #{modeCode}, mode_name = #{modeName}, mode_type = #{modeType},"
            + " parent_code = #{parentCode}, calc_expression = #{calcExpression}, result_code = #{resultCode},"
            + " result_name = #{resultName}, result_type = #{resultType}, unit = #{unit}, precision_scale = #{precisionScale},"
            + " warn_mode = #{warnMode}, warn_lower = #{warnLower}, warn_upper = #{warnUpper}, warn_level = #{warnLevel},"
            + " main_factor = #{mainFactor}, advantage = #{advantage}, disadvantage = #{disadvantage}, advise = #{advise},"
            + " order_no = #{orderNo}, is_active = #{isActive}, description = #{description} WHERE id = #{id}")
    int update(Mode mode);

    @Delete("DELETE FROM t_mode WHERE id = #{id}")
    int deleteById(@Param("id") Long id);
}
