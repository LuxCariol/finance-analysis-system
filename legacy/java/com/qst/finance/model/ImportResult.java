package com.qst.finance.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

/**
 * 数据导入结果
 */
@Data
public class ImportResult implements Serializable {

    private static final long serialVersionUID = 1L;

    private String batchId;
    private String reportType;
    private String reportName;
    private String fileName;
    private String kjyearMonth;
    private int totalRows;
    private int successRows;
    private int failRows;
    private String status = "SUCCESS";
    private String message;
    private boolean skipped;
    private List<String> errors = new ArrayList<String>();

    public void addError(String error) {
        if (errors.size() < 50) {
            errors.add(error);
        }
        failRows++;
    }
}
