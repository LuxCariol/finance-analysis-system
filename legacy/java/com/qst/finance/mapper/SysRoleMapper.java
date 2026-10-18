package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.qst.finance.model.SysRole;

/**
 * 角色管理 Mapper (t_sys_role / t_sys_role_action)
 */
public interface SysRoleMapper {

    @Select("SELECT * FROM t_sys_role ORDER BY id")
    List<SysRole> selectAll();

    @Select("SELECT * FROM t_sys_role WHERE id = #{id}")
    SysRole selectById(@Param("id") Long id);

    @Insert("INSERT INTO t_sys_role (name, user_id, description, create_time) VALUES (#{name}, #{userId}, #{description}, #{createTime})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(SysRole role);

    @Update("UPDATE t_sys_role SET name = #{name}, description = #{description} WHERE id = #{id}")
    int update(SysRole role);

    @Delete("DELETE FROM t_sys_role WHERE id = #{id}")
    int deleteById(@Param("id") Long id);

    @Delete("DELETE FROM t_sys_role_action WHERE role_id = #{roleId}")
    int deleteRoleAction(@Param("roleId") Long roleId);

    @Insert("INSERT INTO t_sys_role_action (res_id, role_id) VALUES (#{resId}, #{roleId})")
    int insertRoleAction(@Param("resId") Long resId, @Param("roleId") Long roleId);

    @Select("SELECT res_id FROM t_sys_role_action WHERE role_id = #{roleId}")
    List<Long> selectResIdsByRoleId(@Param("roleId") Long roleId);

    @Select("SELECT COUNT(1) FROM t_sys_user_role WHERE role_id = #{roleId}")
    int countUserByRole(@Param("roleId") Long roleId);
}
