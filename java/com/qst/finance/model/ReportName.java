package com.qst.finance.model;

import java.io.Serializable;

import lombok.Data;

/**
 * t_report_name 报表辅助表(导入模板定义)
 */
@Data
public class ReportName implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String reportCode;
    private String reportType;
    private String reportName;
    private String tableName;
    private String mapMode;
    private Integer orderNo;
    private Integer isActive;
    private String description;
}
