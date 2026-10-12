package com.qst.finance.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * t_sys_user 管理员表
 */
@Data
public class SysUser implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String userName;
    private String accountName;
    private String pwd;
    private Integer locked;
    private Integer accountType;
    private Long createUserId;
    private String description;
    private Date createTime;
    private Long accountPortType;
    private String chrid;
    private String chridType;
    private Long orgId;
    private String url;

    /** 页面传入的新密码 */
    private transient String newPwd;
    /** 公司名称(展示用) */
    private transient String orgName;
    /** 角色ID集合(展示/提交用) */
    private transient List<Long> roleIds;
    /** 角色名称(展示用) */
    private transient String roleNames;
}
