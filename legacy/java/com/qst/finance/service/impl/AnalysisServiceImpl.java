package com.qst.finance.service.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.finance.common.BizException;
import com.qst.finance.common.Constants;
import com.qst.finance.mapper.CodeLibrMapper;
import com.qst.finance.mapper.AnalysisReportMapper;
import com.qst.finance.mapper.ImportLogMapper;
import com.qst.finance.mapper.MessageInfoMapper;
import com.qst.finance.mapper.ModeMapper;
import com.qst.finance.mapper.ReportDataMapper;
import com.qst.finance.mapper.ReportResultMapper;
import com.qst.finance.model.CalcResult;
import com.qst.finance.model.CodeLibr;
import com.qst.finance.model.AnalysisReport;
import com.qst.finance.model.Mode;
import com.qst.finance.model.ReportResult;
import com.qst.finance.model.TrendSeries;
import com.qst.finance.model.WarnRecord;
import com.qst.finance.service.AnalysisService;
import com.qst.finance.service.support.ValueProviderHelper;
import com.qst.finance.util.DateUtil;
import com.qst.finance.util.ExpressionEvaluator;
import com.qst.finance.util.MapUtil;

@Service
public class AnalysisServiceImpl implements AnalysisService {

    private static final int TREND_MONTHS = 6;

    @Autowired
    private ModeMapper modeMapper;

    @Autowired
    private CodeLibrMapper codeLibrMapper;

    @Autowired
    private ReportResultMapper reportResultMapper;

    @Autowired
    private ReportDataMapper reportDataMapper;

    @Autowired
    private MessageInfoMapper messageInfoMapper;

    @Autowired
    private AnalysisReportMapper analysisReportMapper;

    @Autowired
    private ImportLogMapper importLogMapper;

    @Autowired
    private ValueProviderHelper valueProviderHelper;

    // ------------------------------------------------------------------ 算法计算

    @Override
    public List<CalcResult> calcByType(Long orgId, String kjyearMonth, String modeType) {
        List<Mode> modes = modeMapper.selectByType(modeType);
        Map<String, BigDecimal> values = valueProviderHelper.loadValues(orgId, kjyearMonth);
        String prevMonth = DateUtil.offsetMonth(kjyearMonth, -1);
        Map<String, BigDecimal> prevValues = valueProviderHelper.loadValues(orgId, prevMonth);
        List<CalcResult> results = new ArrayList<CalcResult>();
        for (Mode mode : modes) {
            CalcResult result = new CalcResult();
            result.setModeCode(mode.getModeCode());
            result.setModeName(mode.getModeName());
            result.setModeType(mode.getModeType());
            result.setParentCode(mode.getParentCode());
            result.setResultCode(mode.getResultCode());
            result.setResultName(mode.getResultName());
            result.setCalcExpression(mode.getCalcExpression());
            result.setUnit(mode.getUnit());
            result.setPrecisionScale(mode.getPrecisionScale() == null ? 2 : mode.getPrecisionScale());
            result.setWarnMode(mode.getWarnMode());
            result.setWarnLower(mode.getWarnLower());
            result.setWarnUpper(mode.getWarnUpper());
            result.setMainFactor(mode.getMainFactor());
            result.setAdvantage(mode.getAdvantage());
            result.setDisadvantage(mode.getDisadvantage());
            result.setAdvise(mode.getAdvise());
            BigDecimal value = valueProviderHelper.eval(mode.getCalcExpression(), values);
            result.setValue(value);
            evaluateWarn(result, value, mode);
            BigDecimal prev = prevValues.get(mode.getResultCode() + "@QM");
            if (prev != null && prev.signum() != 0) {
                result.setMomRate(value.subtract(prev).divide(prev.abs(), 6, RoundingMode.HALF_UP));
            }
            results.add(result);
        }
        return results;
    }

    @Override
    public List<CalcResult> ratioAnalysis(Long orgId, String kjyearMonth) {
        return calcByType(orgId, kjyearMonth, Constants.REPORT_RATIO);
    }

    @Override
    public List<CalcResult> fundAnalysis(Long orgId, String kjyearMonth) {
        return calcByType(orgId, kjyearMonth, Constants.REPORT_WARN);
    }

    @Override
    public List<CalcResult> dupontAnalysis(Long orgId, String kjyearMonth) {
        return calcByType(orgId, kjyearMonth, Constants.REPORT_DUPONT);
    }

