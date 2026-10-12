package com.qst.finance.service;

import java.util.List;
import java.util.Map;

/**
 * 财务报表服务: 资产负债表 / 利润表 / 现金流量表 / 科目余额表 / 账龄分析
 */
public interface ReportService {

    Map<String, Object> balanceSheet(Long orgId, String kjyearMonth);

    Map<String, Object> profitReport(Long orgId, String kjyearMonth);

    Map<String, Object> cashFlowReport(Long orgId, String kjyearMonth);

    /** 数据仓库编码明细(全部编码及取值) */
    List<Map<String, Object>> codeDetail(Long orgId, String kjyearMonth, String reportType, String keyword);

    List<Map<String, Object>> kmyeList(Long orgId, String kjyearMonth, String keyword);

    Map<String, Object> agingAnalysis(Long orgId, String kjyearMonth, String agingType);
}
