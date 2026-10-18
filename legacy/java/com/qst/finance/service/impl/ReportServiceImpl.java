package com.qst.finance.service.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.finance.common.Constants;
import com.qst.finance.mapper.CodeLibrMapper;
import com.qst.finance.mapper.ReportDataMapper;
import com.qst.finance.model.CodeLibr;
import com.qst.finance.model.ReportResult;
import com.qst.finance.mapper.ReportResultMapper;
import com.qst.finance.service.ReportService;
import com.qst.finance.util.MapUtil;

@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private CodeLibrMapper codeLibrMapper;

    @Autowired
    private ReportResultMapper reportResultMapper;

    @Autowired
    private ReportDataMapper reportDataMapper;

    @Override
    public Map<String, Object> balanceSheet(Long orgId, String kjyearMonth) {
        return buildReport(orgId, kjyearMonth, Constants.REPORT_BALANCE, Constants.VALUE_NC, Constants.VALUE_QM,
                "年初余额", "期末余额", true);
    }

    @Override
    public Map<String, Object> profitReport(Long orgId, String kjyearMonth) {
        return buildReport(orgId, kjyearMonth, Constants.REPORT_PROFIT, Constants.VALUE_SQ, Constants.VALUE_BJ,
                "上期金额", "本期金额", false);
    }

    @Override
    public Map<String, Object> cashFlowReport(Long orgId, String kjyearMonth) {
        return buildReport(orgId, kjyearMonth, Constants.REPORT_CASHFLOW, Constants.VALUE_SQ, Constants.VALUE_BJ,
                "上期金额", "本期金额", false);
    }

    private Map<String, Object> buildReport(Long orgId, String kjyearMonth, String reportType,
                                            String compareType, String currentType, String compareLabel,
                                            String currentLabel, boolean sectioned) {
        List<CodeLibr> codes = codeLibrMapper.selectByReportType(reportType);
        Map<String, ReportResult> valueMap = new LinkedHashMap<String, ReportResult>();
        for (ReportResult result : reportResultMapper.selectByMonth(orgId, kjyearMonth, reportType, null)) {
            valueMap.put(result.getCode() + "@" + result.getValueType(), result);
        }
        List<Map<String, Object>> items = new ArrayList<Map<String, Object>>();
        for (CodeLibr libr : codes) {
            Map<String, Object> item = new LinkedHashMap<String, Object>();
            BigDecimal current = valueOf(valueMap, libr.getCode(), currentType);
            BigDecimal compare = valueOf(valueMap, libr.getCode(), compareType);
            item.put("code", libr.getCode());
            item.put("name", libr.getCodeName());
            item.put("group", libr.getReportGroup());
            item.put("chartType", libr.getChartType());
            item.put("unit", libr.getUnit());
            item.put("current", current);
            item.put("compare", compare);
            BigDecimal change = current.subtract(compare);
            item.put("change", change);
            item.put("changeRate", compare.signum() == 0 ? null : change.divide(compare.abs(), 6, RoundingMode.HALF_UP));
            items.add(item);
        }
        List<Map<String, Object>> sections = new ArrayList<Map<String, Object>>();
        if (sectioned) {
            sections = splitBalanceSections(items);
        } else {
            Map<String, Object> section = new LinkedHashMap<String, Object>();
            section.put("section", "全部项目");
            section.put("items", items);
            sections.add(section);
        }
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("orgId", orgId);
        data.put("kjyearMonth", kjyearMonth);
        data.put("reportType", reportType);
        data.put("compareLabel", compareLabel);
        data.put("currentLabel", currentLabel);
        data.put("sections", sections);
        data.put("items", items);
        data.put("kpi", buildKpi(items));
        data.put("chartData", buildChartData(items, currentType));
        return data;
    }

    private BigDecimal valueOf(Map<String, ReportResult> valueMap, String code, String valueType) {
        ReportResult result = valueMap.get(code + "@" + valueType);
        return result == null || result.getResultValue() == null ? BigDecimal.ZERO : result.getResultValue();
    }

    private List<Map<String, Object>> splitBalanceSections(List<Map<String, Object>> items) {
        List<Map<String, Object>> sections = new ArrayList<Map<String, Object>>();
        sections.add(section("流动资产", items, 1, 13));
        sections.add(section("非流动资产", items, 14, 31));
        sections.add(section("资产总计", items, 32, 32));
        sections.add(section("流动负债", items, 33, 47));
        sections.add(section("非流动负债及负债合计", items, 48, 57));
        sections.add(section("所有者权益", items, 58, 68));
        sections.add(section("负债和所有者权益总计", items, 69, 69));
        return sections;
    }

    private Map<String, Object> section(String name, List<Map<String, Object>> items, int from, int to) {
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> item : items) {
            int index = codeIndex(MapUtil.toStr(item.get("code")));
            if (index >= from && index <= to) {
                list.add(item);
            }
        }
        Map<String, Object> section = new LinkedHashMap<String, Object>();
        section.put("section", name);
        section.put("items", list);
        return section;
    }

    private int codeIndex(String code) {
        if (StringUtils.isBlank(code)) {
            return 0;
        }
        try {
            return Integer.parseInt(code.replaceAll("[^0-9]", ""));
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private List<Map<String, Object>> buildKpi(List<Map<String, Object>> items) {
        List<Map<String, Object>> kpi = new ArrayList<Map<String, Object>>();
        String[] keys = new String[]{"A032", "A057", "A068", "P001", "P021", "C010"};
        for (Map<String, Object> item : items) {
            for (String key : keys) {
                if (key.equals(item.get("code"))) {
                    kpi.add(item);
                }
            }
        }
        return kpi;
    }

    private List<Map<String, Object>> buildChartData(List<Map<String, Object>> items, String currentType) {
        List<Map<String, Object>> chart = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> item : items) {
            BigDecimal current = MapUtil.toDecimal(item.get("current"));
            if (current.signum() != 0) {
                Map<String, Object> node = new LinkedHashMap<String, Object>();
                node.put("name", item.get("name"));
                node.put("code", item.get("code"));
                node.put("value", current);
                node.put("compare", item.get("compare"));
                chart.add(node);
            }
        }
        return chart;
    }

    @Override
    public List<Map<String, Object>> codeDetail(Long orgId, String kjyearMonth, String reportType, String keyword) {
        List<ReportResult> list = reportResultMapper.selectByMonth(orgId, kjyearMonth, reportType, null);
        Map<String, CodeLibr> librMap = new LinkedHashMap<String, CodeLibr>();
        for (CodeLibr libr : codeLibrMapper.selectAll()) {
            librMap.put(libr.getCode(), libr);
        }
        List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
        for (ReportResult result : list) {
            CodeLibr libr = librMap.get(result.getCode());
            String name = libr == null ? result.getCode() : libr.getCodeName();
            if (StringUtils.isNotBlank(keyword) && !name.contains(keyword) && !result.getCode().contains(keyword)) {
                continue;
            }
            Map<String, Object> row = new LinkedHashMap<String, Object>();
            row.put("code", result.getCode());
            row.put("name", name);
            row.put("reportType", result.getReportType());
            row.put("valueType", result.getValueType());
            row.put("value", result.getResultValue());
            row.put("unit", libr == null ? "元" : libr.getUnit());
            row.put("dataSource", result.getDataSource());
            row.put("kjyearMonth", result.getKjyearMonth());
            rows.add(row);
        }
        return rows;
    }

    @Override
    public List<Map<String, Object>> kmyeList(Long orgId, String kjyearMonth, String keyword) {
        return MapUtil.convert(reportDataMapper.selectKmye(orgId, kjyearMonth, keyword));
    }

    @Override
    public Map<String, Object> agingAnalysis(Long orgId, String kjyearMonth, String agingType) {
        List<Map<String, Object>> list = MapUtil.convert(reportDataMapper.selectAgingList(orgId, kjyearMonth, agingType, null));
        List<Map<String, Object>> summary = MapUtil.convert(reportDataMapper.selectAgingSummary(orgId, kjyearMonth));
        List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> row : list) {
            BigDecimal balance = MapUtil.toDecimal(row.get("balance"));
            BigDecimal overdue = BigDecimal.ZERO;
            String[] overdueKeys = new String[]{"due1To30Days", "due31To90Days", "due91To180Days", "due181To360Days",
                    "due361To720Days", "due721To1080Days", "due1081To1440Days", "due1441Days"};
            for (String key : overdueKeys) {
                overdue = overdue.add(MapUtil.toDecimal(row.get(key)));
            }
            Map<String, Object> item = new LinkedHashMap<String, Object>(row);
            item.put("overdueAmount", overdue);
            item.put("overdueRate", balance.signum() == 0 ? BigDecimal.ZERO
                    : overdue.divide(balance, 6, RoundingMode.HALF_UP));
            item.put("risk", overdue.compareTo(new BigDecimal("500000")) > 0 ? "超期金额较大，建议专项催收" : "账龄结构正常");
            rows.add(item);
        }
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("orgId", orgId);
        data.put("kjyearMonth", kjyearMonth);
        data.put("agingType", agingType);
        data.put("list", rows);
        data.put("summary", summary);
        return data;
    }
}
