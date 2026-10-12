package com.qst.finance.model;

import java.io.Serializable;

import lombok.Data;

/**
 * t_sys_dictionary_detail 数据字典明细表
 */
@Data
public class SysDictionaryDetail implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String dictCode;
    private String itemKey;
    private String itemValue;
    private Integer orderNo;
    private String description;
}
