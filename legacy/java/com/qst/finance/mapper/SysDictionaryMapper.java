package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.qst.finance.model.SysDictionary;
import com.qst.finance.model.SysDictionaryDetail;

/**
 * 系统字典 Mapper (t_sys_dictionary / t_sys_dictionary_detail)
 */
public interface SysDictionaryMapper {

    @Select("SELECT * FROM t_sys_dictionary ORDER BY dict_code")
    List<SysDictionary> selectDictAll();

    @Insert("INSERT INTO t_sys_dictionary (dict_code, dict_name, description, create_time)"
            + " VALUES (#{dictCode}, #{dictName}, #{description}, #{createTime})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertDict(SysDictionary dict);

    @Update("UPDATE t_sys_dictionary SET dict_name = #{dictName}, description = #{description} WHERE id = #{id}")
    int updateDict(SysDictionary dict);

    @Delete("DELETE FROM t_sys_dictionary WHERE id = #{id}")
    int deleteDict(@Param("id") Long id);

    @Select("SELECT * FROM t_sys_dictionary_detail WHERE dict_code = #{dictCode} ORDER BY order_no, id")
    List<SysDictionaryDetail> selectDetailByDictCode(@Param("dictCode") String dictCode);

    @Select("SELECT * FROM t_sys_dictionary_detail WHERE dict_code = #{dictCode} AND item_key = #{itemKey}")
    SysDictionaryDetail selectDetail(@Param("dictCode") String dictCode, @Param("itemKey") String itemKey);

    @Insert("INSERT INTO t_sys_dictionary_detail (dict_code, item_key, item_value, order_no, description)"
            + " VALUES (#{dictCode}, #{itemKey}, #{itemValue}, #{orderNo}, #{description})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insertDetail(SysDictionaryDetail detail);

    @Update("UPDATE t_sys_dictionary_detail SET item_value = #{itemValue}, order_no = #{orderNo}, description = #{description}"
            + " WHERE id = #{id}")
    int updateDetail(SysDictionaryDetail detail);

    @Delete("DELETE FROM t_sys_dictionary_detail WHERE id = #{id}")
    int deleteDetail(@Param("id") Long id);
}
