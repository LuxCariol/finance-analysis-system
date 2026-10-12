package com.qst.finance.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

/**
 * t_sys_resources 后台菜单表
 */
@Data
public class SysResources implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String name;
    private Long parentId;
    private String resKey;
    private String type;
    private String resUrl;
    private Integer orderNo;
    private String icon;
    private String btn;
    private Integer isHide;
    private String description;

    /** 父菜单名称(展示用) */
    private transient String parentName;
    /** 子菜单(菜单管理页面用) */
    private transient List<SysResources> children = new ArrayList<SysResources>();
}
