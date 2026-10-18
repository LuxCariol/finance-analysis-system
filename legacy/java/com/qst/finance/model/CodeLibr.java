package com.qst.finance.model;

import java.io.Serializable;

import lombok.Data;

/**
 * t_code_libr 编码基础表: 编码概要、图表配置、预警配置
 */
@Data
public class CodeLibr implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String code;
    private String codeName;
    private String reportType;
    private String reportGroup;
    private String chartType;
    private Integer precisionScale;
    private String unit;
    private Integer orderNo;
    private Integer isActive;
    private String description;
}
