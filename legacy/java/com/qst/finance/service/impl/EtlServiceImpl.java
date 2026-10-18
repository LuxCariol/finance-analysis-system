package com.qst.finance.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.finance.common.BizException;
import com.qst.finance.common.Constants;
import com.qst.finance.config.AppProperties;
import com.qst.finance.mapper.CodeMapperMapper;
import com.qst.finance.mapper.DynamicTableMapper;
import com.qst.finance.mapper.ImportLogMapper;
import com.qst.finance.mapper.ReportNameMapper;
import com.qst.finance.mapper.ReportResultMapper;
import com.qst.finance.mapper.WarnRecordMapper;
import com.qst.finance.model.CodeMapper;
import com.qst.finance.model.ImportLog;
import com.qst.finance.model.ReportName;
import com.qst.finance.model.ReportResult;
import com.qst.finance.model.TransformResult;
import com.qst.finance.model.WarnRecord;
import com.qst.finance.service.AnalysisService;
import com.qst.finance.service.EtlService;
import com.qst.finance.service.support.TableColumnCache;
import com.qst.finance.util.DateUtil;

/**
 * ETL 数据转换实现(对应《概要设计》5.2 运行控制: 数据导入后点击"数据全量转换")
 *
 * 处理流程: 基础表(宽表) -> 依据 t_code_mapper 配置映射为管理编码 -> 写入 t_report_result
 *          -> 依据 t_mode 算法配置计算比率/杜邦/预警结果 -> 生成预警记录
 */
@Service
public class EtlServiceImpl implements EtlService {

    private static final Logger log = LoggerFactory.getLogger(EtlServiceImpl.class);

    @Autowired
    private ReportNameMapper reportNameMapper;

    @Autowired
    private CodeMapperMapper codeMapperMapper;

    @Autowired
    private DynamicTableMapper dynamicTableMapper;

    @Autowired
    private ReportResultMapper reportResultMapper;

    @Autowired
    private WarnRecordMapper warnRecordMapper;

    @Autowired
    private ImportLogMapper importLogMapper;

    @Autowired
    private AnalysisService analysisService;

    @Autowired
    private TableColumnCache tableColumnCache;

    @Autowired
    private AppProperties appProperties;

    @Override
    public TransformResult transform(Long orgId, String kjyearMonth, String impUser) {
        long startTime = System.currentTimeMillis();
        TransformResult result = new TransformResult();
        result.setKjyearMonth(kjyearMonth);
        result.setBatchId("E" + UUID.randomUUID().toString().replace("-", "").substring(0, 15).toUpperCase());
        List<ReportName> reports = reportNameMapper.selectAll();
        List<CodeMapper> mappers = codeMapperMapper.selectActive();
        if (reports.isEmpty()) {
            throw new BizException("报表配置为空，请先维护报表与取值配置");
        }
        List<ReportResult> etlResults = new ArrayList<ReportResult>();
        for (ReportName report : reports) {
            String reportType = report.getReportType();
            if (Constants.REPORT_KMYE.equals(reportType) || Constants.REPORT_AGING.equals(reportType)) {
                continue;
            }
            String table = report.getTableName();
            Map<String, String> tableColumns = tableColumnCache.columns(table);
            List<Map<String, Object>> rows = dynamicTableMapper.selectByMonth(table, orgId, kjyearMonth);
            result.setSourceRows(result.getSourceRows() + rows.size());
            for (Map<String, Object> row : rows) {
                for (CodeMapper mapper : mappers) {
                    if (!table.equalsIgnoreCase(mapper.getSourceTable())) {
                        continue;
                    }
                    if (StringUtils.isNotBlank(mapper.getReportType()) && !mapper.getReportType().equals(reportType)) {
                        continue;
                    }
                    if (!tableColumns.containsKey(mapper.getSourceColumn().toUpperCase())) {
                        continue;
                    }
                    BigDecimal value = valueOf(row, mapper.getSourceColumn());
                    if ("EXPRESSION".equalsIgnoreCase(mapper.getMapType())) {
                        result.getMessages().add("映射【" + mapper.getCode() + "】配置为表达式类型，将在算法阶段计算");
                        continue;
                    }
                    etlResults.add(buildResult(orgId, kjyearMonth, reportType, mapper.getCode(),
                            mapper.getValueType(), value, result.getBatchId(), "ETL"));
                }
            }
            dynamicTableMapper.updateFlagByMonth(table, orgId, kjyearMonth, Constants.FLAG_Y);
        }
        if (etlResults.isEmpty()) {
            throw new BizException("未找到 " + kjyearMonth + " 的基础财务数据，请先完成数据导入");
        }
        // 清理历史转换结果后重新写入
        reportResultMapper.deleteByMonth(orgId, kjyearMonth, "ETL");
        reportResultMapper.deleteByMonth(orgId, kjyearMonth, "ALGO");
        insertInBatch(etlResults);
        result.setMappedRows(etlResults.size());

        // 算法模型计算并持久化
        if (appProperties.isAutoCalcAfterTransform()) {
            List<ReportResult> algoResults = analysisService.buildAlgoResults(orgId, kjyearMonth, result.getBatchId());
            insertInBatch(algoResults);
            result.setAlgoRows(algoResults.size());

            warnRecordMapper.deleteByMonth(orgId, kjyearMonth);
            List<WarnRecord> warnRecords = analysisService.buildWarnRecords(orgId, kjyearMonth);
            if (!warnRecords.isEmpty()) {
                warnRecordMapper.insertBatch(warnRecords);
            }
            result.setWarnRows(warnRecords.size());
        }
        result.setCostMillis(System.currentTimeMillis() - startTime);
        result.getMessages().add("数据转换完成: 映射 " + result.getMappedRows() + " 条, 算法结果 "
                + result.getAlgoRows() + " 条, 预警 " + result.getWarnRows() + " 条");
        saveLog(result, impUser, startTime);
        log.info("数据转换完成 org={} month={} mapped={} algo={} warn={} cost={}ms",
                orgId, kjyearMonth, result.getMappedRows(), result.getAlgoRows(), result.getWarnRows(), result.getCostMillis());
        return result;
    }

