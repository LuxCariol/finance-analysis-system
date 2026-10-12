package com.qst.finance.service.support;

import java.io.ByteArrayOutputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Component;

import com.qst.finance.common.BizException;
import com.qst.finance.model.ReportName;
import com.qst.finance.model.ReportProperty;
import com.qst.finance.util.DateUtil;

/**
 * 导入模板生成器: 根据【报表与取值配置】生成与金蝶K8导出格式一致的标准模板，
 * sample=true 时填入示例数据，可直接用于验证导入功能。
 */
@Component
public class ImportTemplateBuilder {

    public byte[] build(ReportName report, List<ReportProperty> properties, boolean sample) {
        boolean longMode = "LONG".equalsIgnoreCase(report.getMapMode());
        Workbook workbook = new XSSFWorkbook();
        try {
            Sheet sheet = workbook.createSheet(report.getReportName());
            CellStyle titleStyle = workbook.createCellStyle();
            Font titleFont = workbook.createFont();
            titleFont.setBold(true);
            titleStyle.setFont(titleFont);

            CellStyle headStyle = workbook.createCellStyle();
            Font headFont = workbook.createFont();
            headFont.setBold(true);
            headFont.setColor(IndexedColors.WHITE.getIndex());
            headStyle.setFont(headFont);
            headStyle.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
            headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headStyle.setBorderBottom(BorderStyle.THIN);
            headStyle.setBorderTop(BorderStyle.THIN);
            headStyle.setBorderLeft(BorderStyle.THIN);
            headStyle.setBorderRight(BorderStyle.THIN);

            String yearMonth = DateUtil.currentYearMonth();
            Row info = sheet.createRow(0);
            info.createCell(0).setCellValue("公司名称: 青软实训科技股份有限公司");
            info.createCell(2).setCellValue("会计年度: " + DateUtil.yearOf(yearMonth));
            info.createCell(4).setCellValue("会计期间: " + DateUtil.monthOf(yearMonth));
            info.getCell(0).setCellStyle(titleStyle);
            Row info2 = sheet.createRow(1);
            info2.createCell(0).setCellValue("单位: 元");
            info2.createCell(2).setCellValue("报表: " + report.getReportName());

            List<String> sourceColumns = new ArrayList<String>();
            for (ReportProperty property : properties) {
                if (StringUtils.isNotBlank(property.getSourceColumn()) && !sourceColumns.contains(property.getSourceColumn())) {
                    sourceColumns.add(property.getSourceColumn());
                }
            }
            Row head = sheet.createRow(2);
            int col = 0;
            if (!longMode) {
                head.createCell(col++).setCellValue("项目");
                head.createCell(col++).setCellValue("行次");
            }
            for (String source : sourceColumns) {
                head.createCell(col++).setCellValue(source);
            }
            for (int c = 0; c < col; c++) {
                head.getCell(c).setCellStyle(headStyle);
            }

            int rowIndex = 3;
            if (longMode) {
                for (int i = 0; i < 3; i++) {
                    Row row = sheet.createRow(rowIndex++);
                    for (int c = 0; c < sourceColumns.size(); c++) {
                        row.createCell(c).setCellValue(sample ? sampleValue(sourceColumns.get(c), i + 1) : "");
                    }
                }
            } else {
                Set<String> subjects = new LinkedHashSet<String>();
                for (ReportProperty property : properties) {
                    subjects.add(property.getSubjectName());
                }
                int no = 1;
                for (String subject : subjects) {
                    Row row = sheet.createRow(rowIndex++);
                    row.createCell(0).setCellValue(subject);
                    row.createCell(1).setCellValue(no++);
                    for (int c = 0; c < sourceColumns.size(); c++) {
                        row.createCell(c + 2).setCellValue(sample ? sampleValue(sourceColumns.get(c), rowIndex) : "");
                    }
                }
            }
            sheet.setColumnWidth(0, 32 * 256);
            for (int c = 1; c <= sourceColumns.size() + 1; c++) {
                sheet.setColumnWidth(c, 18 * 256);
            }
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            workbook.write(out);
            return out.toByteArray();
        } catch (Exception e) {
            throw new BizException("模板生成失败: " + e.getMessage());
        } finally {
            try {
                workbook.close();
            } catch (Exception ignored) {
                // ignore
            }
        }
    }

    private String sampleValue(String column, int seed) {
        if (column.contains("金额") || column.contains("余额") || column.contains("发生")) {
            return new BigDecimal(1250000 + seed * 137500L).setScale(2, BigDecimal.ROUND_HALF_UP).toPlainString();
        }
        if (column.contains("代码")) {
            return "10010" + seed;
        }
        if (column.contains("名称")) {
            return "示例核算项目" + seed;
        }
        if (column.contains("级次")) {
            return String.valueOf(seed > 2 ? 2 : 1);
        }
        if (column.contains("期限")) {
            return "30";
        }
        if (column.contains("额度")) {
            return "2000000.00";
        }
        if (column.contains("到期日")) {
            return "2026-09-30";
        }
        return String.valueOf(500000 + seed * 20000);
    }
}
