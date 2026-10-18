package com.qst.finance.service;

import java.util.List;
import java.util.Map;

import com.qst.finance.model.CalcResult;
import com.qst.finance.model.AnalysisReport;
import com.qst.finance.model.ReportResult;
import com.qst.finance.model.TrendSeries;
import com.qst.finance.model.WarnRecord;

/**
 * 财务分析服务: 比率分析 / 资金概要与预警 / 杜邦分析 / 投资计算 / 损益预测 / 企业经营报告
 */
public interface AnalysisService {

    /** 按算法模型类型计算指标(配置化) */
    List<CalcResult> calcByType(Long orgId, String kjyearMonth, String modeType);

    List<CalcResult> ratioAnalysis(Long orgId, String kjyearMonth);

    List<CalcResult> fundAnalysis(Long orgId, String kjyearMonth);

    List<CalcResult> dupontAnalysis(Long orgId, String kjyearMonth);

    /** 企业经营报告(总量指标 + 预警 + 文字说明) */
    Map<String, Object> enterpriseReport(Long orgId, String kjyearMonth);

    /** 指标趋势(曲线图/柱状图/饼图数据源) */
    TrendSeries trend(Long orgId, String code, String valueType, List<String> months,
                      String name, String unit, String chartType);

    /** 算法指标趋势: 按月重新计算算法表达式(不依赖是否执行过数据转换) */
    TrendSeries trendOfMode(Long orgId, String modeCode, String endMonth, int months);

    /** 首页概览 */
    Map<String, Object> dashboard(Long orgId, String kjyearMonth);

    /** 投资计算: NPV / IRR / 投资回收期 */
    Map<String, Object> investmentCalc(Map<String, Object> input);

    /** 损益预测: 线性回归 + 复合增长率外推 */
    Map<String, Object> profitForecast(Long orgId, String kjyearMonth, int periods);

    /** 数据转换时: 生成算法结果(比率/杜邦/预警)用于持久化 */
    List<ReportResult> buildAlgoResults(Long orgId, String kjyearMonth, String batchId);

    /** 数据转换时: 生成预警记录 */
    List<WarnRecord> buildWarnRecords(Long orgId, String kjyearMonth);

    /** 保存投资预测报告 */
    AnalysisReport saveInvestmentReport(Map<String, Object> input);

    /** 投资预测报告列表 */
    List<AnalysisReport> investmentReports();
}
