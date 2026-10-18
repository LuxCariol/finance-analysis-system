package com.qst.finance.util;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Map 工具: 统一把数据库列名转换为小驼峰，屏蔽 MySQL 与 H2 返回列名大小写差异。
 * 约定: SQL 中的别名只使用小写单词或下划线命名。
 */
public final class MapUtil {

    private MapUtil() {
    }

    public static Map<String, Object> convert(Map<String, Object> row) {
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        if (row == null) {
            return result;
        }
        for (Map.Entry<String, Object> entry : row.entrySet()) {
            result.put(camel(entry.getKey()), entry.getValue());
        }
        return result;
    }

    public static List<Map<String, Object>> convert(List<Map<String, Object>> rows) {
        java.util.List<Map<String, Object>> list = new java.util.ArrayList<Map<String, Object>>();
        if (rows != null) {
            for (Map<String, Object> row : rows) {
                list.add(convert(row));
            }
        }
        return list;
    }

    public static String camel(String key) {
        if (key == null) {
            return null;
        }
        String lower = key.toLowerCase();
        StringBuilder sb = new StringBuilder();
        boolean upper = false;
        for (int i = 0; i < lower.length(); i++) {
            char c = lower.charAt(i);
            if (c == '_') {
                upper = true;
                continue;
            }
            sb.append(upper ? Character.toUpperCase(c) : c);
            upper = false;
        }
        return sb.toString();
    }

    public static java.math.BigDecimal toDecimal(Object value) {
        if (value == null) {
            return java.math.BigDecimal.ZERO;
        }
        if (value instanceof java.math.BigDecimal) {
            return (java.math.BigDecimal) value;
        }
        if (value instanceof Number) {
            return new java.math.BigDecimal(value.toString());
        }
        return new java.math.BigDecimal(value.toString());
    }

    public static String toStr(Object value) {
        return value == null ? null : String.valueOf(value);
    }
}
