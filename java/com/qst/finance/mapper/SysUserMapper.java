package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.qst.finance.model.SysUser;
import com.qst.finance.model.SysResources;

/**
 * 用户管理 Mapper (t_sys_user / t_sys_user_role)
 */
public interface SysUserMapper {

    @Select("SELECT * FROM t_sys_user WHERE account_name = #{accountName}")
    SysUser selectByAccount(@Param("accountName") String accountName);

    @Select("SELECT * FROM t_sys_user WHERE id = #{id}")
    SysUser selectById(@Param("id") Long id);

    List<SysUser> selectList(SysUser query);

    @Insert("INSERT INTO t_sys_user (user_name, account_name, pwd, locked, account_type, create_user_id, description,"
            + " create_time, account_port_type, chrid, org_id) VALUES (#{userName}, #{accountName}, #{pwd},"
            + " #{locked}, #{accountType}, #{createUserId}, #{description}, #{createTime}, #{accountPortType}, #{chrid}, #{orgId})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(SysUser user);

    @Update("UPDATE t_sys_user SET user_name = #{userName}, account_name = #{accountName}, locked = #{locked},"
            + " description = #{description}, org_id = #{orgId}, account_port_type = #{accountPortType} WHERE id = #{id}")
    int update(SysUser user);

    @Update("UPDATE t_sys_user SET pwd = #{pwd} WHERE id = #{id}")
    int updatePwd(@Param("id") Long id, @Param("pwd") String pwd);

    @Delete("DELETE FROM t_sys_user WHERE id = #{id}")
    int deleteById(@Param("id") Long id);

    @Delete("DELETE FROM t_sys_user_role WHERE user_id = #{userId}")
    int deleteUserRole(@Param("userId") Long userId);

    @Insert("INSERT INTO t_sys_user_role (user_id, role_id) VALUES (#{userId}, #{roleId})")
    int insertUserRole(@Param("userId") Long userId, @Param("roleId") Long roleId);

    @Select("SELECT role_id FROM t_sys_user_role WHERE user_id = #{userId}")
    List<Long> selectRoleIdsByUserId(@Param("userId") Long userId);

    @Select("SELECT r.name FROM t_sys_role r INNER JOIN t_sys_user_role ur ON ur.role_id = r.id WHERE ur.user_id = #{userId}")
    List<String> selectRoleNamesByUserId(@Param("userId") Long userId);

    /**
     * 查询用户有权限的菜单(root 账号返回全部)
     */
    List<SysResources> selectMenusByUserId(@Param("userId") Long userId, @Param("root") boolean root);
}
