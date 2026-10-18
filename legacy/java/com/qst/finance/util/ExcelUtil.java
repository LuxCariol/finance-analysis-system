package com.qst.finance.util;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import com.qst.finance.common.BizException;

/**
 * Excel 读取工具(金蝶K8导出的财务报表均为 xls/xlsx)
 */
public final class ExcelUtil {

    private ExcelUtil() {
    }

    /**
     * 读取第一个工作表为二维字符串数组
     */
    public static List<List<String>> read(InputStream in, int maxRows) {
        Workbook workbook = null;
        try {
            workbook = WorkbookFactory.create(in);
            Sheet sheet = workbook.getSheetAt(0);
            int lastRow = sheet.getLastRowNum();
            if (lastRow + 1 > maxRows) {
                throw new BizException("单个文件行数超过 " + maxRows + " 行，请拆分后导入");
            }
            DataFormatter formatter = new DataFormatter(java.util.Locale.CHINA);
            List<List<String>> grid = new ArrayList<List<String>>();
            for (int r = 0; r <= lastRow; r++) {
                Row row = sheet.getRow(r);
                List<String> cells = new ArrayList<String>();
                if (row != null) {
                    int lastCell = row.getLastCellNum();
                    for (int c = 0; c < lastCell; c++) {
                        Cell cell = row.getCell(c);
                        cells.add(cellValue(cell, formatter));
                    }
                }
                grid.add(cells);
            }
            return grid;
        } catch (BizException e) {
            throw e;
        } catch (Exception e) {
            throw new BizException("Excel 文件解析失败，请确认文件未损坏且为金蝶导出的标准报表: " + e.getMessage());
        } finally {
            if (workbook != null) {
                try {
                    workbook.close();
                } catch (IOException ignored) {
                    // ignore
                }
            }
        }
    }

    private static String cellValue(Cell cell, DataFormatter formatter) {
        if (cell == null) {
            return "";
        }
        if (cell.getCellType() == CellType.NUMERIC) {
            if (DateUtil.isCellDateFormatted(cell)) {
                return new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
            }
            DecimalFormat df = new DecimalFormat("#.##");
            return df.format(cell.getNumericCellValue());
        }
        if (cell.getCellType() == CellType.FORMULA) {
            try {
                return formatter.formatCellValue(cell, null);
            } catch (Exception e) {
                return formatter.formatCellValue(cell);
            }
        }
        String value = formatter.formatCellValue(cell);
        return value == null ? "" : value.trim();
    }

    /**
     * 文本转金额(兼容 1,234.56 / ￥1234 / (1234) 负数写法 / 空值)
     */
    public static BigDecimal toDecimal(String text) {
        if (text == null) {
            return BigDecimal.ZERO;
        }
        String v = text.trim().replace(",", "").replace("，", "").replace("￥", "").replace("¥", "").replace(" ", "");
        if (v.isEmpty() || "-".equals(v) || "--".equals(v) || "/".equals(v)) {
            return BigDecimal.ZERO;
        }
        boolean negative = v.startsWith("(") && v.endsWith(")");
        if (negative) {
            v = v.substring(1, v.length() - 1);
        }
        try {
            BigDecimal d = new BigDecimal(v);
            return negative ? d.negate() : d;
        } catch (NumberFormatException e) {
            return BigDecimal.ZERO;
        }
    }

    public static String trim(String text) {
        return text == null ? "" : text.trim().replace("\u00A0", "").replace(" ", "");
    }
}