    private ReportResult buildResult(Long orgId, String kjyearMonth, String reportType, String code,
                                     String valueType, BigDecimal value, String batchId, String dataSource) {
        ReportResult result = new ReportResult();
        result.setBatchId(batchId);
        result.setOrgId(orgId);
        result.setKjyear(DateUtil.yearOf(kjyearMonth));
        result.setKjmoth(DateUtil.monthOf(kjyearMonth));
        result.setKjyearMonth(kjyearMonth);
        result.setReportType(reportType);
        result.setCode(code);
        result.setValueType(valueType == null ? valueProviderDefault(reportType) : valueType);
        result.setResultValue(value);
        result.setDataSource(dataSource);
        result.setCreateTime(new Date());
        return result;
    }

    private String valueProviderDefault(String reportType) {
        return Constants.REPORT_BALANCE.equals(reportType) ? Constants.VALUE_QM : Constants.VALUE_BJ;
    }

    @SuppressWarnings("unchecked")
    private BigDecimal valueOf(Map<String, Object> row, String column) {
        Object value = null;
        for (Map.Entry<String, Object> entry : row.entrySet()) {
            if (entry.getKey().equalsIgnoreCase(column)) {
                value = entry.getValue();
                break;
            }
        }
        if (value == null) {
            return BigDecimal.ZERO;
        }
        if (value instanceof BigDecimal) {
            return (BigDecimal) value;
        }
        if (value instanceof Number) {
            return new BigDecimal(value.toString());
        }
        try {
            return new BigDecimal(String.valueOf(value));
        } catch (NumberFormatException e) {
            return BigDecimal.ZERO;
        }
    }

    private void insertInBatch(List<ReportResult> list) {
        int size = appProperties.getImportBatchSize();
        for (int i = 0; i < list.size(); i += size) {
            reportResultMapper.insertBatch(list.subList(i, Math.min(i + size, list.size())));
        }
    }

    @Override
    public Map<String, Object> transformStatus(Long orgId, String kjyearMonth) {
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        List<ReportName> reports = reportNameMapper.selectAll();
        List<Map<String, Object>> tables = new ArrayList<Map<String, Object>>();
        for (ReportName report : reports) {
            Map<String, Object> item = new LinkedHashMap<String, Object>();
            String table = report.getTableName();
            int total = dynamicTableMapper.countByMonth(table, orgId, kjyearMonth);
            int untransformed = dynamicTableMapper.selectUnTransformed(table, orgId, kjyearMonth).size();
            item.put("reportType", report.getReportType());
            item.put("reportName", report.getReportName());
            item.put("tableName", table);
            item.put("total", total);
            item.put("unTransformed", untransformed);
            tables.add(item);
        }
        List<ReportResult> resultList = reportResultMapper.selectByMonth(orgId, kjyearMonth, null, null);
        int etlCount = 0;
        int algoCount = 0;
        for (ReportResult rr : resultList) {
            if ("ALGO".equals(rr.getDataSource())) {
                algoCount++;
            } else {
                etlCount++;
            }
        }
        data.put("kjyearMonth", kjyearMonth);
        data.put("tables", tables);
        data.put("etlCount", etlCount);
        data.put("algoCount", algoCount);
        data.put("warnCount", warnRecordMapper.selectByMonth(orgId, kjyearMonth).size());
        return data;
    }

    @Override
    public List<WarnRecord> warnRecords(Long orgId, String kjyearMonth) {
        return warnRecordMapper.selectByMonth(orgId, kjyearMonth);
    }

    private void saveLog(TransformResult result, String impUser, long startTime) {
        ImportLog importLog = new ImportLog();
        importLog.setBatchId(result.getBatchId());
        importLog.setReportType("TRANSFORM");
        importLog.setReportName("数据全量转换");
        importLog.setFileName("-");
        importLog.setTotalRows(result.getSourceRows());
        importLog.setSuccessRows(result.getMappedRows());
        importLog.setFailRows(0);
        importLog.setStatus(result.getStatus());
        importLog.setMessage(String.join("; ", result.getMessages()));
        importLog.setImpUser(impUser);
        importLog.setStartTime(new Date(startTime));
        importLog.setEndTime(new Date());
        importLogMapper.insert(importLog);
    }
}