    private void evaluateWarn(CalcResult result, BigDecimal value, Mode mode) {
        String warnMode = mode.getWarnMode() == null ? "none" : mode.getWarnMode();
        BigDecimal lower = mode.getWarnLower();
        BigDecimal upper = mode.getWarnUpper();
        int level = 0;
        StringBuilder desc = new StringBuilder();
        if ("down".equalsIgnoreCase(warnMode) && lower != null && value.compareTo(lower) < 0) {
            level = mode.getWarnLevel() == null ? 1 : mode.getWarnLevel();
            desc.append(result.getModeName()).append(" 当前 ").append(display(value, result.getUnit(), result.getPrecisionScale()))
                    .append("，已低于预警下限 ").append(display(lower, result.getUnit(), result.getPrecisionScale()));
        } else if ("up".equalsIgnoreCase(warnMode) && upper != null && value.compareTo(upper) > 0) {
            level = mode.getWarnLevel() == null ? 1 : mode.getWarnLevel();
            desc.append(result.getModeName()).append(" 当前 ").append(display(value, result.getUnit(), result.getPrecisionScale()))
                    .append("，已高于预警上限 ").append(display(upper, result.getUnit(), result.getPrecisionScale()));
        } else if ("range".equalsIgnoreCase(warnMode)
                && ((lower != null && value.compareTo(lower) < 0) || (upper != null && value.compareTo(upper) > 0))) {
            level = mode.getWarnLevel() == null ? 1 : mode.getWarnLevel();
            desc.append(result.getModeName()).append(" 当前 ").append(display(value, result.getUnit(), result.getPrecisionScale()))
                    .append("，已超出合理区间 [")
                    .append(lower == null ? "-" : display(lower, result.getUnit(), result.getPrecisionScale())).append(" , ")
                    .append(upper == null ? "-" : display(upper, result.getUnit(), result.getPrecisionScale())).append("]");
        }
        result.setWarnLevel(level);
        result.setWarnLevelText(levelText(level));
        result.setWarnDesc(desc.length() == 0 ? "" : desc.toString());
        result.setDisplayValue(display(value, result.getUnit(), result.getPrecisionScale()));
    }

    private String levelText(int level) {
        if (level >= 3) {
            return "严重";
        }
        if (level == 2) {
            return "警告";
        }
        if (level == 1) {
            return "提示";
        }
        return "正常";
    }

    private String display(BigDecimal value, String unit, Integer precision) {
        if (value == null) {
            return "-";
        }
        int scale = precision == null ? 2 : precision;
        String text;
        if ("%".equals(unit)) {
            text = value.multiply(new BigDecimal(100)).setScale(scale, RoundingMode.HALF_UP).toPlainString() + "%";
        } else {
            text = value.setScale(scale, RoundingMode.HALF_UP).toPlainString();
            if (StringUtils.isNotBlank(unit)) {
                text = text + " " + unit;
            }
        }
        return text;
    }

    // ------------------------------------------------------------------ 企业经营报告

    @Override
    public Map<String, Object> enterpriseReport(Long orgId, String kjyearMonth) {
        Map<String, BigDecimal> values = valueProviderHelper.loadValues(orgId, kjyearMonth);
        List<Map<String, Object>> summary = new ArrayList<Map<String, Object>>();
        summary.add(summaryItem(values, "A032", "资产总计", Constants.VALUE_QM));
        summary.add(summaryItem(values, "A057", "负债合计", Constants.VALUE_QM));
        summary.add(summaryItem(values, "A068", "所有者权益合计", Constants.VALUE_QM));
        summary.add(summaryItem(values, "A001", "货币资金", Constants.VALUE_QM));
        summary.add(summaryItem(values, "P001", "营业收入", Constants.VALUE_BJ));
        summary.add(summaryItem(values, "P021", "净利润", Constants.VALUE_BJ));
        summary.add(summaryItem(values, "C010", "经营活动现金流量净额", Constants.VALUE_BJ));

        List<CalcResult> ratios = ratioAnalysis(orgId, kjyearMonth);
        List<CalcResult> warns = fundAnalysis(orgId, kjyearMonth);
        List<Map<String, Object>> warnList = collectWarnings(ratios, warns);

        List<TrendSeries> trends = new ArrayList<TrendSeries>();
        List<String> months = recentMonths(orgId, kjyearMonth);
        trends.add(trend(orgId, "P001", Constants.VALUE_BJ, months, "营业收入", "元", "bar"));
        trends.add(trend(orgId, "P021", Constants.VALUE_BJ, months, "净利润", "元", "line"));
        trends.add(trend(orgId, "A032", Constants.VALUE_QM, months, "资产总计", "元", "line"));

        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("orgId", orgId);
        data.put("kjyearMonth", kjyearMonth);
        data.put("summary", summary);
        data.put("ratios", ratios);
        data.put("warns", warns);
        data.put("warnList", warnList);
        data.put("trends", trends);
        data.put("conclusion", buildConclusion(kjyearMonth, values, warnList));
        return data;
    }

