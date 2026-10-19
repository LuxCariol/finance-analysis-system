package com.qst.finance.service;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

@Service
public class ExcelImportService {
    private static final Map<String, String> PROFIT_FIELDS = new LinkedHashMap<String, String>();
    private static final Map<String, String> ASSET_LEFT_FIELDS = new LinkedHashMap<String, String>();
    private static final Map<String, String> ASSET_RIGHT_FIELDS = new LinkedHashMap<String, String>();
    private static final Map<String, String> CASH_FIELDS = new LinkedHashMap<String, String>();
    private static final Map<String, String> KMYE_FIELDS = new LinkedHashMap<String, String>();
    private static final Map<String, String> AGE_FIELDS = new LinkedHashMap<String, String>();

    static {
        profit("1", "ZYYWSR");
        profit("3", "ZYYWCB");
        profit("5", "ZYYWSJJFJ");
        profit("7", "XSFY");
        profit("9", "GLFY");
        profit("11", "CWFY");
        profit("13", "ZCJZSS");
        profit("15", "GYJZBDSY");
        profit("17", "TZSY");
        profit("19", "DLYQYHHYQYDTZSY");
        profit("21", "YYLR");
        profit("23", "YYWSR");
        profit("25", "YYWZC");
        profit("29", "LRZE");
        profit("31", "SDS");
        profit("33", "JLR");
        profit("37", "MGSY");

        assetLeft("货币资金", "LDZC_HBZJ");
        assetLeft("交易性金融资产", "LDZC_JYXJRZC");
        assetLeft("以公允价值计量且其变动计入当期损益的金融资产", "LDZC_JYXJRZC");
        assetLeft("应收票据", "LDZC_YSPJ");
        assetLeft("应收账款", "LDZC_YSZK");
        assetLeft("预付款项", "LDZC_YFZK");
        assetLeft("预付账款", "LDZC_YFZK");
        assetLeft("应收利息", "LDZC_YSLX");
        assetLeft("应收股利", "LDZC_YSGL");
        assetLeft("其他应收款", "LDZC_QTYSK");
        assetLeft("存货", "LDZC_CH");
        assetLeft("一年内到期的非流动资产", "LDZC_YNNDQCQZQTZ");
        assetLeft("其他流动资产", "LDZC_QTLDZC");
        assetLeft("流动资产合计", "LDZC_HJ");
        assetLeft("可供出售金融资产", "FLDZC_KGCSJRZC");
        assetLeft("持有至到期投资", "FLDZC_CYZDQTZ");
        assetLeft("长期应收款", "FLDZC_CQYSK");
        assetLeft("长期股权投资", "FLDZC_CQGQTZ");
        assetLeft("投资性房地产", "FLDZC_TZXFDC");
        assetLeft("固定资产", "FLDZC_GDZC");
        assetLeft("在建工程", "FLDZC_ZJGC");
        assetLeft("工程物资", "FLDZC_GCWZ");
        assetLeft("固定资产清理", "FLDZC_GDZCQL");
        assetLeft("生产性生物资产", "FLDZC_SCXSWZC");
        assetLeft("油气资产", "FLDZC_YQZC");
        assetLeft("无形资产", "FLDZC_WXZC");
        assetLeft("开发支出", "FLDZC_KFZC");
        assetLeft("商誉", "FLDZC_SY");
        assetLeft("长期待摊费用", "FLDZC_CQDTFY");
        assetLeft("递延所得税资产", "FLDZC_DYSDSZC");
        assetLeft("其他非流动资产", "FLDZC_QTFLDZC");
        assetLeft("非流动资产合计", "FLDZC_FLDZCHJ");
        assetLeft("资产总计", "ZCZJ");

        assetRight("短期借款", "LDFZ_DQJK");
        assetRight("交易性金融负债", "LDFZ_JYXJRFZ");
        assetRight("以公允价值计量且其变动计入当期损益的金融负债", "LDFZ_JYXJRFZ");
        assetRight("应付票据", "LDFZ_YFPJ");
        assetRight("应付账款", "LDFZ_YFZK");
        assetRight("预收款项", "LDFZ_YSZK");
        assetRight("预收账款", "LDFZ_YSZK");
        assetRight("应付职工薪酬", "LDFZ_YFGZ");
        assetRight("应付工资", "LDFZ_YFGZ");
        assetRight("应交税费", "LDFZ_YJSJ");
        assetRight("应交税金", "LDFZ_YJSJ");
        assetRight("应付利息", "LDFZ_YFLX");
        assetRight("应付股利", "LDFZ_YFGL");
        assetRight("其他应付款", "LDFZ_QTYFK");
        assetRight("一年内到期的非流动负债", "LDFZ_YNNDQCQFZ");
        assetRight("其他流动负债", "LDFZ_QTLDFZ");
        assetRight("流动负债合计", "LDFZ_LDFZHJ");
        assetRight("长期借款", "FLDFZ_CQJK");
        assetRight("应付债券", "FLDFZ_YFZQ");
        assetRight("长期应付款", "FLDFZ_CQYFK");
        assetRight("专项应付款", "FLDFZ_ZXYFK");
        assetRight("预计负债", "FLDFZ_QTCQFZ");
        assetRight("递延所得税负债", "DYSX_DYSKHX");
        assetRight("其他非流动负债", "FLDFZ_QTCQFZ");
        assetRight("非流动负债合计", "FLDFZ_CQFZHJ");
        assetRight("负债合计", "DYSX_FZHJ");
        assetRight("实收资本(或股本)", "GDQY_SSZB");
        assetRight("股本", "GDQY_SSZB");
        assetRight("资本公积", "GDQY_ZBGJ");
        assetRight("减:库存股", "GDQY_KCG");
        assetRight("库存股", "GDQY_KCG");
        assetRight("盈余公积", "GDQY_YYGJ");
        assetRight("未分配利润", "GDQY_WFPLR");
        assetRight("所有者权益(或股东权益)合计", "GDQY_SYZQYHJ");
        assetRight("股东权益合计", "GDQY_SYZQYHJ");
        assetRight("负债和所有者权益(或股东权益)总计", "GDQY_FZHSYZQY");
        assetRight("负债和股东权益总计", "GDQY_FZHSYZQY");

        cash("销售商品、提供劳务收到的现金", "JYHD_SDDXJ");
        cash("收到的税费返还", "JYHD_SDDSFFH");
        cash("收到其他与经营活动有关的现金", "JYHD_SDDQTYGDXJ");
        cash("经营活动现金流入小计", "JYHD_XJLRXJ");
        cash("购买商品、接受劳务支付的现金", "JYHD_GJZFDXJ");
        cash("支付给职工以及为职工支付的现金", "JYHD_ZFGZGDXJ");
        cash("支付的各项税费", "JYHD_ZFDGXSF");
        cash("支付其他与经营活动有关的现金", "JYHD_ZFDQTDXJ");
        cash("经营活动现金流出小计", "JYHD_XJLCXJ");
        cash("经营活动产生的现金流量净额", "JYHD_JYHDCSDJE");
        cash("收回投资收到的现金", "TZHD_SHTZSSDXJ");
        cash("取得投资收益收到的现金", "TZHD_QDSYSSDXJ");
        cash("处置固定资产、无形资产和其他长期资产收回的现金净额", "TZHD_SSHDXJ");
        cash("处置子公司及其他营业单位收到的现金净额", "TZHD_SDDQTYGDXJ");
        cash("收到其他与投资活动有关的现金", "TZHD_XJLRXJ");
        cash("投资活动现金流入小计", "TZHD_SZFDXJ");
        cash("购建固定资产、无形资产和其他长期资产支付的现金", "TZHD_TZSZFDXJ");
        cash("投资支付的现金", "TZHD_ZFQTDXJ");
        cash("取得子公司及其他营业单位支付的现金净额", "TZHD_XJLCXJ");
        cash("支付其他与投资活动有关的现金", "TZHD_XJLCXJ");
        cash("投资活动现金流出小计", "TZHD_XJLCXJ");
        cash("投资活动产生的现金流量净额", "TZHD_TZHDSCSDXJLLJE");
        cash("吸收投资收到的现金", "CZHD_XSTZSSDDXJ");
        cash("取得借款收到的现金", "CZHD_JKSSDDXJ");
        cash("收到其他与筹资活动有关的现金", "CZHD_SDQTYGDXJ");
        cash("筹资活动现金流入小计", "CZHD_XJLRXJ");
        cash("偿还债务支付的现金", "CZHD_CHZWSZFDXJ");
        cash("分配股利、利润或偿付利息支付的现金", "CZHD_FPGLSZFDXJ");
        cash("支付其他与筹资活动有关的现金", "CZHD_ZFQTYGDXJ");
        cash("筹资活动现金流出小计", "CZHD_XJLCXJ");
        cash("筹资活动产生的现金流量净额", "CZHD_ZCHDXJLLJE");
        cash("汇率变动对现金及现金等价物的影响", "CZHD_HLBDXJDYX");
        cash("现金及现金等价物净增加额", "CZHD_XJJXJDWJJZE");
        cash("期初现金及现金等价物余额", "XJJZJE_XJDQCYE");
        cash("期末现金及现金等价物余额", "XJJZJE_XJQMYE");

        kmye("项目代码", "SUBJECT_CODE");
        kmye("科目代码", "SUBJECT_CODE");
        kmye("项目名称", "SUBJECT_NAME");
        kmye("科目名称", "SUBJECT_NAME");
        kmye("币别", "HBZL");
        kmye("期初借方余额", "QCJFYE");
        kmye("期初贷方余额", "QCDFYE");
        kmye("本期借方发生额", "BQJFFSE");
        kmye("本期贷方发生额", "BQDFFSE");
        kmye("本年借方累计", "BNJFLJ");
        kmye("本年贷方累计", "BNDFLJ");
        kmye("期末借方余额", "QMJFYE");
        kmye("期末贷方余额", "QMDFYE");

        age("核算项目代码", "PROJECT_CODE");
        age("项目代码", "PROJECT_CODE");
        age("核算项目名称", "PROJECT_NAME");
        age("项目名称", "PROJECT_NAME");
        age("余额", "BALANCE");
        age("信用期限", "CREDIT_PERIOD");
        age("信用额度", "CREDIT_LINE");
        age("未到期1至90天", "NOT_DUE1_TO30_DAYS");
        age("未到期91至180天", "NOT_DUE31_TO90_DAYS");
        age("未到期181至360天", "NOT_DUE91_TO180_DAYS");
        age("未到期361至720天", "NOT_DUE181_DAYS");
        age("未到期721至1080天", "NOT_DUE721_TO1080_DAYS");
        age("未到期1081天以上", "NOT_DUE1081_DAYS");
        age("到期1至90天", "DUE1_TO30_DAYS");
        age("到期91至180天", "DUE31_TO90_DAYS");
        age("到期181至360天", "DUE91_TO180_DAYS");
        age("到期361至720天", "DUE181_TO360_DAYS");
        age("到期721至1080天", "DUE361_TO720_DAYS");
        age("到期1081至1440天", "DUE721_TO1080_DAYS");
        age("到期1081天以上", "DUE1081_TO1440_DAYS");
        age("到期1441天以上", "DUE1441_DAYS");
        age("当日到期", "DUE_TODAY");
    }

