package com.qst.finance.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

/**
 * 数据转换(ETL)结果
 */
@Data
public class TransformResult implements Serializable {

    private static final long serialVersionUID = 1L;

    private String batchId;
    private String kjyearMonth;
    private int sourceRows;
    private int mappedRows;
    private int algoRows;
    private int warnRows;
    private long costMillis;
    private String status = "SUCCESS";
    private List<String> messages = new ArrayList<String>();
}