    private Map<String, Object> summaryItem(Map<String, BigDecimal> values, String code, String name, String valueType) {
        CodeLibr libr = codeLibrMapper.selectByCode(code);
        BigDecimal current = values.get(code + "@" + valueType);
        BigDecimal begin = values.get(code + "@" + (Constants.VALUE_BJ.equals(valueType) ? Constants.VALUE_SQ : Constants.VALUE_NC));
        Map<String, Object> item = new LinkedHashMap<String, Object>();
        item.put("code", code);
        item.put("name", libr == null ? name : libr.getCodeName());
        item.put("valueType", valueType);
        item.put("current", current == null ? BigDecimal.ZERO : current);
        item.put("compare", begin == null ? BigDecimal.ZERO : begin);
        BigDecimal change = (current == null ? BigDecimal.ZERO : current)
                .subtract(begin == null ? BigDecimal.ZERO : begin);
        item.put("change", change);
        item.put("changeRate", begin == null || begin.signum() == 0 ? null
                : change.divide(begin.abs(), 6, RoundingMode.HALF_UP));
        return item;
    }

    private List<Map<String, Object>> collectWarnings(List<CalcResult> ratios, List<CalcResult> warns) {
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        for (CalcResult result : ratios) {
            addWarn(list, result);
        }
        for (CalcResult result : warns) {
            addWarn(list, result);
        }
        return list;
    }

    private void addWarn(List<Map<String, Object>> list, CalcResult result) {
        if (result.getWarnLevel() != null && result.getWarnLevel() > 0) {
            Map<String, Object> item = new LinkedHashMap<String, Object>();
            item.put("modeCode", result.getModeCode());
            item.put("resultCode", result.getResultCode());
            item.put("resultName", result.getResultName());
            item.put("value", result.getValue());
            item.put("displayValue", result.getDisplayValue());
            item.put("warnLevel", result.getWarnLevel());
            item.put("warnLevelText", result.getWarnLevelText());
            item.put("warnDesc", result.getWarnDesc());
            item.put("advise", result.getAdvise());
            list.add(item);
        }
    }

    private String buildConclusion(String kjyearMonth, Map<String, BigDecimal> values, List<Map<String, Object>> warnings) {
        BigDecimal asset = nvl(values.get("A032@QM"));
        BigDecimal liability = nvl(values.get("A057@QM"));
        BigDecimal revenue = nvl(values.get("P001@BJ"));
        BigDecimal profit = nvl(values.get("P021@BJ"));
        BigDecimal cash = nvl(values.get("C010@BJ"));
        StringBuilder text = new StringBuilder();
        text.append(kjyearMonth).append(" 公司资产总计 ").append(amount(asset)).append("，负债合计 ")
                .append(amount(liability)).append("，资产负债率 ")
                .append(asset.signum() == 0 ? "-" : percent(liability.divide(asset, 6, RoundingMode.HALF_UP)))
                .append("；实现营业收入 ").append(amount(revenue)).append("，净利润 ").append(amount(profit))
                .append("，净利率 ").append(revenue.signum() == 0 ? "-" : percent(profit.divide(revenue, 6, RoundingMode.HALF_UP)))
                .append("；经营活动产生的现金流量净额 ").append(amount(cash)).append("。");
        if (warnings.isEmpty()) {
            text.append("报告期内各项财务指标均处于健康区间，财务结构稳健。");
        } else {
            text.append("报告期内共有 ").append(warnings.size()).append(" 项指标触及预警，重点关注 ");
            for (int i = 0; i < warnings.size() && i < 3; i++) {
                if (i > 0) {
                    text.append("、");
                }
                text.append(warnings.get(i).get("resultName"));
            }
            text.append("，具体调整建议见预警明细。");
        }
        return text.toString();
    }

    private String amount(BigDecimal value) {
        return value.setScale(2, RoundingMode.HALF_UP).toPlainString() + " 元";
    }

