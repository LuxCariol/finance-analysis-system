package com.qst.finance.model;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

/**
 * t_report 报告表(投资预测报告等)
 */
@Data
public class AnalysisReport implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String reportCode;
    private String reportName;
    private String reportType;
    private Long orgId;
    private String kjyearMonth;
    private String summary;
    private String content;
    private String creator;
    private Date createTime;
}