    private final JdbcTemplate jdbc;

    public ExcelImportService(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    private static void profit(String code, String field) {
        PROFIT_FIELDS.put(code, field);
    }

    private static void assetLeft(String label, String suffix) {
        ASSET_LEFT_FIELDS.put(normalize(label), suffix);
    }

    private static void assetRight(String label, String suffix) {
        ASSET_RIGHT_FIELDS.put(normalize(label), suffix);
    }

    private static void cash(String label, String field) {
        CASH_FIELDS.put(normalize(label), field);
    }

    private static void kmye(String label, String field) {
        KMYE_FIELDS.put(normalize(label), field);
    }

    private static void age(String label, String field) {
        AGE_FIELDS.put(normalize(label), field);
    }

    public static String normalize(String value) {
        if (value == null) {
            return "";
        }
        String text = value.replace('\u00a0', ' ').replaceAll("\\s+", "")
                .replace('（', '(').replace('）', ')').replace('：', ':')
                .replaceAll("^[一二三四五六七八九十]+、", "")
                .replaceAll("^(减|加|其中):?", "")
                .replaceAll("^\\([一二三四五六七八九十]+\\)", "");
        return text;
    }

    @Transactional
    public ImportResult importExcel(InputStream inputStream, String fileName, String subject, String type,
                                    String orgId, String user) {
        String periodYear = period(fileName, Calendar.YEAR);
        String periodMonth = period(fileName, Calendar.MONTH);
        String yearMonth = periodYear + periodMonth;
        String batchId = "B" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + "-"
                + UUID.randomUUID().toString().substring(0, 4);
        try {
            Workbook workbook = WorkbookFactory.create(inputStream);
            Sheet sheet = workbook.getSheetAt(0);
            int count;
            if ("1".equals(subject)) {
                count = importProfit(sheet, fileName, orgId, user, periodYear, periodMonth, yearMonth, batchId);
            } else if ("2".equals(subject)) {
                count = importAssets(sheet, fileName, orgId, user, periodYear, periodMonth, yearMonth, batchId);
            } else if ("5".equals(subject)) {
                count = importCash(sheet, fileName, orgId, user, periodYear, periodMonth, yearMonth, batchId);
            } else if ("3".equals(subject)) {
                count = importKmye(sheet, fileName, orgId, user, periodYear, periodMonth, yearMonth, batchId);
            } else if ("22".equals(subject) || "23".equals(subject) || "16".equals(subject)) {
                count = importAge(sheet, fileName, orgId, user, periodYear, periodMonth, yearMonth, batchId, type);
            } else {
                workbook.close();
                return ImportResult.fail("不支持的报表类型: " + subject);
            }
            workbook.close();
            return count > 0 ? ImportResult.ok(fileName, count, batchId, yearMonth)
                    : ImportResult.fail("未读取到可导入的数据，请检查文件是否为金蝶报表格式");
        } catch (Exception ex) {
            return ImportResult.fail("导入失败: " + ex.getMessage());
        }
    }

    private int importProfit(Sheet sheet, String fileName, String orgId, String user, String year, String month,
                             String yearMonth, String batchId) {
        jdbc.update("DELETE FROM t_basi_profit WHERE ORG_ID=? AND KJYEAR_MOTH=?", orgId, yearMonth);
        DataFormatter formatter = new DataFormatter();
        int count = 0;
        Map<String, Object> values = common("t_basi_profit", fileName, orgId, user, year, month, yearMonth, batchId);
        values.put("JEDW", "1");
        for (int r = 0; r <= sheet.getLastRowNum(); r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            }
            String label = normalize(text(row.getCell(0), formatter));
            String code = text(row.getCell(1), formatter).replace(".0", "").trim();
            String field = PROFIT_FIELDS.get(code);
            if (field == null) {
                field = profitByLabel(label);
            }
            if (field == null) {
                continue;
            }
            BigDecimal current = decimal(row.getCell(2), formatter);
            BigDecimal cumulative = decimal(row.getCell(3), formatter);
            if (current == null && cumulative == null) {
                continue;
            }
            values.put("BY_" + field, current == null ? BigDecimal.ZERO : current);
            values.put("BN_" + field, cumulative == null ? BigDecimal.ZERO : cumulative);
            count++;
        }
        if (count > 0) {
            insert("t_basi_profit", values);
        }
        return count;
    }

