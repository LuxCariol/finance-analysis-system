package com.qst.finance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.qst.finance.model.MessageInfo;

/**
 * 资讯管理 Mapper (t_message_info)
 */
public interface MessageInfoMapper {

    @Select("SELECT * FROM t_message_info ORDER BY publish_time DESC, id DESC")
    List<MessageInfo> selectAll();

    @Insert("INSERT INTO t_message_info (title, content, info_type, publish_user, publish_time, status, read_count)"
            + " VALUES (#{title}, #{content}, #{infoType}, #{publishUser}, #{publishTime}, #{status}, #{readCount})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(MessageInfo info);

    @Update("UPDATE t_message_info SET title = #{title}, content = #{content}, info_type = #{infoType}, status = #{status}"
            + " WHERE id = #{id}")
    int update(MessageInfo info);

    @Delete("DELETE FROM t_message_info WHERE id = #{id}")
    int deleteById(@Param("id") Long id);
}
