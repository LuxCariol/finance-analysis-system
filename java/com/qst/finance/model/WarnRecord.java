package com.qst.finance.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import lombok.Data;

/**
 * t_warn_record 预警结果表
 */
@Data
public class WarnRecord implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private Long orgId;
    private String kjyearMonth;
    private String modeCode;
    private String resultCode;
    private String resultName;
    private BigDecimal resultValue;
    private Integer warnLevel;
    private String warnDesc;
    private String advise;
    private Date createTime;
}
