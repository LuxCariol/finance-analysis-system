package com.qst.finance.util;

import java.util.ArrayList;
import java.util.List;

import com.qst.finance.common.PageResult;

/**
 * 列表分页工具(配置类数据量小, 采用内存分页)
 */
public final class PageUtil {

    private PageUtil() {
    }

    public static <T> PageResult<T> page(List<T> list, Integer pageNum, Integer pageSize) {
        int num = pageNum == null || pageNum < 1 ? 1 : pageNum;
        int size = pageSize == null || pageSize < 1 ? 10 : pageSize;
        if (list == null) {
            return new PageResult<T>(0, new ArrayList<T>(), num, size);
        }
        int from = (num - 1) * size;
        if (from >= list.size()) {
            return new PageResult<T>(list.size(), new ArrayList<T>(), num, size);
        }
        int to = Math.min(from + size, list.size());
        return new PageResult<T>(list.size(), new ArrayList<T>(list.subList(from, to)), num, size);
    }
}
