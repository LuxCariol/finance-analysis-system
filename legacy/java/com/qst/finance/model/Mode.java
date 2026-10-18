package com.qst.finance.model;

import java.io.Serializable;
import java.math.BigDecimal;

import lombok.Data;

/**
 * t_mode 算法模型表(配置化算法)
 */
@Data
public class Mode implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String modeCode;
    private String modeName;
    private String modeType;
    private String parentCode;
    private String calcExpression;
    private String resultCode;
    private String resultName;
    private String resultType;
    private String unit;
    private Integer precisionScale;
    private String warnMode;
    private BigDecimal warnLower;
    private BigDecimal warnUpper;
    private Integer warnLevel;
    private String mainFactor;
    private String advantage;
    private String disadvantage;
    private String advise;
    private Integer orderNo;
    private Integer isActive;
    private String description;
}
