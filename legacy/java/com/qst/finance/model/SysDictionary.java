package com.qst.finance.model;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

/**
 * t_sys_dictionary 数据字典表
 */
@Data
public class SysDictionary implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String dictCode;
    private String dictName;
    private String description;
    private Date createTime;
}