    private String percent(BigDecimal value) {
        return value.multiply(new BigDecimal(100)).setScale(2, RoundingMode.HALF_UP).toPlainString() + "%";
    }

    private BigDecimal nvl(BigDecimal value) {
        return value == null ? BigDecimal.ZERO : value;
    }

    // ------------------------------------------------------------------ 趋势

    @Override
    public TrendSeries trend(Long orgId, String code, String valueType, List<String> months,
                             String name, String unit, String chartType) {
        TrendSeries series = new TrendSeries();
        series.setCode(code);
        series.setUnit(unit);
        series.setChartType(chartType);
        CodeLibr libr = codeLibrMapper.selectByCode(code);
        series.setName(StringUtils.isNotBlank(name) ? name : (libr == null ? code : libr.getCodeName()));
        List<ReportResult> list = reportResultMapper.selectByMonths(orgId, months, code, valueType);
        Map<String, BigDecimal> monthValues = new LinkedHashMap<String, BigDecimal>();
        for (ReportResult result : list) {
            monthValues.put(result.getKjyearMonth(), result.getResultValue());
        }
        for (String month : months) {
            series.getMonths().add(month);
            series.getValues().add(monthValues.get(month));
        }
        return series;
    }

    @Override
    public TrendSeries trendOfMode(Long orgId, String modeCode, String endMonth, int months) {
        Mode mode = modeMapper.selectByCode(modeCode);
        if (mode == null) {
            throw new BizException("算法模型不存在: " + modeCode);
        }
        int size = months <= 0 ? TREND_MONTHS : months;
        TrendSeries series = new TrendSeries();
        series.setCode(mode.getResultCode());
        series.setName(mode.getModeName());
        series.setUnit(mode.getUnit());
        series.setChartType("line");
        for (int i = size - 1; i >= 0; i--) {
            String month = DateUtil.offsetMonth(endMonth, -i);
            Map<String, BigDecimal> values = valueProviderHelper.loadValues(orgId, month);
            BigDecimal value = valueProviderHelper.eval(mode.getCalcExpression(), values);
            series.getMonths().add(month);
            series.getValues().add(values.isEmpty() ? null : value);
        }
        return series;
    }

    private List<String> recentMonths(Long orgId, String endMonth) {
        List<Map<String, Object>> monthList = reportResultMapper.selectMonthList(orgId, null);
        List<String> all = new ArrayList<String>();
        for (Map<String, Object> row : MapUtil.convert(monthList)) {
            all.add(MapUtil.toStr(row.get("kjyearMonth")));
        }
        List<String> months = new ArrayList<String>();
        for (String month : all) {
            if (month != null && month.compareTo(endMonth) <= 0) {
                months.add(month);
            }
        }
        java.util.Collections.sort(months);
        if (months.size() > TREND_MONTHS) {
            months = new ArrayList<String>(months.subList(months.size() - TREND_MONTHS, months.size()));
        }
        if (months.isEmpty()) {
            months.add(endMonth);
        }
        return months;
    }

    // ------------------------------------------------------------------ 首页概览

    @Override
    public Map<String, Object> dashboard(Long orgId, String kjyearMonth) {
        Map<String, BigDecimal> values = valueProviderHelper.loadValues(orgId, kjyearMonth);
        List<CalcResult> ratios = ratioAnalysis(orgId, kjyearMonth);
        List<CalcResult> warns = fundAnalysis(orgId, kjyearMonth);
        List<Map<String, Object>> warnList = collectWarnings(ratios, warns);

        List<Map<String, Object>> cards = new ArrayList<Map<String, Object>>();
        cards.add(card("资产总计", values.get("A032@QM"), "元", "A032", kjyearMonth));
        cards.add(card("负债合计", values.get("A057@QM"), "元", "A057", kjyearMonth));
        cards.add(card("营业收入(本期)", values.get("P001@BJ"), "元", "P001", kjyearMonth));
        cards.add(card("净利润(本期)", values.get("P021@BJ"), "元", "P021", kjyearMonth));
        cards.add(card("货币资金", values.get("A001@QM"), "元", "A001", kjyearMonth));
        cards.add(card("经营活动现金流量净额", values.get("C010@BJ"), "元", "C010", kjyearMonth));

        List<String> months = recentMonths(orgId, kjyearMonth);
        List<TrendSeries> trends = new ArrayList<TrendSeries>();
        trends.add(trend(orgId, "P001", Constants.VALUE_BJ, months, "营业收入", "元", "bar"));
        trends.add(trend(orgId, "P021", Constants.VALUE_BJ, months, "净利润", "元", "line"));
        trends.add(trend(orgId, "A032", Constants.VALUE_QM, months, "资产总计", "元", "line"));

        List<CalcResult> keyRatios = new ArrayList<CalcResult>();
        String[] keys = new String[]{"R101", "R104", "R107", "R108", "R110", "R113"};
        for (CalcResult result : ratios) {
            for (String key : keys) {
                if (key.equals(result.getResultCode())) {
                    keyRatios.add(result);
                }
            }
        }

        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("orgId", orgId);
        data.put("kjyearMonth", kjyearMonth);
        data.put("cards", cards);
        data.put("keyRatios", keyRatios);
        data.put("warnList", warnList);
        data.put("trends", trends);
        data.put("news", messageInfoMapper.selectAll().size() > 5
                ? messageInfoMapper.selectAll().subList(0, 5) : messageInfoMapper.selectAll());
        data.put("importStat", MapUtil.convert(reportDataMapper.selectImportStat(orgId)));
        data.put("months", months);
        data.put("logCount", importLogMapper.selectAll().size());
        return data;
    }

