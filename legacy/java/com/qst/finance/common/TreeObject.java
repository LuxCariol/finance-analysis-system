package com.qst.finance.common;

import java.util.ArrayList;
import java.util.List;

/**
 * 树节点(菜单树 / 科目树)
 */
public class TreeObject {

    private Long id;
    private Long parentId;
    private String name;
    private String resKey;
    private String type;
    private String url;
    private String icon;
    private Integer orderNo;
    private List<TreeObject> children = new ArrayList<TreeObject>();

    public TreeObject() {
    }

    public TreeObject(Long id, Long parentId, String name) {
        this.id = id;
        this.parentId = parentId;
        this.name = name;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getResKey() {
        return resKey;
    }

    public void setResKey(String resKey) {
        this.resKey = resKey;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Integer getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    public List<TreeObject> getChildren() {
        return children;
    }

    public void setChildren(List<TreeObject> children) {
        this.children = children;
    }
}
