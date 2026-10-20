package com.qst.finance.service;

import com.qst.finance.common.PageData;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class PageSupport {
    private final JdbcTemplate jdbc;

    public PageSupport(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public PageData<Map<String, Object>> page(String selectSql, String countSql, int pageNow, int pageSize,
                                              Object... args) {
        int safePage = Math.max(1, pageNow);
        int safeSize = Math.min(Math.max(1, pageSize), 100);
        long total = jdbc.queryForObject(countSql, Long.class, args);
        List<Map<String, Object>> rows = jdbc.queryForList(
                selectSql + " LIMIT " + ((safePage - 1) * safeSize) + "," + safeSize, args);
        return new PageData<Map<String, Object>>(
                com.qst.finance.common.DbUtils.camelRows(rows), safePage, safeSize, total);
    }
}