    private Map<String, Object> card(String name, BigDecimal value, String unit, String code, String kjyearMonth) {
        Map<String, Object> card = new LinkedHashMap<String, Object>();
        card.put("name", name);
        card.put("code", code);
        card.put("unit", unit);
        card.put("value", value == null ? BigDecimal.ZERO : value);
        card.put("kjyearMonth", kjyearMonth);
        return card;
    }

    // ------------------------------------------------------------------ 投资计算

    @Override
    public Map<String, Object> investmentCalc(Map<String, Object> input) {
        BigDecimal invest = decimal(input.get("investAmount"));
        BigDecimal rate = decimal(input.get("discountRate"));
        if (invest.signum() <= 0) {
            throw new BizException("投资总额必须大于0");
        }
        if (rate.signum() <= 0) {
            rate = new BigDecimal("0.10");
        }
        List<BigDecimal> cashFlows = new ArrayList<BigDecimal>();
        Object flows = input.get("cashFlows");
        if (flows instanceof List && !((List<?>) flows).isEmpty()) {
            for (Object item : (List<?>) flows) {
                cashFlows.add(decimal(item));
            }
        } else {
            BigDecimal revenue = decimal(input.get("annualRevenue"));
            BigDecimal cost = decimal(input.get("annualCost"));
            int years = integer(input.get("years"), 5);
            for (int i = 0; i < years; i++) {
                cashFlows.add(revenue.subtract(cost));
            }
        }
        if (cashFlows.isEmpty()) {
            throw new BizException("请填写年度现金流或年收入/年成本");
        }
        List<Map<String, Object>> details = new ArrayList<Map<String, Object>>();
        BigDecimal cumulative = BigDecimal.ZERO;
        BigDecimal discountedCumulative = BigDecimal.ZERO;
        BigDecimal payback = null;
        BigDecimal discountedPayback = null;
        BigDecimal npv = invest.negate();
        for (int i = 0; i < cashFlows.size(); i++) {
            int period = i + 1;
            BigDecimal cf = cashFlows.get(i);
            BigDecimal discount = BigDecimal.ONE.add(rate).pow(period);
            BigDecimal present = cf.divide(discount, 6, RoundingMode.HALF_UP);
            BigDecimal before = cumulative;
            cumulative = cumulative.add(cf);
            discountedCumulative = discountedCumulative.add(present);
            npv = npv.add(present);
            if (payback == null && cumulative.compareTo(invest) >= 0) {
                BigDecimal need = invest.subtract(before);
                payback = new BigDecimal(period - 1)
                        .add(cf.signum() == 0 ? BigDecimal.ZERO : need.divide(cf, 4, RoundingMode.HALF_UP));
                discountedPayback = payback;
            }
            Map<String, Object> row = new LinkedHashMap<String, Object>();
            row.put("period", period);
            row.put("cashFlow", cf);
            row.put("presentValue", present);
            row.put("cumulative", cumulative);
            row.put("discountedCumulative", discountedCumulative);
            details.add(row);
        }
        BigDecimal irr = calcIrr(invest, cashFlows);
        BigDecimal totalFlow = BigDecimal.ZERO;
        for (BigDecimal cf : cashFlows) {
            totalFlow = totalFlow.add(cf);
        }
        BigDecimal roi = totalFlow.subtract(invest).divide(invest, 6, RoundingMode.HALF_UP);

        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("investAmount", invest);
        data.put("discountRate", rate);
        data.put("npv", npv.setScale(2, RoundingMode.HALF_UP));
        data.put("irr", irr == null ? null : irr.setScale(6, RoundingMode.HALF_UP));
        data.put("irrDisplay", irr == null ? "-" : percent(irr));
        data.put("roi", roi.setScale(6, RoundingMode.HALF_UP));
        data.put("roiDisplay", percent(roi));
        data.put("paybackPeriod", payback == null ? null : payback.setScale(2, RoundingMode.HALF_UP));
        data.put("discountedPayback", discountedPayback == null ? null : discountedPayback.setScale(2, RoundingMode.HALF_UP));
        data.put("details", details);
        data.put("conclusion", npv.signum() > 0
                ? "项目净现值为正(NPV = " + npv.setScale(2, RoundingMode.HALF_UP) + " 元)，内部收益率 " + (irr == null ? "-" : percent(irr))
                + "，高于折现率 " + percent(rate) + "，建议投资。"
                : "项目净现值为负(NPV = " + npv.setScale(2, RoundingMode.HALF_UP) + " 元)，未达到预期收益，建议重新论证投资方案。");
        return data;
    }

