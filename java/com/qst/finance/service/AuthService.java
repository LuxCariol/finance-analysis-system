package com.qst.finance.service;

import java.util.List;

import com.qst.finance.common.TreeObject;
import com.qst.finance.model.SysResources;
import com.qst.finance.model.SysUser;

/**
 * 登录认证服务
 */
public interface AuthService {

    /** 登录校验(账号 + 密码 MD5 加盐) */
    SysUser login(String accountName, String password);

    /** 当前用户可访问的菜单(平铺) */
    List<SysResources> userMenus(SysUser user);

    /** 当前用户可访问的菜单(树形) */
    List<TreeObject> userMenuTree(SysUser user);
}
