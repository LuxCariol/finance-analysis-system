package com.qst.finance.service;

import com.qst.finance.common.DbUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

@Service
public class ReportConversionService {
    private final JdbcTemplate jdbc;

    public ReportConversionService(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    @Transactional
    public int convert(String orgId) {
        List<Map<String, Object>> orgs;
        if (orgId == null || orgId.trim().isEmpty()) {
            orgs = jdbc.queryForList("SELECT id FROM t_org_info ORDER BY id");
        } else {
            orgs = jdbc.queryForList("SELECT id FROM t_org_info WHERE id=?", orgId);
        }
        int total = 0;
        for (Map<String, Object> org : orgs) {
            total += convertOrg(String.valueOf(org.get("id")));
        }
        return total;
    }

    private int convertOrg(String orgId) {
        int total = 0;
        for (String period : periods(orgId)) {
            total += convertPeriod(orgId, period);
        }
        return total;
    }

    private int convertPeriod(String orgId, String period) {
        Map<String, Object> assets = DbUtils.queryOne(jdbc,
                "SELECT * FROM t_basi_assets_and_liabilities WHERE ORG_ID=? AND KJYEAR_MOTH=? "
                        + "ORDER BY IMP_TIME DESC LIMIT 1", orgId, period);
        Map<String, Object> profit = DbUtils.queryOne(jdbc,
                "SELECT * FROM t_basi_profit WHERE ORG_ID=? AND KJYEAR_MOTH=? ORDER BY IMP_TIME DESC LIMIT 1",
                orgId, period);
        Map<String, Object> cash = DbUtils.queryOne(jdbc,
                "SELECT * FROM t_basi_cash_flow WHERE ORG_ID=? AND KJYEAR_MOTH=? ORDER BY IMP_TIME DESC LIMIT 1",
                orgId, period);
        jdbc.update("UPDATE t_code_libr c JOIN t_code_mapper m ON c.CODE_NO=m.CODE_NO SET c.BASI_FIELD=m.BASI_FIELD");
        List<Map<String, Object>> mappers = DbUtils.query(jdbc,
                "SELECT BASI_FIELD, CODE_NO FROM t_code_mapper WHERE BASI_FIELD IS NOT NULL");
        jdbc.update("DELETE FROM t_report_result WHERE ORG_ID=? AND RYEAR_AND_MONTH=?", orgId, period);
        jdbc.update("DELETE FROM t_report WHERE ORG_ID=? AND RYEAR_AND_MONTH=?", orgId, period);
        int count = 0;
        for (Map<String, Object> mapper : mappers) {
            String field = DbUtils.str(mapper, "basiField");
            String code = DbUtils.str(mapper, "codeNo");
            if (field == null || code == null) {
                continue;
            }
            Double value = value(field, assets, profit, cash);
            if (value == null) {
                continue;
            }
            String year = period.length() >= 4 ? period.substring(0, 4) : period;
            String month = period.length() >= 6 ? period.substring(4, 6) : "01";
            jdbc.update("INSERT INTO t_report_result(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID) "
                            + "VALUES(?,?,?,?,?,?,?)",
                    UUID.randomUUID().toString().replace("-", ""), year, month, period, code,
                    BigDecimal.valueOf(value), orgId);
            jdbc.update("INSERT INTO t_report(ID,RYEAR,RMONTH,RYEAR_AND_MONTH,CODE_NO,DATA_VALUE,ORG_ID,bj) "
                            + "VALUES(?,?,?,?,?,?,?,0)",
                    UUID.randomUUID().toString().replace("-", ""), Integer.parseInt(year), Integer.parseInt(month),
                    period, code, BigDecimal.valueOf(value), orgId);
            count++;
        }
        jdbc.update("UPDATE t_basi_assets_and_liabilities SET FORMAT_FLAG='Y' WHERE ORG_ID=? AND KJYEAR_MOTH=?",
                orgId, period);
        jdbc.update("UPDATE t_basi_profit SET FORMAT_FLAG='Y' WHERE ORG_ID=? AND KJYEAR_MOTH=?", orgId, period);
        jdbc.update("UPDATE t_basi_cash_flow SET FORMAT_FLAG='Y' WHERE ORG_ID=? AND KJYEAR_MOTH=?", orgId, period);
        return count;
    }

    private List<String> periods(String orgId) {
        List<String> periods = new java.util.ArrayList<String>();
        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT DISTINCT KJYEAR_MOTH FROM t_basi_profit WHERE ORG_ID=? AND KJYEAR_MOTH IS NOT NULL "
                        + "UNION SELECT DISTINCT KJYEAR_MOTH FROM t_basi_assets_and_liabilities WHERE ORG_ID=? "
                        + "UNION SELECT DISTINCT KJYEAR_MOTH FROM t_basi_cash_flow WHERE ORG_ID=? "
                        + "ORDER BY KJYEAR_MOTH", orgId, orgId, orgId);
        for (Map<String, Object> row : rows) {
            Object value = row.values().iterator().next();
            if (value != null) {
                periods.add(String.valueOf(value));
            }
        }
        return periods;
    }

    private String latestPeriod(String orgId) {
        List<Map<String, Object>> rows = jdbc.queryForList(
                "SELECT MAX(KJYEAR_MOTH) AS p FROM ("
                        + "SELECT KJYEAR_MOTH FROM t_basi_assets_and_liabilities WHERE ORG_ID=? "
                        + "UNION ALL SELECT KJYEAR_MOTH FROM t_basi_profit WHERE ORG_ID=? "
                        + "UNION ALL SELECT KJYEAR_MOTH FROM t_basi_cash_flow WHERE ORG_ID=?"
                        + ") t", orgId, orgId, orgId);
        return rows.isEmpty() || rows.get(0).get("p") == null ? null : String.valueOf(rows.get(0).get("p"));
    }

    private Double value(String field, Map<String, Object> assets, Map<String, Object> profit,
                         Map<String, Object> cash) {
        String upper = field.toUpperCase(Locale.ROOT);
        if (upper.startsWith("BY_") || upper.startsWith("BN_") || upper.startsWith("LR_")) {
            return DbUtils.number(profit, field);
        }
        if (upper.startsWith("NC_") || upper.startsWith("QM_") || upper.startsWith("ZCFZ_")) {
            return DbUtils.number(assets, field);
        }
        if (upper.startsWith("BQ_") || upper.startsWith("JYHD_") || upper.startsWith("TZHD_")
                || upper.startsWith("CZHD_") || upper.startsWith("JLRJYHD_") || upper.startsWith("BSJXJ_")
                || upper.startsWith("XJJZJE_") || upper.startsWith("XJLL_")) {
            return DbUtils.number(cash, field);
        }
        Double value = DbUtils.number(profit, field);
        if (value == null) {
            value = DbUtils.number(assets, field);
        }
        if (value == null) {
            value = DbUtils.number(cash, field);
        }
        return value;
    }
}