    private String profitByLabel(String label) {
        if (label.contains("营业收入")) return "ZYYWSR";
        if (label.contains("营业成本")) return "ZYYWCB";
        if (label.contains("营业税金及附加") || label.contains("税金及附加")) return "ZYYWSJJFJ";
        if (label.contains("销售费用")) return "XSFY";
        if (label.contains("管理费用")) return "GLFY";
        if (label.contains("财务费用")) return "CWFY";
        if (label.contains("资产减值损失")) return "ZCJZSS";
        if (label.contains("公允价值变动")) return "GYJZBDSY";
        if (label.contains("投资收益")) return "TZSY";
        if (label.contains("营业利润")) return "YYLR";
        if (label.contains("营业外收入")) return "YYWSR";
        if (label.contains("营业外支出")) return "YYWZC";
        if (label.contains("利润总额")) return "LRZE";
        if (label.contains("所得税")) return "SDS";
        if (label.contains("净利润")) return "JLR";
        if (label.contains("基本每股收益")) return "MGSY";
        return null;
    }

    private int importAssets(Sheet sheet, String fileName, String orgId, String user, String year, String month,
                             String yearMonth, String batchId) {
        jdbc.update("DELETE FROM t_basi_assets_and_liabilities WHERE ORG_ID=? AND KJYEAR_MOTH=?", orgId, yearMonth);
        DataFormatter formatter = new DataFormatter();
        Map<String, Object> values = common("t_basi_assets_and_liabilities", fileName, orgId, user, year, month,
                yearMonth, batchId);
        values.put("JEDW", "1");
        values.put("IS_SURE", "0");
        int count = 0;
        for (int r = 1; r <= sheet.getLastRowNum(); r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            }
            String leftLabel = normalize(text(row.getCell(0), formatter));
            BigDecimal leftBegin = decimal(row.getCell(2), formatter);
            BigDecimal leftEnd = decimal(row.getCell(3), formatter);
            String leftSuffix = ASSET_LEFT_FIELDS.get(leftLabel);
            if (leftSuffix != null) {
                if (leftBegin != null) {
                    values.put("NC_" + leftSuffix, leftBegin);
                }
                if (leftEnd != null) {
                    values.put("QM_" + leftSuffix, leftEnd);
                }
                if (leftBegin != null || leftEnd != null) {
                    count++;
                }
            }
            String rightLabel = normalize(text(row.getCell(4), formatter));
            BigDecimal rightBegin = decimal(row.getCell(6), formatter);
            BigDecimal rightEnd = decimal(row.getCell(7), formatter);
            String rightSuffix = ASSET_RIGHT_FIELDS.get(rightLabel);
            if (rightSuffix != null) {
                if (rightBegin != null) {
                    values.put("NC_" + rightSuffix, rightBegin);
                }
                if (rightEnd != null) {
                    values.put("QM_" + rightSuffix, rightEnd);
                }
                if (rightBegin != null || rightEnd != null) {
                    count++;
                }
            }
        }
        if (count > 0) {
            insert("t_basi_assets_and_liabilities", values);
        }
        return count;
    }

    private int importCash(Sheet sheet, String fileName, String orgId, String user, String year, String month,
                           String yearMonth, String batchId) {
        jdbc.update("DELETE FROM t_basi_cash_flow WHERE ORG_ID=? AND KJYEAR_MOTH=?", orgId, yearMonth);
        DataFormatter formatter = new DataFormatter();
        Map<String, Object> values = common("t_basi_cash_flow", fileName, orgId, user, year, month, yearMonth, batchId);
        values.put("JEDW", "1");
        int count = 0;
        for (int r = 1; r <= sheet.getLastRowNum(); r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            }
            String label = normalize(text(row.getCell(0), formatter));
            String field = CASH_FIELDS.get(label);
            if (field == null) {
                field = cashByLabel(label);
            }
            BigDecimal amount = decimal(row.getCell(2), formatter);
            if (field == null || amount == null) {
                continue;
            }
            values.put(field, amount);
            values.put("BQ_" + field, amount);
            count++;
        }
        if (count > 0) {
            insert("t_basi_cash_flow", values);
        }
        return count;
    }

    private String cashByLabel(String label) {
        if (label.contains("销售商品") && label.contains("收到")) return "JYHD_SDDXJ";
        if (label.contains("收到的税费返还")) return "JYHD_SDDSFFH";
        if (label.contains("经营活动现金流入")) return "JYHD_XJLRXJ";
        if (label.contains("购买商品") && label.contains("支付")) return "JYHD_GJZFDXJ";
        if (label.contains("支付给职工")) return "JYHD_ZFGZGDXJ";
        if (label.contains("支付的各项税费")) return "JYHD_ZFDGXSF";
        if (label.contains("经营活动现金流出")) return "JYHD_XJLCXJ";
        if (label.contains("经营活动产生的现金流量净额")) return "JYHD_JYHDCSDJE";
        if (label.contains("收回投资")) return "TZHD_SHTZSSDXJ";
        if (label.contains("取得投资收益")) return "TZHD_QDSYSSDXJ";
        if (label.contains("投资活动现金流入")) return "TZHD_SZFDXJ";
        if (label.contains("投资活动现金流出")) return "TZHD_XJLCXJ";
        if (label.contains("投资活动产生的现金流量净额")) return "TZHD_TZHDSCSDXJLLJE";
        if (label.contains("吸收投资")) return "CZHD_XSTZSSDDXJ";
        if (label.contains("取得借款")) return "CZHD_JKSSDDXJ";
        if (label.contains("筹资活动现金流入")) return "CZHD_XJLRXJ";
        if (label.contains("偿还债务")) return "CZHD_CHZWSZFDXJ";
        if (label.contains("分配股利")) return "CZHD_FPGLSZFDXJ";
        if (label.contains("筹资活动现金流出")) return "CZHD_XJLCXJ";
        if (label.contains("筹资活动产生的现金流量净额")) return "CZHD_ZCHDXJLLJE";
        if (label.contains("现金及现金等价物净增加额")) return "CZHD_XJJXJDWJJZE";
        if (label.contains("期初现金及现金等价物")) return "XJJZJE_XJDQCYE";
        if (label.contains("期末现金及现金等价物")) return "XJJZJE_XJQMYE";
        return null;
    }

    private int importKmye(Sheet sheet, String fileName, String orgId, String user, String year, String month,
                           String yearMonth, String batchId) {
        jdbc.update("DELETE FROM t_kmye WHERE ORG_ID=? AND KJYEAR_MOTH=?", orgId, yearMonth);
        DataFormatter formatter = new DataFormatter();
        Row header = findHeaderRow(sheet, KMYE_FIELDS, formatter);
        if (header == null) {
            return -1;
        }
        Map<Integer, String> columns = headerColumns(header, KMYE_FIELDS, formatter);
        int count = 0;
        for (int r = header.getRowNum() + 1; r <= sheet.getLastRowNum(); r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            }
            String subjectCode = text(row.getCell(0), formatter);
            if (subjectCode.trim().isEmpty()) {
                continue;
            }
            Map<String, Object> values = common("t_kmye", fileName, orgId, user, year, month, yearMonth, batchId);
            values.put("SUBJECT_CODE", subjectCode.trim());
            values.put("SUBJECT_NAME", text(row.getCell(1), formatter));
            values.put("HBZL", text(row.getCell(2), formatter));
            for (Map.Entry<Integer, String> column : columns.entrySet()) {
                Cell cell = row.getCell(column.getKey());
                if ("SUBJECT_CODE".equals(column.getValue()) || "SUBJECT_NAME".equals(column.getValue())
                        || "HBZL".equals(column.getValue())) {
                    continue;
                }
                BigDecimal amount = decimal(cell, formatter);
                if (amount != null) {
                    values.put(column.getValue(), amount);
                }
            }
            values.put("account_port_type", 1);
            values.put("bj", 0);
            insert("t_kmye", values);
            count++;
        }
        return count;
    }

    private int importAge(Sheet sheet, String fileName, String orgId, String user, String year, String month,
                          String yearMonth, String batchId, String type) {
        int ageType = type == null || type.trim().isEmpty() ? 1 : Integer.parseInt(type.trim());
        jdbc.update("DELETE FROM t_age_analysis WHERE ORG_ID=? AND KJYEAR_MOTH=? AND type=?", orgId, yearMonth, ageType);
        DataFormatter formatter = new DataFormatter();
        Row header = findHeaderRow(sheet, AGE_FIELDS, formatter);
        if (header == null) {
            return -1;
        }
        Map<Integer, String> columns = headerColumns(header, AGE_FIELDS, formatter);
        int count = 0;
        for (int r = header.getRowNum() + 1; r <= sheet.getLastRowNum(); r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            }
            String projectCode = text(row.getCell(0), formatter).trim();
            String projectName = text(row.getCell(1), formatter).trim();
            if (projectCode.isEmpty() && projectName.isEmpty()) {
                continue;
            }
            if (projectName.contains("合计") || projectName.contains("占总")) {
                continue;
            }
            Map<String, Object> values = common("t_age_analysis", fileName, orgId, user, year, month, yearMonth, batchId);
            values.put("type", ageType);
            values.put("PROJECT_CODE", projectCode);
            values.put("PROJECT_NAME", projectName);
            for (Map.Entry<Integer, String> column : columns.entrySet()) {
                BigDecimal amount = decimal(row.getCell(column.getKey()), formatter);
                if (amount != null) {
                    values.put(column.getValue(), amount);
                }
            }
            values.put("account_port_type", 1);
            values.put("FORMAT_FLAG", "N");
            insert("t_age_analysis", values);
            count++;
        }
        return count;
    }

    private Map<Integer, String> headerColumns(Row header, Map<String, String> fields, DataFormatter formatter) {
        Map<Integer, String> columns = new LinkedHashMap<Integer, String>();
        for (int c = 0; c < header.getLastCellNum(); c++) {
            String name = normalize(text(header.getCell(c), formatter));
            String field = fields.get(name);
            if (field != null) {
                columns.put(c, field);
            }
        }
        return columns;
    }

    private Row findHeaderRow(Sheet sheet, Map<String, String> fields, DataFormatter formatter) {
        int bestRow = -1;
        int bestCount = 0;
        int limit = Math.min(sheet.getLastRowNum(), 20);
        for (int r = 0; r <= limit; r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            }
            int count = headerColumns(row, fields, formatter).size();
            if (count > bestCount) {
                bestCount = count;
                bestRow = r;
            }
        }
        return bestCount >= 2 ? sheet.getRow(bestRow) : null;
    }

    private Map<String, Object> common(String table, String fileName, String orgId, String user, String year,
                                       String month, String yearMonth, String batchId) {
        Map<String, Object> values = new LinkedHashMap<String, Object>();
        values.put("ID", UUID.randomUUID().toString().replace("-", ""));
        values.put("IMP_TIME", new Timestamp(System.currentTimeMillis()));
        values.put("IMP_USER", user);
        if (!"t_age_analysis".equals(table)) {
            values.put("BATCH_ID", batchId);
        }
        values.put("ORG_ID", orgId);
        values.put("KJYEAR", year);
        values.put("KJMOTH", month);
        values.put("KJYEAR_MOTH", yearMonth);
        if (!"t_age_analysis".equals(table)) {
            values.put("FORMAT_FLAG", "N");
        }
        return values;
    }

    private void insert(String table, Map<String, Object> values) {
        List<String> columns = new ArrayList<String>();
        List<Object> args = new ArrayList<Object>();
        for (Map.Entry<String, Object> entry : values.entrySet()) {
            columns.add("`" + entry.getKey() + "`");
            args.add(entry.getValue());
        }
        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < columns.size(); i++) {
            if (i > 0) {
                placeholders.append(',');
            }
            placeholders.append('?');
        }
        jdbc.update("INSERT INTO " + table + "(" + String.join(",", columns) + ") VALUES(" + placeholders + ")",
                args.toArray());
    }

    private String text(Cell cell, DataFormatter formatter) {
        if (cell == null) {
            return "";
        }
        return formatter.formatCellValue(cell).trim();
    }

    private BigDecimal decimal(Cell cell, DataFormatter formatter) {
        if (cell == null) {
            return null;
        }
        if (cell.getCellType() == CellType.NUMERIC) {
            return BigDecimal.valueOf(cell.getNumericCellValue());
        }
        if (cell.getCellType() == CellType.FORMULA) {
            try {
                return BigDecimal.valueOf(cell.getNumericCellValue());
            } catch (Exception ignored) {
                // formula with string result
            }
        }
        String value = formatter.formatCellValue(cell).replace(",", "").replace(" ", "").trim();
        if (value.isEmpty() || "-".equals(value)) {
            return null;
        }
        if (value.startsWith("(") && value.endsWith(")")) {
            value = "-" + value.substring(1, value.length() - 1);
        }
        try {
            return new BigDecimal(value);
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    private String period(String fileName, int field) {
        String name = fileName == null ? "" : fileName;
        for (int i = name.length() - 4; i >= 2; i--) {
            String candidate = name.substring(i - 2, i + 4);
            if (candidate.matches("20\\d{4}")) {
                return field == Calendar.YEAR ? candidate.substring(0, 4) : candidate.substring(4, 6);
            }
        }
        Calendar calendar = Calendar.getInstance();
        return field == Calendar.YEAR ? String.valueOf(calendar.get(Calendar.YEAR))
                : String.format(Locale.ROOT, "%02d", calendar.get(Calendar.MONTH) + 1);
    }

    public static class ImportResult {
        private boolean success;
        private String message;
        private int count;
        private String batchId;
        private String period;

        public static ImportResult ok(String message, int count, String batchId, String period) {
            ImportResult result = new ImportResult();
            result.success = true;
            result.message = message;
            result.count = count;
            result.batchId = batchId;
            result.period = period;
            return result;
        }

        public static ImportResult fail(String message) {
            ImportResult result = new ImportResult();
            result.success = false;
            result.message = message;
            return result;
        }

        public boolean isSuccess() {
            return success;
        }

        public String getMessage() {
            return message;
        }

        public int getCount() {
            return count;
        }

        public String getBatchId() {
            return batchId;
        }

        public String getPeriod() {
            return period;
        }
    }
}
