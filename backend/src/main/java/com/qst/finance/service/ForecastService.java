package com.qst.finance.service;

import com.qst.finance.common.DbUtils;
import com.qst.finance.common.FormulaUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class ForecastService {
    private final JdbcTemplate jdbc;

    public ForecastService(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public Map<String, Object> profitForecast(String orgId, int months, double growthAdjustment) {
        int horizon = Math.max(1, Math.min(months, 12));
        List<Map<String, Object>> rows = DbUtils.query(jdbc,
                "SELECT KJYEAR_MOTH, BY_ZYYWSR, BY_ZYYWCB, BY_XSFY, BY_GLFY, BY_CWFY, BY_YYLR, BY_JLR "
                        + "FROM t_basi_profit WHERE ORG_ID=? AND BY_ZYYWSR IS NOT NULL "
                        + "ORDER BY KJYEAR_MOTH", orgId);
        List<Double> revenue = new ArrayList<Double>();
        List<Double> cost = new ArrayList<Double>();
        List<Double> operating = new ArrayList<Double>();
        List<Double> profit = new ArrayList<Double>();
        List<String> periods = new ArrayList<String>();
        for (Map<String, Object> row : rows) {
            periods.add(DbUtils.str(row, "kjyearMoth"));
            revenue.add(DbUtils.num(row, "byZyywsr"));
            cost.add(DbUtils.num(row, "byZyywcb"));
            operating.add(DbUtils.num(row, "byYylr"));
            profit.add(DbUtils.num(row, "byJlr"));
        }
        List<String> forecastPeriods = futurePeriods(periods, horizon);
        List<Double> forecastRevenue = applyAdjustment(FormulaUtils.linearTrend(revenue, horizon), growthAdjustment);
        List<Double> forecastCost = applyAdjustment(FormulaUtils.linearTrend(cost, horizon), growthAdjustment);
        List<Double> forecastOperating = new ArrayList<Double>();
        List<Double> forecastProfit = new ArrayList<Double>();
        for (int i = 0; i < horizon; i++) {
            double revenueValue = forecastRevenue.get(i);
            double costValue = forecastCost.get(i);
            forecastOperating.add(Math.max(0D, revenueValue - costValue - (revenueValue * 0.12D)));
            forecastProfit.add(Math.max(0D, revenueValue - costValue - (revenueValue * 0.18D)));
        }
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        result.put("method", "最小二乘线性趋势 + 费用率假设");
        result.put("historyPeriods", periods);
        result.put("historyRevenue", revenue);
        result.put("historyNetProfit", profit);
        result.put("forecastPeriods", forecastPeriods);
        result.put("forecastRevenue", forecastRevenue);
        result.put("forecastCost", forecastCost);
        result.put("forecastOperatingProfit", forecastOperating);
        result.put("forecastNetProfit", forecastProfit);
        result.put("forecast", rows(forecastPeriods, forecastRevenue, forecastCost, forecastOperating, forecastProfit));
        result.put("confidence", revenue.size() >= 6 ? "较高" : revenue.size() >= 3 ? "中等" : "偏低");
        result.put("note", "预测仅作为经营计划参考，需结合订单、价格、产能和融资安排复核。");
        return result;
    }

    public Map<String, Object> annualForecast(String orgId, String startYear, int years) {
        int horizon = Math.max(1, Math.min(years, 5));
        int start = Integer.parseInt(startYear);
        Map<String, Object> current = annualSums(orgId, String.valueOf(start - 1));
        Map<String, Object> base = annualSums(orgId, String.valueOf(start - 2));
        double baseRevenue = number(base, "rev");
        double currentRevenue = number(current, "rev");
        double revenueGrowth = baseRevenue == 0D ? 0.05D : Math.max(-0.2D, Math.min(0.5D, (currentRevenue - baseRevenue) / Math.abs(baseRevenue)));
        double costGrowth = number(base, "cost") == 0D ? 0.05D
                : Math.max(-0.2D, Math.min(0.5D, (number(current, "cost") - number(base, "cost")) / Math.abs(number(base, "cost"))));
        String[] labels = {"营业总收入", "营业成本", "税金及附加", "销售费用", "管理费用", "财务费用",
                "资产减值损失", "公允价值变动收益", "投资收益", "资产处置收益", "其他收益"};
        String[] fields = {"rev", "cost", "tax", "sale", "manage", "finance", "impairment",
                "fair", "invest", "", ""};
        List<Integer> yearList = new ArrayList<Integer>();
        List<List<Double>> values = new ArrayList<List<Double>>();
        for (int row = 0; row < labels.length; row++) {
            List<Double> rowValues = new ArrayList<Double>();
            double value = fields[row].isEmpty() ? 0D : number(current, fields[row]);
            for (int i = 0; i < horizon; i++) {
                double growth = row < 2 ? (row == 0 ? revenueGrowth : costGrowth) : 0.03D;
                value = value * (1D + growth);
                rowValues.add(FormulaUtils.round(value / 10000D, 2));
            }
            values.add(rowValues);
        }
        for (int i = 0; i < horizon; i++) {
            yearList.add(start + i);
        }
        List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < labels.length; i++) {
            Map<String, Object> row = new LinkedHashMap<String, Object>();
            row.put("name", labels[i]);
            row.put("values", values.get(i));
            rows.add(row);
        }
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        result.put("startYear", start);
        result.put("years", yearList);
        result.put("rows", rows);
        result.put("unit", "万元");
        result.put("revenueGrowth", FormulaUtils.round(revenueGrowth * 100D, 2));
        result.put("note", "年度预测基于最近两个完整年度的收入和成本增长率，并结合费用率假设。");
        return result;
    }

    private Map<String, Object> annualSums(String orgId, String year) {
        Map<String, Object> row = DbUtils.queryOne(jdbc,
                "SELECT SUM(BY_ZYYWSR)+0 AS rev,SUM(BY_ZYYWCB)+0 AS cost,SUM(BY_ZYYWSJJFJ)+0 AS tax,"
                        + "SUM(BY_XSFY)+0 AS sale,SUM(BY_GLFY)+0 AS manage,SUM(BY_CWFY)+0 AS finance,"
                        + "SUM(BY_ZCJZSS)+0 AS impairment,SUM(BY_GYJZBDSY)+0 AS fair,SUM(BY_TZSY)+0 AS invest "
                        + "FROM t_basi_profit WHERE ORG_ID=? AND KJYEAR=?",
                orgId, year);
        return row == null ? new LinkedHashMap<String, Object>() : row;
    }

    private double number(Map<String, Object> row, String key) {
        return DbUtils.num(row, key);
    }

    private List<Map<String, Object>> rows(List<String> periods, List<Double> revenue, List<Double> cost,
                                           List<Double> operating, List<Double> profit) {
        List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < periods.size(); i++) {
            Map<String, Object> row = new LinkedHashMap<String, Object>();
            row.put("period", periods.get(i));
            row.put("revenue", FormulaUtils.round(revenue.get(i), 2));
            row.put("cost", FormulaUtils.round(cost.get(i), 2));
            row.put("operatingProfit", FormulaUtils.round(operating.get(i), 2));
            row.put("netProfit", FormulaUtils.round(profit.get(i), 2));
            rows.add(row);
        }
        return rows;
    }

    private List<Double> applyAdjustment(List<Double> values, double adjustment) {
        List<Double> result = new ArrayList<Double>();
        for (Double value : values) {
            result.add(value == null ? 0D : Math.max(0D, value * (1D + adjustment)));
        }
        return result;
    }

    private List<String> futurePeriods(List<String> history, int count) {
        List<String> result = new ArrayList<String>();
        String last = history.isEmpty() ? "202612" : history.get(history.size() - 1);
        int year = Integer.parseInt(last.substring(0, 4));
        int month = Integer.parseInt(last.substring(4, 6));
        for (int i = 0; i < count; i++) {
            month++;
            if (month > 12) {
                month = 1;
                year++;
            }
            result.add(year + String.format("%02d", month));
        }
        return result;
    }
}
