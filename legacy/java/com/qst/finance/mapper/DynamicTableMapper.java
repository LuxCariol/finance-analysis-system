package com.qst.finance.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

/**
 * 基础表(宽表)通用 Mapper:
 * 资产负债/利润/现金流量基础表字段较多(150+列)，采用配置化动态 SQL 写入，
 * 表名与列名均在服务层做白名单校验，避免 SQL 注入。
 */
public interface DynamicTableMapper {

    int insertOne(@Param("table") String table, @Param("columns") List<String> columns, @Param("row") Map<String, Object> row);

    int deleteByMonth(@Param("table") String table, @Param("orgId") Long orgId, @Param("kjyearMonth") String kjyearMonth);

    int updateFlagByMonth(@Param("table") String table, @Param("orgId") Long orgId,
                          @Param("kjyearMonth") String kjyearMonth, @Param("flag") String flag);

    List<Map<String, Object>> selectByMonth(@Param("table") String table, @Param("orgId") Long orgId,
                                           @Param("kjyearMonth") String kjyearMonth);

    int countByMonth(@Param("table") String table, @Param("orgId") Long orgId, @Param("kjyearMonth") String kjyearMonth);

    /** 查询未转换的数据(FORMAT_FLAG = 'N') */
    List<Map<String, Object>> selectUnTransformed(@Param("table") String table, @Param("orgId") Long orgId,
                                                 @Param("kjyearMonth") String kjyearMonth);

    int countAll(@Param("table") String table, @Param("orgId") Long orgId);
}
