package com.qst.finance.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

/**
 * 趋势图数据(曲线图/饼图/柱状图)
 */
@Data
public class TrendSeries implements Serializable {

    private static final long serialVersionUID = 1L;

    private String code;
    private String name;
    private String unit;
    private String chartType;
    private List<String> months = new ArrayList<String>();
    private List<java.math.BigDecimal> values = new ArrayList<java.math.BigDecimal>();
}
