package com.qst.finance.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.finance.cache.CacheService;
import com.qst.finance.common.BizException;
import com.qst.finance.common.Constants;
import com.qst.finance.common.TreeObject;
import com.qst.finance.config.AppProperties;
import com.qst.finance.mapper.SysUserMapper;
import com.qst.finance.model.SysResources;
import com.qst.finance.model.SysUser;
import com.qst.finance.service.AuthService;
import com.qst.finance.util.Md5Util;
import com.qst.finance.util.TreeUtil;

@Service
public class AuthServiceImpl implements AuthService {

    private static final String MENU_CACHE_PREFIX = "cw:menu:";

    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private AppProperties appProperties;

    @Autowired
    private CacheService cacheService;

    @Override
    public SysUser login(String accountName, String password) {
        if (accountName == null || accountName.trim().isEmpty() || password == null || password.isEmpty()) {
            throw new BizException("用户名或密码错误");
        }
        SysUser user = sysUserMapper.selectByAccount(accountName.trim());
        if (user == null) {
            throw new BizException("用户名或密码错误");
        }
        if (user.getLocked() != null && user.getLocked() == 1) {
            throw new BizException("该账号已被锁定，请联系系统管理员");
        }
        if (!Md5Util.matches(user.getAccountName(), password, appProperties.getPasswordSalt(), user.getPwd())) {
            throw new BizException("用户名或密码错误");
        }
        user.setPwd(null);
        return user;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<SysResources> userMenus(SysUser user) {
        boolean root = user.getAccountType() != null && user.getAccountType() == Constants.ACCOUNT_ROOT;
        String cacheKey = MENU_CACHE_PREFIX + user.getId();
        Object cached = cacheService.get(cacheKey);
        if (cached instanceof List && !((List<?>) cached).isEmpty()) {
            return (List<SysResources>) cached;
        }
        List<SysResources> menus = sysUserMapper.selectMenusByUserId(user.getId(), root);
        cacheService.set(cacheKey, menus, appProperties.getCacheExpireSeconds());
        return menus;
    }

    @Override
    public List<TreeObject> userMenuTree(SysUser user) {
        List<SysResources> menus = userMenus(user);
        List<TreeObject> nodes = new ArrayList<TreeObject>();
        for (SysResources menu : menus) {
            TreeObject node = new TreeObject(menu.getId(), menu.getParentId(), menu.getName());
            node.setResKey(menu.getResKey());
            node.setType(menu.getType());
            node.setUrl(menu.getResUrl());
            node.setIcon(menu.getIcon());
            node.setOrderNo(menu.getOrderNo());
            nodes.add(node);
        }
        return TreeUtil.build(nodes, 0L);
    }
}
