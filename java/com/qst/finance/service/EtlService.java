package com.qst.finance.service;

import java.util.List;
import java.util.Map;

import com.qst.finance.model.TransformResult;
import com.qst.finance.model.WarnRecord;

/**
 * ETL 数据转换服务: 基础表 -> 编码映射 -> 数据仓库结果表 -> 算法模型计算
 */
public interface EtlService {

    /**
     * 执行指定会计年月的数据全量转换
     */
    TransformResult transform(Long orgId, String kjyearMonth, String impUser);

    /** 转换前状态预览(基础表数据量、已转换数据量) */
    Map<String, Object> transformStatus(Long orgId, String kjyearMonth);

    /** 预警记录 */
    List<WarnRecord> warnRecords(Long orgId, String kjyearMonth);
}
