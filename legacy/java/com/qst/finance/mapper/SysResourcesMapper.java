package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.qst.finance.model.SysResources;

/**
 * 菜单管理 Mapper (t_sys_resources)
 */
public interface SysResourcesMapper {

    @Select("SELECT * FROM t_sys_resources ORDER BY parent_id, order_no, id")
    List<SysResources> selectAll();

    @Select("SELECT * FROM t_sys_resources WHERE id = #{id}")
    SysResources selectById(@Param("id") Long id);

    @Select("SELECT COUNT(1) FROM t_sys_resources WHERE parent_id = #{parentId}")
    int countChildren(@Param("parentId") Long parentId);

    @Insert("INSERT INTO t_sys_resources (name, parent_id, res_key, type, res_url, order_no, icon, btn, is_hide, description)"
            + " VALUES (#{name}, #{parentId}, #{resKey}, #{type}, #{resUrl}, #{orderNo}, #{icon}, #{btn}, #{isHide}, #{description})")
    int insert(SysResources resources);

    @Update("UPDATE t_sys_resources SET name = #{name}, parent_id = #{parentId}, res_key = #{resKey}, type = #{type},"
            + " res_url = #{resUrl}, order_no = #{orderNo}, icon = #{icon}, is_hide = #{isHide}, description = #{description}"
            + " WHERE id = #{id}")
    int update(SysResources resources);

    @Delete("DELETE FROM t_sys_resources WHERE id = #{id}")
    int deleteById(@Param("id") Long id);

    @Delete("DELETE FROM t_sys_role_action WHERE res_id = #{resId}")
    int deleteRoleActionByRes(@Param("resId") Long resId);
}
