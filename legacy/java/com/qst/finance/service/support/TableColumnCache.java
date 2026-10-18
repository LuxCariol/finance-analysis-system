package com.qst.finance.service.support;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.qst.finance.common.BizException;

/**
 * 数据库表结构缓存: 动态写入基础表前校验表名/列名(白名单)，避免 SQL 注入。
 */
@Component
public class TableColumnCache {

    @Autowired
    private DataSource dataSource;

    private final Map<String, Map<String, String>> cache = new ConcurrentHashMap<String, Map<String, String>>();

    /**
     * 返回 列名(大写) -> 数据类型
     */
    public Map<String, String> columns(String table) {
        String key = table.toLowerCase();
        Map<String, String> columns = cache.get(key);
        if (columns != null) {
            return columns;
        }
        Map<String, String> result = load(table);
        if (result.isEmpty()) {
            result = load(table.toUpperCase());
        }
        if (result.isEmpty()) {
            result = load(table.toLowerCase());
        }
        if (result.isEmpty()) {
            throw new BizException("数据表 " + table + " 不存在或未初始化");
        }
        cache.put(key, result);
        return result;
    }

    public boolean hasColumn(String table, String column) {
        return column != null && columns(table).containsKey(column.toUpperCase());
    }

    private Map<String, String> load(String table) {
        Map<String, String> columns = new LinkedHashMap<String, String>();
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = dataSource.getConnection();
            rs = connection.getMetaData().getColumns(connection.getCatalog(), null, table, null);
            while (rs.next()) {
                columns.put(rs.getString("COLUMN_NAME").toUpperCase(),
                        rs.getString("TYPE_NAME") == null ? "" : rs.getString("TYPE_NAME").toUpperCase());
            }
        } catch (SQLException e) {
            throw new BizException("读取数据表结构失败: " + e.getMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ignored) {
                    // ignore
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ignored) {
                    // ignore
                }
            }
        }
        return columns;
    }
}
