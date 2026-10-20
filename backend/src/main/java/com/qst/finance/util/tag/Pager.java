package com.qst.finance.util.tag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

public class Pager extends TagSupport {
    private static final long serialVersionUID = 1L;

    private Integer curPage = 1;
    private Integer totalPage = 0;
    private Integer pageSize = 10;
    private Integer totalCount = 0;

    public void setCurPage(Integer curPage) {
        this.curPage = curPage;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    @Override
    public int doStartTag() throws JspException {
        JspWriter out = pageContext.getOut();
        int current = curPage == null ? 1 : Math.max(1, curPage);
        int pages = totalPage == null ? 0 : Math.max(0, totalPage);
        try {
            out.print("<div class=\"row\"><div class=\"col-sm-6\"><div class=\"dataTables_info\">");
            out.print("总页数:" + pages + " 当前页:" + current + " 总记录:" + totalCount);
            out.print("</div></div><div class=\"col-sm-6\"><div class=\"dataTables_paginate paging_bootstrap\"><ul class=\"pagination\">");
            out.print("<li><a href='javascript:goPage(1)'>首页</a></li>");
            out.print("<li><a href='javascript:goPage(" + Math.max(1, current - 1) + ")'>上一页</a></li>");
            int start = Math.max(1, current - 2);
            int end = Math.min(pages, start + 4);
            start = Math.max(1, end - 4);
            for (int i = start; i <= end; i++) {
                if (i == current) {
                    out.print("<li class=\"active\"><a href='javascript:void(0);'>" + i + "</a></li>");
                } else {
                    out.print("<li><a href='javascript:goPage(" + i + ")'>" + i + "</a></li>");
                }
            }
            out.print("<li><a href='javascript:goPage(" + Math.max(1, Math.min(pages, current + 1)) + ")'>下一页</a></li>");
            out.print("<li><a href='javascript:goPage(" + Math.max(1, pages) + ")'>尾页</a></li>");
            out.print("</ul></div></div></div>");
        } catch (IOException ex) {
            throw new JspException(ex);
        }
        return SKIP_BODY;
    }
}
