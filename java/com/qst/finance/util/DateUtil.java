package com.qst.finance.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 会计年月工具: 会计年月格式统一为 yyyy-MM
 */
public final class DateUtil {

    private DateUtil() {
    }

    public static String currentYearMonth() {
        return new SimpleDateFormat("yyyy-MM").format(new Date());
    }

    public static String currentYear() {
        return new SimpleDateFormat("yyyy").format(new Date());
    }

    /**
     * 当前会计年月为基准，偏移 n 个月
     */
    public static String offsetMonth(String yearMonth, int offset) {
        int year = Integer.parseInt(yearMonth.substring(0, 4));
        int month = Integer.parseInt(yearMonth.substring(5, 7));
        Calendar c = Calendar.getInstance();
        c.set(Calendar.YEAR, year);
        c.set(Calendar.MONTH, month - 1);
        c.set(Calendar.DAY_OF_MONTH, 1);
        c.add(Calendar.MONTH, offset);
        return new SimpleDateFormat("yyyy-MM").format(c.getTime());
    }

    /**
     * 得到最近 n 个月(含当月)，按时间升序
     */
    public static List<String> lastMonths(String endYearMonth, int n) {
        List<String> list = new ArrayList<String>();
        for (int i = n - 1; i >= 0; i--) {
            list.add(offsetMonth(endYearMonth, -i));
        }
        return list;
    }

    public static String yearOf(String yearMonth) {
        return yearMonth == null ? currentYear() : yearMonth.substring(0, 4);
    }

    public static String monthOf(String yearMonth) {
        return yearMonth == null ? "01" : yearMonth.substring(5, 7);
    }

    public static String format(Date date) {
        return date == null ? null : new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
    }

    public static String format(Date date, String pattern) {
        return date == null ? null : new SimpleDateFormat(pattern).format(date);
    }

    public static String formatMonth(Date date) {
        return date == null ? null : new SimpleDateFormat("yyyy-MM").format(date);
    }
}
