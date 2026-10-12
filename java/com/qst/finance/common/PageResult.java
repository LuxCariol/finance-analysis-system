package com.qst.finance.common;

import java.util.ArrayList;
import java.util.List;

/**
 * 分页结果
 */
public class PageResult<T> {

    private long total;
    private List<T> rows = new ArrayList<T>();
    private int pageNum = 1;
    private int pageSize = 10;

    public PageResult() {
    }

    public PageResult(long total, List<T> rows) {
        this.total = total;
        this.rows = rows == null ? new ArrayList<T>() : rows;
    }

    public PageResult(long total, List<T> rows, int pageNum, int pageSize) {
        this.total = total;
        this.rows = rows == null ? new ArrayList<T>() : rows;
        this.pageNum = pageNum;
        this.pageSize = pageSize;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
}
