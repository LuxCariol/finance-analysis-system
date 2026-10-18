package com.qst.finance.model;

import java.io.Serializable;
import java.math.BigDecimal;

import lombok.Data;

/**
 * 算法模型计算结果(指标 + 预警 + 文字说明)
 */
@Data
public class CalcResult implements Serializable {

    private static final long serialVersionUID = 1L;

    private String modeCode;
    private String modeName;
    private String modeType;
    private String parentCode;
    private String reportType;
    private String resultCode;
    private String resultName;
    private String calcExpression;
    private BigDecimal value = BigDecimal.ZERO;
    private String displayValue;
    private String unit;
    private Integer precisionScale = 2;

    /** 预警模式: up(高于上限预警) / down(低于下限预警) / range(区间外预警) / none */
    private String warnMode = "none";
    private BigDecimal warnLower;
    private BigDecimal warnUpper;
    /** 预警级别 0:正常 1:提示 2:警告 3:严重 */
    private Integer warnLevel = 0;
    private String warnLevelText = "正常";
    private String warnDesc;

    private String mainFactor;
    private String advantage;
    private String disadvantage;
    private String advise;

    /** 环比/同比变化率 */
    private BigDecimal momRate;
    private BigDecimal yoyRate;
}
