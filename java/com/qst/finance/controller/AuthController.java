package com.qst.finance.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.qst.finance.cache.CacheService;
import com.qst.finance.common.Constants;
import com.qst.finance.common.Result;
import com.qst.finance.common.TreeObject;
import com.qst.finance.model.SysDictionary;
import com.qst.finance.model.SysUser;
import com.qst.finance.service.AuthService;
import com.qst.finance.service.SysService;

/**
 * 登录认证接口
 */
@RestController
@RequestMapping("/api/auth")
public class AuthController extends BaseController {

    @Autowired
    private AuthService authService;

    @Autowired
    private SysService sysService;

    @Autowired
    private CacheService cacheService;

    @PostMapping("/login")
    public Result<Map<String, Object>> login(@RequestBody Map<String, String> body, HttpSession session) {
        String accountName = body.get("accountName");
        String pwd = body.get("pwd");
        SysUser user = authService.login(accountName, pwd);
        session.setAttribute(Constants.SESSION_USER, user);
        session.setMaxInactiveInterval(60 * 60);
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("user", user);
        return Result.ok("登录成功", data);
    }

    @PostMapping("/logout")
    public Result<Void> logout(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return Result.ok();
    }

    @GetMapping("/current")
    public Result<SysUser> current(HttpSession session) {
        Object user = session == null ? null : session.getAttribute(Constants.SESSION_USER);
        return Result.ok(user instanceof SysUser ? (SysUser) user : null);
    }

    @GetMapping("/menu")
    public Result<List<TreeObject>> menu(HttpSession session) {
        return Result.ok(authService.userMenuTree(currentUser(session)));
    }

    /** 公共字典(登录页面即可使用) */
    @GetMapping("/dict")
    public Result<Map<String, Object>> dict() {
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        for (SysDictionary dict : sysService.dictList()) {
            data.put(dict.getDictCode(), sysService.dictDetailList(dict.getDictCode()));
        }
        return Result.ok(data);
    }

    /** 当前缓存类型(Redis / 内存) */
    @GetMapping("/cache")
    public Result<String> cache() {
        return Result.ok(cacheService.currentType());
    }
}
