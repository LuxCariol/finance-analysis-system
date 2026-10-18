package com.qst.finance.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.qst.finance.common.PageResult;
import com.qst.finance.common.Result;
import com.qst.finance.model.OrgInfo;
import com.qst.finance.model.SysDictionary;
import com.qst.finance.model.SysDictionaryDetail;
import com.qst.finance.model.SysResources;
import com.qst.finance.model.SysRole;
import com.qst.finance.model.SysUser;
import com.qst.finance.service.SysService;
import com.qst.finance.util.PageUtil;

/**
 * 系统管理接口: 用户 / 角色 / 菜单 / 公司 / 字典
 *
 * 权限说明: 增删改接口均校验当前登录用户的菜单权限(resKey)，
 * 公司列表与字典列表作为公共基础数据，登录用户均可查询(供各页面下拉使用)。
 */
@RestController
@RequestMapping("/api/sys")
public class SysController extends BaseController {

    @Autowired
    private SysService sysService;

    // ---------------------------------------------------------------- 用户

    @GetMapping("/user/list")
    public Result<PageResult<SysUser>> userList(SysUser query, HttpSession session,
                                                @RequestParam(defaultValue = "1") Integer pageNum,
                                                @RequestParam(defaultValue = "10") Integer pageSize) {
        requirePermission(session, "sys_user");
        List<SysUser> list = sysService.userList(query);
        return Result.ok(PageUtil.page(list, pageNum, pageSize));
    }

    @GetMapping("/user/detail")
    public Result<SysUser> userDetail(@RequestParam Long id, HttpSession session) {
        requirePermission(session, "sys_user");
        return Result.ok(sysService.userDetail(id));
    }

    @PostMapping("/user/save")
    public Result<Void> saveUser(@RequestBody SysUser user, HttpSession session) {
        requirePermission(session, "sys_user");
        sysService.saveUser(user, user.getRoleIds(), user.getId() == null);
        return Result.ok();
    }

    @PostMapping("/user/delete")
    public Result<Void> deleteUser(@RequestParam Long id, HttpSession session) {
        requirePermission(session, "sys_user");
        sysService.deleteUser(id);
        return Result.ok();
    }

    @PostMapping("/user/resetPwd")
    public Result<Void> resetPwd(@RequestParam Long id, @RequestParam(required = false) String password,
                                 HttpSession session) {
        requirePermission(session, "sys_user");
        sysService.resetPassword(id, password);
        return Result.ok();
    }

    // ---------------------------------------------------------------- 角色

    @GetMapping("/role/list")
    public Result<List<SysRole>> roleList(HttpSession session) {
        requirePermission(session, "sys_role");
        return Result.ok(sysService.roleList());
    }

    @PostMapping("/role/save")
    public Result<Void> saveRole(@RequestBody SysRole role, HttpSession session) {
        requirePermission(session, "sys_role");
        sysService.saveRole(role, role.getResIds());
        return Result.ok();
    }

    @PostMapping("/role/delete")
    public Result<Void> deleteRole(@RequestParam Long id, HttpSession session) {
        requirePermission(session, "sys_role");
        sysService.deleteRole(id);
        return Result.ok();
    }

    @GetMapping("/role/resources")
    public Result<List<Long>> roleResources(@RequestParam Long roleId, HttpSession session) {
        requirePermission(session, "sys_role");
        return Result.ok(sysService.roleResourceIds(roleId));
    }

    // ---------------------------------------------------------------- 菜单

    @GetMapping("/menu/list")
    public Result<List<SysResources>> menuList(HttpSession session) {
        requirePermission(session, "sys_menu");
        return Result.ok(sysService.resourceList());
    }

    @GetMapping("/menu/tree")
    public Result<List<SysResources>> menuTree(HttpSession session) {
        requirePermission(session, "sys_menu");
        return Result.ok(sysService.resourceTree());
    }

    @PostMapping("/menu/save")
    public Result<Void> saveMenu(@RequestBody SysResources resources, HttpSession session) {
        requirePermission(session, "sys_menu");
        sysService.saveResource(resources);
        return Result.ok();
    }

    @PostMapping("/menu/delete")
    public Result<Void> deleteMenu(@RequestParam Long id, HttpSession session) {
        requirePermission(session, "sys_menu");
        sysService.deleteResource(id);
        return Result.ok();
    }

    // ---------------------------------------------------------------- 公司

    /** 公司列表: 作为公共基础数据，登录用户均可查询(用于页面下拉) */
    @GetMapping("/org/list")
    public Result<List<OrgInfo>> orgList(HttpSession session) {
        currentUser(session);
        return Result.ok(sysService.orgList());
    }

    @PostMapping("/org/save")
    public Result<Void> saveOrg(@RequestBody OrgInfo org, HttpSession session) {
        requirePermission(session, "sys_org");
        sysService.saveOrg(org);
        return Result.ok();
    }

    @PostMapping("/org/delete")
    public Result<Void> deleteOrg(@RequestParam Long id, HttpSession session) {
        requirePermission(session, "sys_org");
        sysService.deleteOrg(id);
        return Result.ok();
    }

    // ---------------------------------------------------------------- 字典

    /** 字典列表与明细: 公共基础数据 */
    @GetMapping("/dict/list")
    public Result<List<SysDictionary>> dictList(HttpSession session) {
        currentUser(session);
        return Result.ok(sysService.dictList());
    }

    @PostMapping("/dict/save")
    public Result<Void> saveDict(@RequestBody SysDictionary dict, HttpSession session) {
        requirePermission(session, "sys_dict");
        sysService.saveDict(dict);
        return Result.ok();
    }

    @PostMapping("/dict/delete")
    public Result<Void> deleteDict(@RequestParam Long id, HttpSession session) {
        requirePermission(session, "sys_dict");
        sysService.deleteDict(id);
        return Result.ok();
    }

    @GetMapping("/dict/detail")
    public Result<List<SysDictionaryDetail>> dictDetail(@RequestParam String dictCode, HttpSession session) {
        currentUser(session);
        return Result.ok(sysService.dictDetailList(dictCode));
    }

    @PostMapping("/dict/detail/save")
    public Result<Void> saveDictDetail(@RequestBody SysDictionaryDetail detail, HttpSession session) {
        requirePermission(session, "sys_dict");
        sysService.saveDictDetail(detail);
        return Result.ok();
    }

    @PostMapping("/dict/detail/delete")
    public Result<Void> deleteDictDetail(@RequestParam Long id, HttpSession session) {
        requirePermission(session, "sys_dict");
        sysService.deleteDictDetail(id);
        return Result.ok();
    }

    /** 当前登录用户(用于页面显示) */
    @GetMapping("/profile")
    public Result<SysUser> profile(HttpSession session) {
        return Result.ok(currentUser(session));
    }
}
