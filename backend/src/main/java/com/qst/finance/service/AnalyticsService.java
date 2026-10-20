package com.qst.finance.service;

import com.qst.finance.common.DbUtils;
import com.qst.finance.common.FormulaUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class AnalyticsService {
    private final JdbcTemplate jdbc;

    public AnalyticsService(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public String latestPeriod(String orgId) {
        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT MAX(KJYEAR_MOTH) AS p FROM ("
                        + "SELECT KJYEAR_MOTH FROM t_basi_profit WHERE ORG_ID=? "
                        + "UNION ALL SELECT KJYEAR_MOTH FROM t_basi_assets_and_liabilities WHERE ORG_ID=? "
                        + "UNION ALL SELECT KJYEAR_MOTH FROM t_basi_cash_flow WHERE ORG_ID=?"
                        + ") x", orgId, orgId, orgId);
        if (rows.isEmpty() || rows.get(0).get("p") == null) {
            return new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
        }
        return String.valueOf(rows.get(0).get("p"));
    }

    public String previousPeriod(String orgId, String period) {
        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT MAX(KJYEAR_MOTH) AS p FROM ("
                        + "SELECT KJYEAR_MOTH FROM t_basi_profit WHERE ORG_ID=? AND KJYEAR_MOTH<? "
                        + "UNION ALL SELECT KJYEAR_MOTH FROM t_basi_assets_and_liabilities WHERE ORG_ID=? AND KJYEAR_MOTH<?"
                        + ") x", orgId, period, orgId, period);
        return rows.isEmpty() || rows.get(0).get("p") == null ? null : String.valueOf(rows.get(0).get("p"));
    }

    public Map<String, Object> raw(String table, String orgId, String period) {
        Map<String, Object> row = DbUtils.queryOne(jdbc,
                "SELECT * FROM " + table + " WHERE ORG_ID=? AND KJYEAR_MOTH=? ORDER BY IMP_TIME DESC LIMIT 1",
                orgId, period);
        return row == null ? new LinkedHashMap<String, Object>() : row;
    }

    public Map<String, Object> org(String orgId) {
        Map<String, Object> row = DbUtils.queryOne(jdbc, "SELECT * FROM t_org_info WHERE id=?", orgId);
        return row == null ? new LinkedHashMap<String, Object>() : row;
    }

    public Map<String, Object> resultMap(String orgId, String period) {
        Map<String, Object> map = new LinkedHashMap<String, Object>();
        if (period == null || period.isEmpty()) {
            period = latestPeriod(orgId);
        }
        for (Map<String, Object> row : DbUtils.query(jdbc,
                "SELECT CODE_NO, DATA_VALUE FROM t_report_result WHERE ORG_ID=? AND RYEAR_AND_MONTH=?",
                orgId, period)) {
            map.put(DbUtils.str(row, "codeNo"), DbUtils.num(row, "dataValue"));
        }
        return map;
    }

    public Map<String, Object> overview(String orgId, String period) {
        if (period == null || period.isEmpty()) {
            period = latestPeriod(orgId);
        }
        Map<String, Object> assets = raw("t_basi_assets_and_liabilities", orgId, period);
        Map<String, Object> profit = raw("t_basi_profit", orgId, period);
        Map<String, Object> cash = raw("t_basi_cash_flow", orgId, period);
        Map<String, Object> ratios = ratios(assets, profit, cash);
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("period", period);
        data.put("org", org(orgId));
        data.put("revenue", DbUtils.num(profit, "byZyywsr"));
        data.put("netProfit", DbUtils.num(profit, "byJlr"));
        data.put("totalAssets", DbUtils.num(assets, "qmZczj"));
        data.put("totalLiabilities", DbUtils.num(assets, "qmDysxFzhj"));
        data.put("cash", DbUtils.num(assets, "qmLdzcHbzj"));
        data.put("operatingCash", cashOperating(cash));
        data.put("healthScore", healthScore(ratios));
        data.put("ratios", ratios);
        data.put("alerts", alerts(ratios, assets, profit, cash));
        return data;
    }

    public Map<String, Object> ratios(Map<String, Object> assets, Map<String, Object> profit,
                                      Map<String, Object> cash) {
        double currentAssets = DbUtils.num(assets, "qmLdzcHj");
        double currentLiabilities = DbUtils.num(assets, "qmLdfzLdfzhj");
        double inventory = DbUtils.num(assets, "qmLdzcCh");
        double cashValue = DbUtils.num(assets, "qmLdzcHbzj");
        double receivables = DbUtils.num(assets, "qmLdzcYszk");
        double totalAssets = DbUtils.num(assets, "qmZczj");
        double totalLiabilities = DbUtils.num(assets, "qmDysxFzhj");
        double equity = DbUtils.num(assets, "qmGdqySyzqyhj");
        if (equity == 0D) {
            equity = totalAssets - totalLiabilities;
        }
        double revenue = DbUtils.num(profit, "byZyywsr");
        double cost = DbUtils.num(profit, "byZyywcb");
        double operatingProfit = DbUtils.num(profit, "byYylr");
        double totalProfit = DbUtils.num(profit, "byLrze");
        double netProfit = DbUtils.num(profit, "byJlr");
        double financeExpense = DbUtils.num(profit, "byCwfy");
        double operatingCash = cashOperating(cash);
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        result.put("shortTerm", category("短期偿债能力", new Object[][]{
                {"流动比率", "currentRatio", FormulaUtils.div(currentAssets, currentLiabilities), "倍", "流动资产 / 流动负债", ">=2 稳健"},
                {"速动比率", "quickRatio", FormulaUtils.div(currentAssets - inventory, currentLiabilities), "倍", "(流动资产-存货) / 流动负债", ">=1 稳健"},
                {"现金比率", "cashRatio", FormulaUtils.div(cashValue, currentLiabilities), "倍", "货币资金 / 流动负债", ">=0.3 稳健"},
                {"营运资金", "workingCapital", currentAssets - currentLiabilities, "元", "流动资产 - 流动负债", ">0 稳健"}
        }));
        result.put("longTerm", category("长期偿债能力", new Object[][]{
                {"资产负债率", "debtRatio", FormulaUtils.div(totalLiabilities, totalAssets), "%", "负债总额 / 资产总额", "<=60% 稳健"},
                {"产权比率", "equityRatio", FormulaUtils.div(totalLiabilities, equity), "倍", "负债总额 / 所有者权益", "<=1.5 稳健"},
                {"权益乘数", "equityMultiplier", FormulaUtils.div(totalAssets, equity), "倍", "资产总额 / 所有者权益", "<=2.5 稳健"},
                {"利息保障倍数", "interestCoverage", FormulaUtils.div(operatingProfit + financeExpense, financeExpense), "倍", "(营业利润+财务费用) / 财务费用", ">=3 稳健"}
        }));
        result.put("profitability", category("盈利能力", new Object[][]{
                {"毛利率", "grossMargin", FormulaUtils.div(revenue - cost, revenue), "%", "(营业收入-营业成本) / 营业收入", ">=20% 良好"},
                {"营业利润率", "operatingMargin", FormulaUtils.div(operatingProfit, revenue), "%", "营业利润 / 营业收入", ">=10% 良好"},
                {"净利率", "netMargin", FormulaUtils.div(netProfit, revenue), "%", "净利润 / 营业收入", ">=5% 良好"},
                {"总资产报酬率", "roa", FormulaUtils.div(netProfit, totalAssets), "%", "净利润 / 资产总额", ">=5% 良好"},
                {"净资产收益率", "roe", FormulaUtils.div(netProfit, equity), "%", "净利润 / 所有者权益", ">=8% 良好"}
        }));
        result.put("operation", category("营运能力", new Object[][]{
                {"应收账款周转率", "receivableTurnover", FormulaUtils.div(revenue, receivables), "次", "营业收入 / 应收账款", ">=4 次良好"},
                {"存货周转率", "inventoryTurnover", FormulaUtils.div(cost, inventory), "次", "营业成本 / 存货", ">=3 次良好"},
                {"总资产周转率", "assetTurnover", FormulaUtils.div(revenue, totalAssets), "次", "营业收入 / 资产总额", ">=0.6 次良好"},
                {"经营现金净流量", "operatingCash", operatingCash, "元", "经营活动现金流量净额", ">0 良好"}
        }));
        return result;
    }

    private Map<String, Object> category(String name, Object[][] rows) {
        Map<String, Object> category = new LinkedHashMap<String, Object>();
        category.put("name", name);
        List<Map<String, Object>> items = new ArrayList<Map<String, Object>>();
        for (Object[] row : rows) {
            Map<String, Object> item = new LinkedHashMap<String, Object>();
            item.put("name", row[0]);
            item.put("key", row[1]);
            double value = ((Number) row[2]).doubleValue();
            boolean percent = "%".equals(row[3]);
            item.put("value", percent ? FormulaUtils.percent(value) : FormulaUtils.round(value, 2));
            item.put("unit", row[3]);
            item.put("formula", row[4]);
            item.put("benchmark", row[5]);
            item.put("status", status((String) row[1], value));
            items.add(item);
        }
        category.put("items", items);
        return category;
    }

    private String status(String key, double value) {
        if ("currentRatio".equals(key)) return value >= 2 ? "good" : value >= 1 ? "watch" : "risk";
        if ("quickRatio".equals(key)) return value >= 1 ? "good" : value >= 0.6 ? "watch" : "risk";
        if ("cashRatio".equals(key)) return value >= 0.3 ? "good" : value >= 0.15 ? "watch" : "risk";
        if ("workingCapital".equals(key)) return value > 0 ? "good" : "risk";
        if ("debtRatio".equals(key)) return value <= 0.6 ? "good" : value <= 0.75 ? "watch" : "risk";
        if ("equityRatio".equals(key)) return value <= 1.5 ? "good" : value <= 2.2 ? "watch" : "risk";
        if ("equityMultiplier".equals(key)) return value <= 2.5 ? "good" : value <= 4 ? "watch" : "risk";
        if ("interestCoverage".equals(key)) return value >= 3 ? "good" : value >= 1.5 ? "watch" : "risk";
        if ("grossMargin".equals(key)) return value >= 0.2 ? "good" : value >= 0.1 ? "watch" : "risk";
        if ("operatingMargin".equals(key)) return value >= 0.1 ? "good" : value >= 0.03 ? "watch" : "risk";
        if ("netMargin".equals(key)) return value >= 0.05 ? "good" : value >= 0 ? "watch" : "risk";
        if ("roa".equals(key)) return value >= 0.05 ? "good" : value >= 0.02 ? "watch" : "risk";
        if ("roe".equals(key)) return value >= 0.08 ? "good" : value >= 0.03 ? "watch" : "risk";
        if ("receivableTurnover".equals(key)) return value >= 4 ? "good" : value >= 2 ? "watch" : "risk";
        if ("inventoryTurnover".equals(key)) return value >= 3 ? "good" : value >= 1.5 ? "watch" : "risk";
        if ("assetTurnover".equals(key)) return value >= 0.6 ? "good" : value >= 0.3 ? "watch" : "risk";
        return value > 0 ? "good" : "watch";
    }

    public double cashOperating(Map<String, Object> cash) {
        double value = DbUtils.num(cash, "bqJyhdJyhdcsdje");
        if (value == 0D) {
            value = DbUtils.num(cash, "jyhdJyhdcsdje");
        }
        return value;
    }

    public double healthScore(Map<String, Object> ratios) {
        int good = 0;
        int total = 0;
        for (Object categoryObject : ratios.values()) {
            Map<String, Object> category = (Map<String, Object>) categoryObject;
            List<Map<String, Object>> items = (List<Map<String, Object>>) category.get("items");
            for (Map<String, Object> item : items) {
                total++;
                if ("good".equals(item.get("status"))) {
                    good++;
                }
            }
        }
        return total == 0 ? 60D : FormulaUtils.round(55D + 45D * good / total, 1);
    }

    public List<Map<String, Object>> alerts(Map<String, Object> ratios, Map<String, Object> assets,
                                            Map<String, Object> profit, Map<String, Object> cash) {
        List<Map<String, Object>> alerts = new ArrayList<Map<String, Object>>();
        for (Object categoryObject : ratios.values()) {
            Map<String, Object> category = (Map<String, Object>) categoryObject;
            List<Map<String, Object>> items = (List<Map<String, Object>>) category.get("items");
            for (Map<String, Object> item : items) {
                if (!"risk".equals(item.get("status"))) {
                    continue;
                }
                Map<String, Object> alert = new LinkedHashMap<String, Object>();
                alert.put("level", "high");
                alert.put("title", item.get("name") + "需关注");
                alert.put("value", item.get("value") + String.valueOf(item.get("unit")));
                alert.put("benchmark", item.get("benchmark"));
                alert.put("suggestion", suggestion(String.valueOf(item.get("key"))));
                alerts.add(alert);
            }
        }
        if (alerts.isEmpty()) {
            Map<String, Object> alert = new LinkedHashMap<String, Object>();
            alert.put("level", "info");
            alert.put("title", "核心指标运行平稳");
            alert.put("value", "未发现高风险指标");
            alert.put("benchmark", "持续跟踪");
            alert.put("suggestion", "建议保持月度复盘，关注收入、应收账款和经营现金流的变化。");
            alerts.add(alert);
        }
        return alerts;
    }

    private String suggestion(String key) {
        if (key.contains("Ratio") && !key.contains("Turnover")) {
            return "建议优化债务结构，控制短期借款规模，并加强回款和现金储备。";
        }
        if (key.contains("Margin") || "roa".equals(key) || "roe".equals(key)) {
            return "建议复核成本费用结构，提升高毛利产品占比，并控制期间费用。";
        }
        if (key.contains("Turnover")) {
            return "建议加强信用政策、催收和库存管理，提升资产周转效率。";
        }
        return "建议结合经营计划持续跟踪该指标。";
    }

    public Map<String, Object> reportDetail(String orgId, String period, String type) {
        if (period == null || period.isEmpty()) {
            period = latestPeriod(orgId);
        }
        String prefix = "balance".equals(type) ? "ZCFZ-" : "profit".equals(type) ? "LR-" : "XJLL-";
        List<Map<String, Object>> items = DbUtils.query(jdbc,
                "SELECT r.CODE_NO, c.CODE_NAME, r.DATA_VALUE FROM t_report_result r "
                        + "LEFT JOIN t_code_libr c ON c.CODE_NO=r.CODE_NO "
                        + "WHERE r.ORG_ID=? AND r.RYEAR_AND_MONTH=? AND r.CODE_NO LIKE ? "
                        + "ORDER BY CAST(SUBSTRING(r.CODE_NO, LOCATE('-', r.CODE_NO)+1) AS UNSIGNED)",
                orgId, period, prefix + "%");
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("period", period);
        data.put("type", type);
        data.put("items", items);
        data.put("summary", DbUtils.queryOne(jdbc,
                "SELECT COUNT(*) AS itemCount, SUM(r.DATA_VALUE) AS totalValue FROM t_report_result r "
                        + "WHERE r.ORG_ID=? AND r.RYEAR_AND_MONTH=? AND r.CODE_NO LIKE ?",
                orgId, period, prefix + "%"));
        return data;
    }

    public Map<String, Object> trend(String orgId, String code) {
        List<Map<String, Object>> rows = DbUtils.query(jdbc,
                "SELECT RYEAR_AND_MONTH, DATA_VALUE FROM t_report_result WHERE ORG_ID=? AND CODE_NO=? "
                        + "ORDER BY RYEAR_AND_MONTH", orgId, code);
        List<String> periods = new ArrayList<String>();
        List<Double> values = new ArrayList<Double>();
        for (Map<String, Object> row : rows) {
            periods.add(DbUtils.str(row, "ryearAndMonth"));
            values.add(DbUtils.num(row, "dataValue"));
        }
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("code", code);
        data.put("periods", periods);
        data.put("values", values);
        data.put("name", DbUtils.str(DbUtils.queryOne(jdbc, "SELECT CODE_NAME FROM t_code_libr WHERE CODE_NO=?", code),
                "codeName", code));
        return data;
    }

    public Map<String, Object> aging(String orgId, int type, String period) {
        if (period == null || period.isEmpty()) {
            period = latestPeriod(orgId);
        }
        List<Map<String, Object>> rows = DbUtils.query(jdbc,
                "SELECT * FROM t_age_analysis WHERE ORG_ID=? AND KJYEAR_MOTH=? AND `type`=? ORDER BY BALANCE DESC",
                orgId, period, type);
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("period", period);
        data.put("type", type);
        data.put("rows", rows);
        double total = 0D;
        double[] buckets = new double[6];
        for (Map<String, Object> row : rows) {
            total += DbUtils.num(row, "balance");
            buckets[0] += DbUtils.num(row, "due1To30Days");
            buckets[1] += DbUtils.num(row, "due31To90Days");
            buckets[2] += DbUtils.num(row, "due91To180Days");
            buckets[3] += DbUtils.num(row, "due181To360Days");
            buckets[4] += DbUtils.num(row, "due361To720Days");
            buckets[5] += DbUtils.num(row, "due721To1080Days");
        }
        Map<String, Object> summary = new LinkedHashMap<String, Object>();
        summary.put("total", total);
        summary.put("labels", new String[]{"0-90天", "91-180天", "181-360天", "361-720天", "721-1080天", "1080天以上"});
        summary.put("values", buckets);
        data.put("summary", summary);
        data.put("title", agingTitle(type));
        String year = period.substring(0, 4);
        String previousYear = String.valueOf(Integer.parseInt(year) - 1);
        int currentYear = Integer.parseInt(year);
        List<Map<String, Object>> trendRows = DbUtils.query(jdbc,
                "SELECT KJYEAR_MOTH AS period, SUM(BALANCE) AS balance FROM t_age_analysis "
                        + "WHERE ORG_ID=? AND `type`=? AND KJYEAR IN (?,?) "
                        + "GROUP BY KJYEAR_MOTH ORDER BY KJYEAR_MOTH",
                orgId, type, previousYear, year);
        List<String> yearPeriods = new ArrayList<String>();
        List<Double> yearValues = new ArrayList<Double>();
        List<Double> previousValues = new ArrayList<Double>();
        Map<String, Double> balances = new LinkedHashMap<String, Double>();
        for (Map<String, Object> row : trendRows) {
            balances.put(DbUtils.str(row, "period"), DbUtils.num(row, "balance"));
        }
        double yearTotal = 0D;
        for (int month = 1; month <= 12; month++) {
            String key = currentYear + String.format("%02d", month);
            double value = balances.containsKey(key) ? balances.get(key) : 0D;
            String priorKey = (currentYear - 1) + String.format("%02d", month);
            yearPeriods.add(key);
            yearValues.add(FormulaUtils.round(value / 10000D, 2));
            previousValues.add(FormulaUtils.round(
                    (balances.containsKey(priorKey) ? balances.get(priorKey) : 0D) / 10000D, 2));
            yearTotal += value;
        }
        data.put("trendPeriods", yearPeriods);
        data.put("trendValues", yearValues);
        data.put("previousTrendValues", previousValues);
        data.put("yearTotal", FormulaUtils.round(yearTotal / 10000D, 2));
        data.put("periodStart", year + "01");
        data.put("periodEnd", period);
        double agedTotal = 0D;
        for (double bucket : buckets) {
            agedTotal += bucket;
        }
        List<Double> percentages = new ArrayList<Double>();
        for (double bucket : buckets) {
            percentages.add(agedTotal == 0D ? 0D : FormulaUtils.round(bucket / agedTotal * 100D, 2));
        }
        data.put("percentages", percentages);
        return data;
    }

    private String agingTitle(int type) {
        switch (type) {
            case 3: return "其他应付款";
            case 4: return "其他应收款";
            case 5: return "应付账款";
            case 6: return "应收账款";
            case 7: return "预付账款";
            case 8: return "预收账款";
            case 9: return "产成品";
            case 10: return "原材料";
            default: return "账龄分析";
        }
    }

    public Map<String, Object> annualProfit(String orgId, String year) {
        Map<String, Object> current = annualProfitSums(orgId, year);
        int previousYear = Integer.parseInt(year) - 1;
        Map<String, Object> previous = annualProfitSums(orgId, String.valueOf(previousYear));
        String[][] definitions = {
                {"ZYYWSR", "营业收入", "yuan"},
                {"ZYYWCB", "营业成本", "yuan"},
                {"ZYYWSJJFJ", "税金及附加", "yuan"},
                {"XSFY", "销售费用", "yuan"},
                {"GLFY", "管理费用", "yuan"},
                {"CWFY", "财务费用", "yuan"},
                {"ZCJZSS", "资产减值损失", "yuan"},
                {"GYJZBDSY", "公允价值变动收益", "yuan"},
                {"TZSY", "投资收益", "yuan"},
                {"ZCCZSY", "资产处置收益", "yuan"},
                {"QTSY", "其他收益", "yuan"},
                {"HYSY", "汇兑收益", "yuan"},
                {"YYLR", "营业利润", "yuan"},
                {"YYWSR", "营业外收入", "yuan"},
                {"YYWZC", "营业外支出", "yuan"},
                {"LRZE", "利润总额", "yuan"},
                {"JLR", "净利润", "yuan"}
        };
        List<Map<String, Object>> items = new ArrayList<Map<String, Object>>();
        for (String[] definition : definitions) {
            double value = field(current, definition[0]);
            double prior = field(previous, definition[0]);
            Map<String, Object> item = new LinkedHashMap<String, Object>();
            item.put("field", definition[0]);
            item.put("name", definition[1]);
            item.put("value", FormulaUtils.round(value / 10000D, 2));
            item.put("previous", FormulaUtils.round(prior / 10000D, 2));
            item.put("yoy", prior == 0D ? 0D : FormulaUtils.round((value - prior) / Math.abs(prior) * 100D, 2));
            item.put("mom", item.get("yoy"));
            items.add(item);
        }
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        result.put("year", year);
        result.put("previousYear", String.valueOf(previousYear));
        result.put("items", items);
        result.put("netProfit", FormulaUtils.round(field(current, "JLR") / 10000D, 2));
        result.put("previousNetProfit", FormulaUtils.round(field(previous, "JLR") / 10000D, 2));
        return result;
    }

    private Map<String, Object> annualProfitSums(String orgId, String year) {
        Map<String, Object> row = DbUtils.queryOne(jdbc,
                "SELECT SUM(BY_ZYYWSR)+0 AS ZYYWSR,SUM(BY_ZYYWCB)+0 AS ZYYWCB,"
                        + "SUM(BY_ZYYWSJJFJ)+0 AS ZYYWSJJFJ,SUM(BY_XSFY)+0 AS XSFY,SUM(BY_GLFY)+0 AS GLFY,"
                        + "SUM(BY_CWFY)+0 AS CWFY,SUM(BY_ZCJZSS)+0 AS ZCJZSS,SUM(BY_GYJZBDSY)+0 AS GYJZBDSY,"
                        + "SUM(BY_TZSY)+0 AS TZSY,SUM(BY_ZCCZSY)+0 AS ZCCZSY,SUM(BY_QTSY)+0 AS QTSY,"
                        + "SUM(BY_HYSY)+0 AS HYSY,SUM(BY_YYLR)+0 AS YYLR,SUM(BY_YYWSR)+0 AS YYWSR,"
                        + "SUM(BY_YYWZC)+0 AS YYWZC,SUM(BY_LRZE)+0 AS LRZE,SUM(BY_JLR)+0 AS JLR "
                        + "FROM t_basi_profit WHERE ORG_ID=? AND KJYEAR=?",
                orgId, year);
        return row == null ? new LinkedHashMap<String, Object>() : row;
    }

    private double field(Map<String, Object> row, String field) {
        return DbUtils.num(row, field.toLowerCase());
    }

    public Map<String, Object> statementOverview(String orgId, String period) {
        if (period == null || period.isEmpty()) {
            period = latestPeriod(orgId);
        }
        String year = period.substring(0, 4);
        String priorPeriod = (Integer.parseInt(year) - 1) + period.substring(4);
        Map<String, Object> assets = raw("t_basi_assets_and_liabilities", orgId, period);
        Map<String, Object> priorAssets = raw("t_basi_assets_and_liabilities", orgId, priorPeriod);
        Map<String, Object> profit = raw("t_basi_profit", orgId, period);
        Map<String, Object> priorProfit = raw("t_basi_profit", orgId, priorPeriod);
        double totalAssets = DbUtils.num(assets, "qmZczj");
        double priorTotalAssets = DbUtils.num(priorAssets, "qmZczj");
        double liabilities = DbUtils.num(assets, "qmDysxFzhj");
        double priorLiabilities = DbUtils.num(priorAssets, "qmDysxFzhj");
        double equity = DbUtils.num(assets, "qmGdqySyzqyhj");
        double priorEquity = DbUtils.num(priorAssets, "qmGdqySyzqyhj");
        double receivables = DbUtils.num(assets, "qmLdzcYszk");
        double priorReceivables = DbUtils.num(priorAssets, "qmLdzcYszk");
        double longPayable = DbUtils.num(assets, "qmFldfzCqyfk");
        double priorLongPayable = DbUtils.num(priorAssets, "qmFldfzCqyfk");
        List<Map<String, Object>> trend = DbUtils.query(jdbc,
                "SELECT KJYEAR_MOTH AS period,QM_ZCZJ AS assets,QM_DYSX_FZHJ AS liabilities,"
                        + "QM_GDQY_SYZQYHJ AS equity FROM t_basi_assets_and_liabilities "
                        + "WHERE ORG_ID=? ORDER BY KJYEAR_MOTH", orgId);
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        result.put("period", period);
        result.put("year", year);
        result.put("assetTotal", FormulaUtils.round(totalAssets / 10000D, 2));
        result.put("liabilityTotal", FormulaUtils.round(liabilities / 10000D, 2));
        result.put("equityTotal", FormulaUtils.round(equity / 10000D, 2));
        result.put("assetYoy", growthPercent(totalAssets, priorTotalAssets));
        result.put("liabilityYoy", growthPercent(liabilities, priorLiabilities));
        result.put("equityYoy", growthPercent(equity, priorEquity));
        result.put("revenue", FormulaUtils.round(DbUtils.num(profit, "byZyywsr") / 10000D, 2));
        result.put("netProfit", FormulaUtils.round(DbUtils.num(profit, "byJlr") / 10000D, 2));
        result.put("previousNetProfit", FormulaUtils.round(DbUtils.num(priorProfit, "byJlr") / 10000D, 2));
        result.put("trend", trend);
        double assetChange = totalAssets - priorTotalAssets;
        result.put("receivableCurrent", FormulaUtils.round(receivables / 10000D, 2));
        result.put("receivablePrior", FormulaUtils.round(priorReceivables / 10000D, 2));
        result.put("receivableGrowth", growthPercent(receivables, priorReceivables));
        result.put("receivableAssetShare", assetChange == 0D ? 0D
                : FormulaUtils.round((receivables - priorReceivables) / assetChange * 100D, 2));
        result.put("longPayableCurrent", FormulaUtils.round(longPayable / 10000D, 2));
        result.put("longPayablePrior", FormulaUtils.round(priorLongPayable / 10000D, 2));
        String narrative = "本期总资产较上年同期有所增长，主要是因为应收账款从上年同期的Rmb"
                + String.format(java.util.Locale.CHINA, "%.2f", priorReceivables / 10000D)
                + "万元增至本期的Rmb" + String.format(java.util.Locale.CHINA, "%.2f", receivables / 10000D)
                + "万元，增长率达" + growthPercent(receivables, priorReceivables)
                + "%，占总资产变动的" + (assetChange == 0D ? "0.00"
                : String.format(java.util.Locale.CHINA, "%.2f",
                (receivables - priorReceivables) / assetChange * 100D)) + "%。";
        if (longPayable > priorLongPayable) {
            narrative += "此外，总负债较上年同期有所增加，主要是因为长期应付款增加。";
        } else {
            narrative += "此外，负债结构总体保持稳定。";
        }
        result.put("narrative", narrative);
        result.put("alerts", new ArrayList<Map<String, Object>>());
        return result;
    }

    private double growthPercent(double current, double previous) {
        return previous == 0D ? 0D : FormulaUtils.round((current - previous) / Math.abs(previous) * 100D, 2);
    }

    public Map<String, Object> ratioComparison(String orgId, String period) {
        if (period == null || period.isEmpty()) {
            period = latestPeriod(orgId);
        }
        String year = period.substring(0, 4);
        String priorPeriod = (Integer.parseInt(year) - 1) + period.substring(4);
        Map<String, Object> assets = raw("t_basi_assets_and_liabilities", orgId, period);
        Map<String, Object> priorAssets = raw("t_basi_assets_and_liabilities", orgId, priorPeriod);
        Map<String, Object> profit = raw("t_basi_profit", orgId, period);
        Map<String, Object> priorProfit = raw("t_basi_profit", orgId, priorPeriod);
        Map<String, Object> cash = raw("t_basi_cash_flow", orgId, period);
        Map<String, Object> priorCash = raw("t_basi_cash_flow", orgId, priorPeriod);
        Map<String, Object> values = ratioValues(assets, profit, cash);
        Map<String, Object> priorValues = ratioValues(priorAssets, priorProfit, priorCash);
        Object[][] longTerm = {
                {"debtRatio", "资产负债率", "%"},
                {"equityRatio", "产权比率", "倍"},
                {"equityMultiplier", "权益乘数", "倍"},
                {"longCapitalDebtRatio", "长期资本负债率", "%"},
                {"cashFlowDebtRatio", "现金流量债务比", "%"}
        };
        Object[][] shortTerm = {
                {"workingCapital", "营运资本（万元）", "万元"},
                {"currentRatio", "流动比率", "倍"},
                {"quickRatio", "速动比率", "倍"},
                {"cashRatio", "现金比率", "倍"},
                {"cashFlowRatio", "现金流量比率", "倍"}
        };
        List<Map<String, Object>> categories = new ArrayList<Map<String, Object>>();
        categories.add(comparisonCategory("长期偿债能力", longTerm, values, priorValues));
        categories.add(comparisonCategory("短期偿债能力", shortTerm, values, priorValues));
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        result.put("period", period);
        result.put("year", year);
        result.put("categories", categories);
        return result;
    }

    private Map<String, Object> comparisonCategory(String title, Object[][] definitions,
                                                   Map<String, Object> current, Map<String, Object> prior) {
        Map<String, Object> category = new LinkedHashMap<String, Object>();
        category.put("name", title);
        List<Map<String, Object>> items = new ArrayList<Map<String, Object>>();
        for (Object[] definition : definitions) {
            String key = String.valueOf(definition[0]);
            Map<String, Object> item = new LinkedHashMap<String, Object>();
            item.put("key", key);
            item.put("name", definition[1]);
            item.put("unit", definition[2]);
            item.put("value", current.get(key));
            item.put("yearAgo", prior.get(key));
            item.put("prevPeriod", prior.get(key));
            items.add(item);
        }
        category.put("items", items);
        return category;
    }

    private Map<String, Object> ratioValues(Map<String, Object> assets, Map<String, Object> profit,
                                            Map<String, Object> cash) {
        double currentAssets = DbUtils.num(assets, "qmLdzcHj");
        double currentLiabilities = DbUtils.num(assets, "qmLdfzLdfzhj");
        double inventory = DbUtils.num(assets, "qmLdzcCh");
        double cashValue = DbUtils.num(assets, "qmLdzcHbzj") + DbUtils.num(assets, "qmLdzcJyxjrzc");
        double prepayments = DbUtils.num(assets, "qmLdzcYfzk");
        double otherCurrent = DbUtils.num(assets, "qmLdzcQtldzc");
        double totalAssets = DbUtils.num(assets, "qmZczj");
        double totalLiabilities = DbUtils.num(assets, "qmDysxFzhj");
        double equity = DbUtils.num(assets, "qmGdqySyzqyhj");
        double nonCurrentLiabilities = DbUtils.num(assets, "qmFldfzCqfzhj");
        double operatingCash = cashOperating(cash);
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        result.put("debtRatio", FormulaUtils.round(FormulaUtils.div(totalLiabilities, totalAssets) * 100D, 2));
        result.put("equityRatio", FormulaUtils.round(FormulaUtils.div(totalLiabilities, equity), 2));
        result.put("equityMultiplier", FormulaUtils.round(FormulaUtils.div(totalAssets, equity), 2));
        result.put("longCapitalDebtRatio", FormulaUtils.round(
                FormulaUtils.div(nonCurrentLiabilities, nonCurrentLiabilities + equity) * 100D, 2));
        result.put("cashFlowDebtRatio", FormulaUtils.round(
                Math.max(0D, FormulaUtils.div(operatingCash, totalLiabilities)) * 100D, 2));
        result.put("workingCapital", FormulaUtils.round((currentAssets - currentLiabilities) / 10000D, 2));
        result.put("currentRatio", FormulaUtils.round(FormulaUtils.div(currentAssets, currentLiabilities), 2));
        result.put("quickRatio", roundDown(
                FormulaUtils.div(currentAssets - inventory - prepayments - otherCurrent, currentLiabilities), 2));
        result.put("cashRatio", FormulaUtils.round(FormulaUtils.div(cashValue, currentLiabilities), 2));
        result.put("cashFlowRatio", FormulaUtils.round(
                Math.max(0D, FormulaUtils.div(operatingCash, currentLiabilities)), 2));
        return result;
    }

    private double roundDown(double value, int scale) {
        double factor = Math.pow(10D, scale);
        return value >= 0D ? Math.floor(value * factor) / factor : Math.ceil(value * factor) / factor;
    }

    public Map<String, Object> homeReport(String orgId, String period) {
        Map<String, Object> overview = overview(orgId, period);
        Map<String, Object> org = (Map<String, Object>) overview.get("org");
        String reportPeriod = String.valueOf(overview.get("period"));
        String reportYear = reportPeriod.substring(0, 4);
        Map<String, Object> annualCurrent = annualProfitSums(orgId, reportYear);
        Map<String, Object> annualPrior = annualProfitSums(orgId, String.valueOf(Integer.parseInt(reportYear) - 1));
        double currentProfitWan = FormulaUtils.round(field(annualCurrent, "JLR") / 10000D, 2);
        double priorProfitWan = FormulaUtils.round(field(annualPrior, "JLR") / 10000D, 2);
        Map<String, Object> annualCashRow = DbUtils.queryOne(jdbc,
                "SELECT SUM(BQ_JYHD_JYHDCSDJE)+0 AS operatingCash FROM t_basi_cash_flow "
                        + "WHERE ORG_ID=? AND KJYEAR=?", orgId, reportYear);
        double annualOperatingCash = DbUtils.num(annualCashRow, "operatingCash");
        double profitChange = FormulaUtils.round(currentProfitWan - priorProfitWan, 2);
        String profitNarrative;
        if (profitChange < 0) {
            profitNarrative = "本期净利润比上期有所下降，减少金额达 Rmb"
                    + String.format(java.util.Locale.CHINA, "%,.2f", Math.abs(profitChange))
                    + " 万元。净利润下降主要是因为营业成本的增加，建议到分析模块查看具体科目变动原因及相关预警。";
        } else if (profitChange > 0) {
            profitNarrative = "本期净利润比上期有所增长，增加金额达 Rmb"
                    + String.format(java.util.Locale.CHINA, "%,.2f", profitChange)
                    + " 万元。建议到分析模块查看收入、成本和费用变动原因，并关注相关预警。";
        } else {
            profitNarrative = "本期净利润与上期基本持平，建议到分析模块查看收入、成本和费用变动原因。";
        }
        String cashNarrative = annualOperatingCash >= 0D
                ? "本期现金流较好，现金及现金等价物净增加额为正数，主要是因为经营活动产生的现金流量净额的增加所引起，现金流较为健康。"
                + "筹资活动产生的现金流量净额的增长所引起。单纯考虑企业因经营活动产生的现金流，实际经营现金净流量为Rmb"
                + String.format(java.util.Locale.CHINA, "%.2f", annualOperatingCash / 10000D)
                + "万元，能够覆盖日常经营资金需求。"
                : "本期经营活动现金流量为负，建议重点关注回款、存货占用和付款节奏，并结合筹资安排做好资金计划。";
        List<Map<String, Object>> sections = new ArrayList<Map<String, Object>>();
        sections.add(section("利润表", profitNarrative));
        sections.add(section("资产负债表", "无报告"));
        sections.add(section("现金流量", cashNarrative));
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("title", DbUtils.str(org, "orgName", "企业经营报告") + " · 经营分析报告");
        data.put("period", overview.get("period"));
        data.put("healthScore", overview.get("healthScore"));
        data.put("summary", "本报告基于企业最新财务报表自动生成。报告期内营业收入为 "
                + money(overview.get("revenue")) + "元，净利润为 " + money(overview.get("netProfit"))
                + "元，资产总额为 " + money(overview.get("totalAssets")) + "元。");
        data.put("metrics", overview);
        data.put("alerts", overview.get("alerts"));
        data.put("sections", sections);
        data.put("profitNarrative", profitNarrative);
        data.put("balanceNarrative", "无报告");
        data.put("cashNarrative", cashNarrative);
        data.put("netProfitChange", FormulaUtils.round(profitChange, 2));
        data.put("netProfitChangeText", String.format(java.util.Locale.CHINA, "%,.2f", Math.abs(profitChange)));
        data.put("priorNetProfit", priorProfitWan);
        data.put("suggestions", suggestions(overview));
        return data;
    }

    private Map<String, Object> section(String title, String content) {
        Map<String, Object> section = new LinkedHashMap<String, Object>();
        section.put("title", title);
        section.put("content", content);
        return section;
    }

    private double toWan(Object value) {
        double number = value instanceof Number ? ((Number) value).doubleValue() : 0D;
        return FormulaUtils.round(number / 10000D, 2);
    }

    private List<String> suggestions(Map<String, Object> overview) {
        List<String> list = new ArrayList<String>();
        Map<String, Object> ratios = (Map<String, Object>) overview.get("ratios");
        for (Object value : ratios.values()) {
            Map<String, Object> category = (Map<String, Object>) value;
            for (Map<String, Object> item : (List<Map<String, Object>>) category.get("items")) {
                if (!"good".equals(item.get("status"))) {
                    list.add(String.valueOf(item.get("name")) + "当前为 " + item.get("value") + item.get("unit")
                            + "，建议：" + suggestion(String.valueOf(item.get("key"))));
                    if (list.size() >= 4) {
                        return list;
                    }
                }
            }
        }
        if (list.isEmpty()) {
            list.add("核心财务指标整体平稳，建议保持月度经营复盘和现金流滚动预测。");
        }
        return list;
    }

    public Map<String, Object> analysisHome(String orgId, String period) {
        Map<String, Object> overview = overview(orgId, period);
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("period", overview.get("period"));
        data.put("sections", new Object[]{
                section("资产负债分析", "资产结构与偿债能力", "balance"),
                section("利润分析", "收入、成本与盈利能力", "profit"),
                section("现金流量分析", "经营、投资、筹资现金流", "cashflow"),
                section("比率分析", "四类核心财务比率", "ratio")
        });
        data.put("overview", overview);
        return data;
    }

    private Map<String, Object> section(String title, String subtitle, String key) {
        Map<String, Object> section = new LinkedHashMap<String, Object>();
        section.put("title", title);
        section.put("subtitle", subtitle);
        section.put("key", key);
        return section;
    }

    public Map<String, Object> analysis(String orgId, String period, String type) {
        if (period == null || period.isEmpty()) {
            period = latestPeriod(orgId);
        }
        Map<String, Object> assets = raw("t_basi_assets_and_liabilities", orgId, period);
        Map<String, Object> profit = raw("t_basi_profit", orgId, period);
        Map<String, Object> cash = raw("t_basi_cash_flow", orgId, period);
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("period", period);
        if ("balance".equals(type)) {
            data.put("items", new Object[]{
                    metric("货币资金", DbUtils.num(assets, "qmLdzcHbzj")),
                    metric("应收账款", DbUtils.num(assets, "qmLdzcYszk")),
                    metric("存货", DbUtils.num(assets, "qmLdzcCh")),
                    metric("流动资产合计", DbUtils.num(assets, "qmLdzcHj")),
                    metric("资产总计", DbUtils.num(assets, "qmZczj")),
                    metric("负债合计", DbUtils.num(assets, "qmDysxFzhj")),
                    metric("所有者权益", DbUtils.num(assets, "qmGdqySyzqyhj"))
            });
            data.put("chart", new Object[]{
                    metric("流动资产", DbUtils.num(assets, "qmLdzcHj")),
                    metric("非流动资产", DbUtils.num(assets, "qmFldzcFldzchj")),
                    metric("流动负债", DbUtils.num(assets, "qmLdfzLdfzhj")),
                    metric("非流动负债", DbUtils.num(assets, "qmFldfzCqfzhj"))
            });
        } else if ("profit".equals(type)) {
            data.put("items", new Object[]{
                    metric("营业收入", DbUtils.num(profit, "byZyywsr")),
                    metric("营业成本", DbUtils.num(profit, "byZyywcb")),
                    metric("销售费用", DbUtils.num(profit, "byXsfy")),
                    metric("管理费用", DbUtils.num(profit, "byGlfy")),
                    metric("财务费用", DbUtils.num(profit, "byCwfy")),
                    metric("营业利润", DbUtils.num(profit, "byYylr")),
                    metric("净利润", DbUtils.num(profit, "byJlr"))
            });
            data.put("chart", new Object[]{
                    metric("营业收入", DbUtils.num(profit, "byZyywsr")),
                    metric("营业成本", DbUtils.num(profit, "byZyywcb")),
                    metric("营业利润", DbUtils.num(profit, "byYylr")),
                    metric("净利润", DbUtils.num(profit, "byJlr"))
            });
        } else {
            data.put("items", new Object[]{
                    metric("经营现金流入", DbUtils.num(cash, "bqJyhdXjlrxj")),
                    metric("经营现金流出", DbUtils.num(cash, "bqJyhdXjlcxj")),
                    metric("经营现金流净额", cashOperating(cash)),
                    metric("投资现金流净额", DbUtils.num(cash, "bqTzhdTzhdscsdxjllje")),
                    metric("筹资现金流净额", DbUtils.num(cash, "bqCzhdZchdxjllje")),
                    metric("期末现金余额", DbUtils.num(cash, "bqXjjzjeXjqmye"))
            });
            data.put("chart", new Object[]{
                    metric("经营活动", cashOperating(cash)),
                    metric("投资活动", DbUtils.num(cash, "bqTzhdTzhdscsdxjllje")),
                    metric("筹资活动", DbUtils.num(cash, "bqCzhdZchdxjllje"))
            });
        }
        return data;
    }

    private Map<String, Object> metric(String name, double value) {
        Map<String, Object> metric = new LinkedHashMap<String, Object>();
        metric.put("name", name);
        metric.put("value", value);
        return metric;
    }

    public Map<String, Object> profitChart(String orgId) {
        List<String> periods = new ArrayList<String>();
        List<Double> revenue = new ArrayList<Double>();
        List<Double> netProfit = new ArrayList<Double>();
        List<Map<String, Object>> rows = DbUtils.query(jdbc,
                "SELECT KJYEAR_MOTH, BY_ZYYWSR, BY_JLR FROM t_basi_profit WHERE ORG_ID=? "
                        + "ORDER BY KJYEAR_MOTH", orgId);
        for (Map<String, Object> row : rows) {
            periods.add(DbUtils.str(row, "kjyearMoth"));
            revenue.add(DbUtils.num(row, "byZyywsr"));
            netProfit.add(DbUtils.num(row, "byJlr"));
        }
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("periods", periods);
        data.put("series", new Object[]{series("营业收入", revenue), series("净利润", netProfit)});
        return data;
    }

    public Map<String, Object> cashChart(String orgId) {
        List<String> periods = new ArrayList<String>();
        List<Double> operating = new ArrayList<Double>();
        List<Double> invest = new ArrayList<Double>();
        List<Double> finance = new ArrayList<Double>();
        List<Map<String, Object>> rows = DbUtils.query(jdbc,
                "SELECT KJYEAR_MOTH, BQ_JYHD_JYHDCSDJE, BQ_TZHD_TZHDSCSDXJLLJE, BQ_CZHD_ZCHDXJLLJE "
                        + "FROM t_basi_cash_flow WHERE ORG_ID=? ORDER BY KJYEAR_MOTH", orgId);
        for (Map<String, Object> row : rows) {
            periods.add(DbUtils.str(row, "kjyearMoth"));
            operating.add(DbUtils.num(row, "bqJyhdJyhdcsdje"));
            invest.add(DbUtils.num(row, "bqTzhdTzhdscsdxjllje"));
            finance.add(DbUtils.num(row, "bqCzhdZchdxjllje"));
        }
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("periods", periods);
        data.put("series", new Object[]{series("经营活动", operating), series("投资活动", invest),
                series("筹资活动", finance)});
        return data;
    }

    private Map<String, Object> series(String name, List<Double> values) {
        Map<String, Object> series = new LinkedHashMap<String, Object>();
        series.put("name", name);
        series.put("values", values);
        return series;
    }

    public List<Map<String, Object>> news(int limit) {
        return DbUtils.query(jdbc,
                "SELECT ID, TITLE, CONTENT, AUTHOR, VIEW_NUM, UP_DATE, CLZZ FROM t_message_info "
                        + "ORDER BY CREATE_TIME DESC LIMIT " + Math.max(1, Math.min(limit, 50)));
    }

    private String money(Object value) {
        double number = value instanceof Number ? ((Number) value).doubleValue() : 0D;
        return String.format(java.util.Locale.CHINA, "%,.2f", number);
    }
}
