package com.qst.finance.model;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

/**
 * t_import_log 数据导入/转换日志表
 */
@Data
public class ImportLog implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String batchId;
    private String reportType;
    private String reportName;
    private String fileName;
    private Integer totalRows;
    private Integer successRows;
    private Integer failRows;
    private String status;
    private String message;
    private String impUser;
    private Date startTime;
    private Date endTime;
}
