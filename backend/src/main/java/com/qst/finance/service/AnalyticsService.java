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
        return data;
    }

    public Map<String, Object> homeReport(String orgId, String period) {
        Map<String, Object> overview = overview(orgId, period);
        Map<String, Object> org = (Map<String, Object>) overview.get("org");
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("title", DbUtils.str(org, "orgName", "企业经营报告") + " · 经营分析报告");
        data.put("period", overview.get("period"));
        data.put("healthScore", overview.get("healthScore"));
        data.put("summary", "本报告基于企业最新财务报表自动生成。报告期内营业收入为 "
                + money(overview.get("revenue")) + "元，净利润为 " + money(overview.get("netProfit"))
                + "元，资产总额为 " + money(overview.get("totalAssets")) + "元。");
        data.put("metrics", overview);
        data.put("alerts", overview.get("alerts"));
        data.put("suggestions", suggestions(overview));
        return data;
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
