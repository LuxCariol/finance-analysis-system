package com.qst.finance.common;

import java.io.Serializable;
import java.util.List;

public class PageData<T> implements Serializable {
    private static final long serialVersionUID = 1L;

    private List<T> list;
    private int pageNow;
    private int pageSize;
    private long total;
    private int totalPage;

    public PageData() {
    }

    public PageData(List<T> list, int pageNow, int pageSize, long total) {
        this.list = list;
        this.pageNow = pageNow;
        this.pageSize = pageSize;
        this.total = total;
        this.totalPage = (int) ((total + pageSize - 1) / pageSize);
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public int getPageNow() {
        return pageNow;
    }

    public void setPageNow(int pageNow) {
        this.pageNow = pageNow;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
}