    private BigDecimal calcIrr(BigDecimal invest, List<BigDecimal> cashFlows) {
        double low = -0.9;
        double high = 10.0;
        double npvLow = npvAt(invest.doubleValue(), cashFlows, low);
        double npvHigh = npvAt(invest.doubleValue(), cashFlows, high);
        if (npvLow * npvHigh > 0) {
            return null;
        }
        for (int i = 0; i < 200; i++) {
            double mid = (low + high) / 2;
            double npvMid = npvAt(invest.doubleValue(), cashFlows, mid);
            if (Math.abs(npvMid) < 1e-6) {
                return new BigDecimal(mid);
            }
            if (npvLow * npvMid < 0) {
                high = mid;
                npvHigh = npvMid;
            } else {
                low = mid;
                npvLow = npvMid;
            }
        }
        return new BigDecimal((low + high) / 2);
    }

    private double npvAt(double invest, List<BigDecimal> cashFlows, double rate) {
        double npv = -invest;
        for (int i = 0; i < cashFlows.size(); i++) {
            npv += cashFlows.get(i).doubleValue() / Math.pow(1 + rate, i + 1);
        }
        return npv;
    }

    // ------------------------------------------------------------------ 损益预测

    @Override
    public Map<String, Object> profitForecast(Long orgId, String kjyearMonth, int periods) {
        int step = periods <= 0 ? 3 : periods;
        List<String> months = recentMonths(orgId, kjyearMonth);
        List<ReportResult> profits = reportResultMapper.selectByMonths(orgId, months, "P021", Constants.VALUE_BJ);
        List<ReportResult> revenues = reportResultMapper.selectByMonths(orgId, months, "P001", Constants.VALUE_BJ);
        Map<String, BigDecimal> profitMap = new LinkedHashMap<String, BigDecimal>();
        for (ReportResult result : profits) {
            profitMap.put(result.getKjyearMonth(), result.getResultValue());
        }
        Map<String, BigDecimal> revenueMap = new LinkedHashMap<String, BigDecimal>();
        for (ReportResult result : revenues) {
            revenueMap.put(result.getKjyearMonth(), result.getResultValue());
        }
        List<BigDecimal> profitHistory = new ArrayList<BigDecimal>();
        List<BigDecimal> revenueHistory = new ArrayList<BigDecimal>();
        for (String month : months) {
            profitHistory.add(nvl(profitMap.get(month)));
            revenueHistory.add(nvl(revenueMap.get(month)));
        }
        if (profitHistory.size() < 2) {
            throw new BizException("历史数据不足，至少需要 2 个月的损益数据");
        }
        BigDecimal[] profitFit = linearFit(profitHistory);
        BigDecimal[] revenueFit = linearFit(revenueHistory);
        BigDecimal profitGrowth = growthRate(profitHistory);
        BigDecimal revenueGrowth = growthRate(revenueHistory);

        List<String> forecastMonths = new ArrayList<String>();
        List<BigDecimal> profitForecast = new ArrayList<BigDecimal>();
        List<BigDecimal> revenueForecast = new ArrayList<BigDecimal>();
        for (int i = 1; i <= step; i++) {
            forecastMonths.add(DateUtil.offsetMonth(kjyearMonth, i));
            profitForecast.add(profitFit[0].add(profitFit[1].multiply(new BigDecimal(months.size() + i)))
                    .setScale(2, RoundingMode.HALF_UP));
            revenueForecast.add(revenueFit[0].add(revenueFit[1].multiply(new BigDecimal(months.size() + i)))
                    .setScale(2, RoundingMode.HALF_UP));
        }
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("orgId", orgId);
        data.put("kjyearMonth", kjyearMonth);
        data.put("historyMonths", months);
        data.put("historyProfit", profitHistory);
        data.put("historyRevenue", revenueHistory);
        data.put("forecastMonths", forecastMonths);
        data.put("forecastProfit", profitForecast);
        data.put("forecastRevenue", revenueForecast);
        data.put("profitGrowth", profitGrowth);
        data.put("revenueGrowth", revenueGrowth);
        data.put("profitTrend", profitFit[1]);
        data.put("revenueTrend", revenueFit[1]);
        StringBuilder conclusion = new StringBuilder();
        conclusion.append("以近 ").append(months.size()).append(" 个月损益数据为基础，采用线性回归与复合增长率双重校验，");
        conclusion.append("净利润月度趋势 ").append(profitFit[1].setScale(2, RoundingMode.HALF_UP)).append(" 元/月，");
        conclusion.append("平均增长率 ").append(percent(profitGrowth)).append("；");
        conclusion.append("预计 ").append(forecastMonths.get(0)).append(" ~ ").append(forecastMonths.get(forecastMonths.size() - 1));
        conclusion.append(" 营业收入 ").append(revenueForecast.get(0).toPlainString()).append(" ~ ")
                .append(revenueForecast.get(revenueForecast.size() - 1).toPlainString()).append(" 元，");
        conclusion.append("净利润 ").append(profitForecast.get(0).toPlainString()).append(" ~ ")
                .append(profitForecast.get(profitForecast.size() - 1).toPlainString()).append(" 元。");
        if (profitFit[1].signum() < 0) {
            conclusion.append("净利润呈下降趋势，建议重点管控期间费用与产品毛利。");
        } else {
            conclusion.append("净利润呈上升趋势，可维持现有经营策略并加大高毛利业务投入。");
        }
        data.put("conclusion", conclusion.toString());
        return data;
    }

