package com.qst.finance.model;

import java.io.Serializable;

import lombok.Data;

/**
 * t_code_mapper 编码转换表: 财务报表基础表与数据仓库编码的映射关系
 */
@Data
public class CodeMapper implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String sourceTable;
    private String sourceColumn;
    private String valueType;
    private String reportType;
    private String code;
    private String mapType;
    private String calcExpression;
    private Integer orderNo;
    private Integer isActive;

    /** 展示用: 编码名称 */
    private transient String codeName;
}
