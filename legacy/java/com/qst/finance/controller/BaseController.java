package com.qst.finance.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.qst.finance.common.BizException;
import com.qst.finance.common.Constants;
import com.qst.finance.model.SysResources;
import com.qst.finance.model.SysUser;
import com.qst.finance.service.AuthService;

/**
 * 控制器基类: 提供登录用户、菜单权限校验与默认参数处理
 */
public abstract class BaseController {

    @Autowired
    private AuthService baseAuthService;

    protected SysUser currentUser(HttpSession session) {
        Object user = session == null ? null : session.getAttribute(Constants.SESSION_USER);
        if (!(user instanceof SysUser)) {
            throw new BizException(401, "登录已过期，请重新登录");
        }
        return (SysUser) user;
    }

    /**
     * 菜单权限校验: 非 root 账号必须拥有对应菜单(resKey)权限，防止越权直接调用接口
     */
    protected SysUser requirePermission(HttpSession session, String resKey) {
        SysUser user = currentUser(session);
        if (user.getAccountType() != null && user.getAccountType() == Constants.ACCOUNT_ROOT) {
            return user;
        }
        List<SysResources> menus = baseAuthService.userMenus(user);
        for (SysResources menu : menus) {
            if (resKey.equals(menu.getResKey())) {
                return user;
            }
        }
        throw new BizException(403, "当前账号没有【" + resKey + "】功能的操作权限");
    }

    protected Long defaultOrgId(Long orgId) {
        return orgId == null ? 1L : orgId;
    }

    protected String defaultMonth(String kjyearMonth) {
        return kjyearMonth == null || kjyearMonth.trim().isEmpty()
                ? com.qst.finance.util.DateUtil.currentYearMonth() : kjyearMonth.trim();
    }
}
