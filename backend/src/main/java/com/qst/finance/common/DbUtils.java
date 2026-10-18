package com.qst.finance.common;

import org.springframework.jdbc.core.JdbcTemplate;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public final class DbUtils {
    private DbUtils() {
    }

    public static String camel(String value) {
        if (value == null || value.isEmpty()) {
            return value;
        }
        // MySQL aliases may already be camelCase (userName, viewNum).
        // Only convert snake_case or all-uppercase column names.
        if (value.indexOf('_') < 0 && !value.equals(value.toUpperCase(Locale.ROOT))) {
            return value;
        }
        String lower = value.toLowerCase(Locale.ROOT);
        StringBuilder result = new StringBuilder(lower.length());
        boolean upper = false;
        for (int i = 0; i < lower.length(); i++) {
            char c = lower.charAt(i);
            if (c == '_') {
                upper = true;
            } else if (upper) {
                result.append(Character.toUpperCase(c));
                upper = false;
            } else {
                result.append(c);
            }
        }
        return result.toString();
    }

    public static Map<String, Object> camelRow(Map<String, Object> row) {
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        if (row == null) {
            return result;
        }
        for (Map.Entry<String, Object> entry : row.entrySet()) {
            Object value = jspDate(entry.getValue());
            result.put(camel(entry.getKey()), value);
            // Keep snake_case aliases for legacy JSPs. Camel-case aliases such as
            // userName must not also emit a lowercase duplicate in JSON.
            if (entry.getKey().indexOf('_') >= 0) {
                result.put(entry.getKey().toLowerCase(Locale.ROOT), value);
            }
        }
        return result;
    }

    private static Object jspDate(Object value) {
        if (value instanceof LocalDateTime) {
            return Timestamp.valueOf((LocalDateTime) value);
        }
        if (value instanceof LocalDate) {
            return java.sql.Date.valueOf((LocalDate) value);
        }
        return value;
    }

    public static List<Map<String, Object>> camelRows(List<Map<String, Object>> rows) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> row : rows) {
            result.add(camelRow(row));
        }
        return result;
    }

    public static List<Map<String, Object>> query(JdbcTemplate jdbc, String sql, Object... args) {
        return camelRows(jdbc.queryForList(sql, args));
    }

    public static Map<String, Object> queryOne(JdbcTemplate jdbc, String sql, Object... args) {
        List<Map<String, Object>> rows = jdbc.queryForList(sql, args);
        return rows.isEmpty() ? null : camelRow(rows.get(0));
    }

    public static long count(JdbcTemplate jdbc, String sql, Object... args) {
        Long value = jdbc.queryForObject(sql, Long.class, args);
        return value == null ? 0L : value.longValue();
    }

    public static String str(Map<String, Object> map, String key) {
        if (map == null) {
            return null;
        }
        Object value = map.get(key);
        if (value == null) {
            value = map.get(key.toLowerCase(Locale.ROOT));
        }
        return value == null ? null : String.valueOf(value);
    }

    public static String str(Map<String, Object> map, String key, String defaultValue) {
        String value = str(map, key);
        return value == null || value.trim().isEmpty() ? defaultValue : value;
    }

    public static Double number(Map<String, Object> map, String key) {
        if (map == null) {
            return null;
        }
        Object value = map.get(key);
        if (value == null) {
            value = map.get(key.toLowerCase(Locale.ROOT));
        }
        if (value == null || String.valueOf(value).trim().isEmpty()) {
            return null;
        }
        if (value instanceof Number) {
            return ((Number) value).doubleValue();
        }
        try {
            return Double.parseDouble(String.valueOf(value).replace(",", ""));
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    public static double num(Map<String, Object> map, String key) {
        Double value = number(map, key);
        return value == null ? 0D : value.doubleValue();
    }

    public static String formatDate(Date value) {
        return value == null ? "" : new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(value);
    }

    public static String now() {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    }

    public static Timestamp nowTimestamp() {
        return new Timestamp(System.currentTimeMillis());
    }
}
