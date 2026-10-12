package com.qst.finance.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * t_sys_role 角色表
 */
@Data
public class SysRole implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String name;
    private Long userId;
    private String description;
    private Date createTime;

    /** 角色拥有的菜单权限 */
    private transient List<Long> resIds;
    /** 角色下用户数(展示用) */
    private transient Integer userCount;
}
