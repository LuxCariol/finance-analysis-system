package com.qst.finance.model;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

/**
 * t_org_info 公司(组织)基础表
 */
@Data
public class OrgInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String orgCode;
    private String orgName;
    private Long parentId;
    private String orgType;
    private String description;
    private Date createTime;
}
