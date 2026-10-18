package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.qst.finance.model.OrgInfo;

/**
 * 公司管理 Mapper (t_org_info)
 */
public interface OrgInfoMapper {

    @Select("SELECT * FROM t_org_info ORDER BY id")
    List<OrgInfo> selectAll();

    @Select("SELECT * FROM t_org_info WHERE id = #{id}")
    OrgInfo selectById(@Param("id") Long id);

    @Insert("INSERT INTO t_org_info (org_code, org_name, parent_id, org_type, description, create_time)"
            + " VALUES (#{orgCode}, #{orgName}, #{parentId}, #{orgType}, #{description}, #{createTime})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(OrgInfo org);

    @Update("UPDATE t_org_info SET org_code = #{orgCode}, org_name = #{orgName}, parent_id = #{parentId},"
            + " org_type = #{orgType}, description = #{description} WHERE id = #{id}")
    int update(OrgInfo org);

    @Delete("DELETE FROM t_org_info WHERE id = #{id}")
    int deleteById(@Param("id") Long id);
}
