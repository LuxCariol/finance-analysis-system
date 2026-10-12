package com.qst.finance.model;

import java.io.Serializable;

import lombok.Data;

/**
 * t_report_property 报表属性导入格式(取值版/位置版配置)
 */
@Data
public class ReportProperty implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String reportType;
    private String reportCode;
    private String subjectName;
    private Integer subjectLevel;
    private String sourceColumn;
    private String columnCode;
    private Integer colIndex;
    /** 1: 该列为行主键列(明细表模式) */
    private Integer isKey;
    private String defaultValue;
    private Integer orderNo;
    private Integer isActive;
}