    private BigDecimal[] linearFit(List<BigDecimal> values) {
        int n = values.size();
        BigDecimal sumX = BigDecimal.ZERO;
        BigDecimal sumY = BigDecimal.ZERO;
        BigDecimal sumXY = BigDecimal.ZERO;
        BigDecimal sumXX = BigDecimal.ZERO;
        for (int i = 0; i < n; i++) {
            BigDecimal x = new BigDecimal(i + 1);
            BigDecimal y = values.get(i);
            sumX = sumX.add(x);
            sumY = sumY.add(y);
            sumXY = sumXY.add(x.multiply(y));
            sumXX = sumXX.add(x.multiply(x));
        }
        BigDecimal denominator = new BigDecimal(n).multiply(sumXX).subtract(sumX.multiply(sumX));
        if (denominator.signum() == 0) {
            return new BigDecimal[]{n == 0 ? BigDecimal.ZERO : sumY.divide(new BigDecimal(n), 6, RoundingMode.HALF_UP),
                    BigDecimal.ZERO};
        }
        BigDecimal b = new BigDecimal(n).multiply(sumXY).subtract(sumX.multiply(sumY))
                .divide(denominator, 6, RoundingMode.HALF_UP);
        BigDecimal a = sumY.subtract(b.multiply(sumX)).divide(new BigDecimal(n), 6, RoundingMode.HALF_UP);
        return new BigDecimal[]{a, b};
    }

    private BigDecimal growthRate(List<BigDecimal> values) {
        if (values.size() < 2) {
            return BigDecimal.ZERO;
        }
        List<BigDecimal> rates = new ArrayList<BigDecimal>();
        for (int i = 1; i < values.size(); i++) {
            BigDecimal previous = values.get(i - 1);
            if (previous.signum() != 0) {
                rates.add(values.get(i).subtract(previous).divide(previous.abs(), 6, RoundingMode.HALF_UP));
            }
        }
        if (rates.isEmpty()) {
            return BigDecimal.ZERO;
        }
        BigDecimal sum = BigDecimal.ZERO;
        for (BigDecimal rate : rates) {
            sum = sum.add(rate);
        }
        return sum.divide(new BigDecimal(rates.size()), 6, RoundingMode.HALF_UP);
    }

