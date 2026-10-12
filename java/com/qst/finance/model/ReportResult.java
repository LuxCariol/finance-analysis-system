package com.qst.finance.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import lombok.Data;

/**
 * t_report_result 数据转换结果表(数据仓库结果)
 */
@Data
public class ReportResult implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String batchId;
    private Long orgId;
    private String kjyear;
    private String kjmoth;
    private String kjyearMonth;
    private String reportType;
    private String code;
    private String valueType;
    private BigDecimal resultValue;
    private String dataSource;
    private Date createTime;

    private transient String codeName;
}