    /** 供数据转换调用: 计算并返回需要持久化的算法结果 */
    public List<ReportResult> buildAlgoResults(Long orgId, String kjyearMonth, String batchId) {
        List<ReportResult> list = new ArrayList<ReportResult>();
        String[] types = new String[]{Constants.REPORT_RATIO, Constants.REPORT_DUPONT, Constants.REPORT_WARN};
        for (String type : types) {
            for (CalcResult result : calcByType(orgId, kjyearMonth, type)) {
                ReportResult rr = new ReportResult();
                rr.setBatchId(batchId);
                rr.setOrgId(orgId);
                rr.setKjyear(DateUtil.yearOf(kjyearMonth));
                rr.setKjmoth(DateUtil.monthOf(kjyearMonth));
                rr.setKjyearMonth(kjyearMonth);
                rr.setReportType(type);
                rr.setCode(result.getResultCode());
                rr.setValueType("QM");
                rr.setResultValue(result.getValue());
                rr.setDataSource("ALGO");
                rr.setCreateTime(new Date());
                list.add(rr);
            }
        }
        return list;
    }

    /** 供数据转换调用: 生成预警记录 */
    public List<WarnRecord> buildWarnRecords(Long orgId, String kjyearMonth) {
        List<WarnRecord> records = new ArrayList<WarnRecord>();
        List<CalcResult> all = new ArrayList<CalcResult>();
        all.addAll(ratioAnalysis(orgId, kjyearMonth));
        all.addAll(fundAnalysis(orgId, kjyearMonth));
        for (CalcResult result : all) {
            if (result.getWarnLevel() != null && result.getWarnLevel() > 0) {
                WarnRecord record = new WarnRecord();
                record.setOrgId(orgId);
                record.setKjyearMonth(kjyearMonth);
                record.setModeCode(result.getModeCode());
                record.setResultCode(result.getResultCode());
                record.setResultName(result.getResultName());
                record.setResultValue(result.getValue());
                record.setWarnLevel(result.getWarnLevel());
                record.setWarnDesc(result.getWarnDesc());
                record.setAdvise(result.getAdvise());
                record.setCreateTime(new Date());
                records.add(record);
            }
        }
        return records;
    }

    // ------------------------------------------------------------------ 工具

    private BigDecimal decimal(Object value) {
        if (value == null) {
            return BigDecimal.ZERO;
        }
        if (value instanceof BigDecimal) {
            return (BigDecimal) value;
        }
        if (value instanceof Number) {
            return new BigDecimal(value.toString());
        }
        String text = String.valueOf(value).trim().replace(",", "").replace("%", "");
        if (text.isEmpty()) {
            return BigDecimal.ZERO;
        }
        try {
            return new BigDecimal(text);
        } catch (NumberFormatException e) {
            throw new BizException("数值格式错误: " + value);
        }
    }

    private int integer(Object value, int defaultValue) {
        if (value == null) {
            return defaultValue;
        }
        try {
            return new BigDecimal(String.valueOf(value)).intValue();
        } catch (Exception e) {
            return defaultValue;
        }
    }

    /** 校验表达式(供算法配置与外部调用) */
    public void validateExpression(String expression) {
        ExpressionEvaluator.validate(expression);
    }

    @Override
    public AnalysisReport saveInvestmentReport(Map<String, Object> input) {
        String month = input.get("kjyearMonth") == null ? DateUtil.currentYearMonth()
                : String.valueOf(input.get("kjyearMonth"));
        AnalysisReport report = new AnalysisReport();
        report.setReportCode("INVEST-" + month);
        report.setReportName(input.get("reportName") == null ? "投资预测报告" : String.valueOf(input.get("reportName")));
        report.setReportType("INVESTMENT");
        report.setOrgId(input.get("orgId") == null ? 1L : Long.valueOf(String.valueOf(input.get("orgId"))));
        report.setKjyearMonth(month);
        report.setSummary(input.get("summary") == null ? "" : String.valueOf(input.get("summary")));
        report.setContent(input.get("content") == null ? "" : String.valueOf(input.get("content")));
        report.setCreator(input.get("creator") == null ? "system" : String.valueOf(input.get("creator")));
        report.setCreateTime(new Date());
        analysisReportMapper.insert(report);
        return report;
    }

    @Override
    public List<AnalysisReport> investmentReports() {
        return analysisReportMapper.selectAll();
    }
}
