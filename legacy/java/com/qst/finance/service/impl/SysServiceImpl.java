package com.qst.finance.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qst.finance.cache.CacheService;
import com.qst.finance.common.BizException;
import com.qst.finance.config.AppProperties;
import com.qst.finance.mapper.OrgInfoMapper;
import com.qst.finance.mapper.SysDictionaryMapper;
import com.qst.finance.mapper.SysResourcesMapper;
import com.qst.finance.mapper.SysRoleMapper;
import com.qst.finance.mapper.SysUserMapper;
import com.qst.finance.model.OrgInfo;
import com.qst.finance.model.SysDictionary;
import com.qst.finance.model.SysDictionaryDetail;
import com.qst.finance.model.SysResources;
import com.qst.finance.model.SysRole;
import com.qst.finance.model.SysUser;
import com.qst.finance.service.SysService;
import com.qst.finance.util.Md5Util;

@Service
public class SysServiceImpl implements SysService {

    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private SysRoleMapper sysRoleMapper;

    @Autowired
    private SysResourcesMapper sysResourcesMapper;

    @Autowired
    private OrgInfoMapper orgInfoMapper;

    @Autowired
    private SysDictionaryMapper sysDictionaryMapper;

    @Autowired
    private AppProperties appProperties;

    @Autowired
    private CacheService cacheService;

    // ------------------------------------------------------------------ 用户

    @Override
    public List<SysUser> userList(SysUser query) {
        List<SysUser> list = sysUserMapper.selectList(query == null ? new SysUser() : query);
        for (SysUser user : list) {
            List<String> roleNames = sysUserMapper.selectRoleNamesByUserId(user.getId());
            user.setRoleNames(String.join("、", roleNames));
            user.setRoleIds(sysUserMapper.selectRoleIdsByUserId(user.getId()));
        }
        return list;
    }

    @Override
    public SysUser userDetail(Long id) {
        SysUser user = sysUserMapper.selectById(id);
        if (user == null) {
            throw new BizException("用户不存在");
        }
        user.setPwd(null);
        user.setRoleIds(sysUserMapper.selectRoleIdsByUserId(id));
        return user;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveUser(SysUser user, List<Long> roleIds, boolean create) {
        if (user.getAccountName() == null || user.getAccountName().trim().isEmpty()) {
            throw new BizException("账号名称不能为空");
        }
        if (create) {
            if (sysUserMapper.selectByAccount(user.getAccountName()) != null) {
                throw new BizException("账号名称已存在");
            }
            String pwd = user.getNewPwd() == null || user.getNewPwd().isEmpty() ? "123456" : user.getNewPwd();
            user.setPwd(Md5Util.encrypt(user.getAccountName(), pwd, appProperties.getPasswordSalt()));
            user.setCreateTime(new Date());
            if (user.getLocked() == null) {
                user.setLocked(0);
            }
            if (user.getAccountType() == null) {
                user.setAccountType(1);
            }
            if (user.getCreateUserId() == null) {
                user.setCreateUserId(-1L);
            }
            if (user.getAccountPortType() == null) {
                user.setAccountPortType(1L);
            }
            sysUserMapper.insert(user);
        } else {
            sysUserMapper.update(user);
            if (user.getNewPwd() != null && !user.getNewPwd().isEmpty()) {
                sysUserMapper.updatePwd(user.getId(),
                        Md5Util.encrypt(user.getAccountName(), user.getNewPwd(), appProperties.getPasswordSalt()));
            }
        }
        if (roleIds != null) {
            updateUserRoles(user.getId(), roleIds);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteUser(Long id) {
        SysUser user = sysUserMapper.selectById(id);
        if (user != null && Integer.valueOf(0).equals(user.getAccountType())) {
            throw new BizException("系统内置 root 账号不允许删除");
        }
        sysUserMapper.deleteUserRole(id);
        sysUserMapper.deleteById(id);
    }

    @Override
    public void resetPassword(Long id, String password) {
        SysUser user = sysUserMapper.selectById(id);
        if (user == null) {
            throw new BizException("用户不存在");
        }
        String pwd = password == null || password.isEmpty() ? "123456" : password;
        sysUserMapper.updatePwd(id, Md5Util.encrypt(user.getAccountName(), pwd, appProperties.getPasswordSalt()));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateUserRoles(Long userId, List<Long> roleIds) {
        sysUserMapper.deleteUserRole(userId);
        if (roleIds != null) {
            for (Long roleId : roleIds) {
                sysUserMapper.insertUserRole(userId, roleId);
            }
        }
        cacheService.delete("cw:menu:" + userId);
    }

    // ------------------------------------------------------------------ 角色

    @Override
    public List<SysRole> roleList() {
        List<SysRole> roles = sysRoleMapper.selectAll();
        for (SysRole role : roles) {
            role.setUserCount(sysRoleMapper.countUserByRole(role.getId()));
        }
        return roles;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveRole(SysRole role, List<Long> resIds) {
        if (role.getName() == null || role.getName().trim().isEmpty()) {
            throw new BizException("角色名称不能为空");
        }
        if (role.getId() == null) {
            role.setCreateTime(new Date());
            if (role.getUserId() == null) {
                role.setUserId(-1L);
            }
            sysRoleMapper.insert(role);
        } else {
            sysRoleMapper.update(role);
        }
        if (resIds != null) {
            sysRoleMapper.deleteRoleAction(role.getId());
            for (Long resId : resIds) {
                sysRoleMapper.insertRoleAction(resId, role.getId());
            }
        }
        cacheService.deleteByPrefix("cw:menu:");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteRole(Long id) {
        if (id != null && id == 1L) {
            throw new BizException("超级管理员角色不允许删除");
        }
        if (sysRoleMapper.countUserByRole(id) > 0) {
            throw new BizException("该角色下存在用户，请先解除关联");
        }
        sysRoleMapper.deleteRoleAction(id);
        sysRoleMapper.deleteById(id);
        cacheService.deleteByPrefix("cw:menu:");
    }

    @Override
    public List<Long> roleResourceIds(Long roleId) {
        return sysRoleMapper.selectResIdsByRoleId(roleId);
    }

    // ------------------------------------------------------------------ 菜单

    @Override
    public List<SysResources> resourceList() {
        return sysResourcesMapper.selectAll();
    }

    @Override
    public List<SysResources> resourceTree() {
        List<SysResources> all = sysResourcesMapper.selectAll();
        List<SysResources> roots = new ArrayList<SysResources>();
        for (SysResources node : all) {
            if (node.getParentId() != null && node.getParentId() == 0L) {
                roots.add(node);
            }
        }
        for (SysResources root : roots) {
            fillChildren(root, all);
        }
        return roots;
    }

    private void fillChildren(SysResources parent, List<SysResources> all) {
        for (SysResources node : all) {
            if (parent.getId().equals(node.getParentId())) {
                parent.getChildren().add(node);
                fillChildren(node, all);
            }
        }
    }

    @Override
    public void saveResource(SysResources resources) {
        if (resources.getName() == null || resources.getName().trim().isEmpty()) {
            throw new BizException("菜单名称不能为空");
        }
        if (resources.getParentId() == null) {
            resources.setParentId(0L);
        }
        if (resources.getOrderNo() == null) {
            resources.setOrderNo(99);
        }
        if (resources.getIsHide() == null) {
            resources.setIsHide(0);
        }
        if (resources.getId() == null) {
            sysResourcesMapper.insert(resources);
        } else {
            sysResourcesMapper.update(resources);
        }
        cacheService.deleteByPrefix("cw:menu:");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteResource(Long id) {
        if (sysResourcesMapper.countChildren(id) > 0) {
            throw new BizException("请先删除子菜单");
        }
        sysResourcesMapper.deleteRoleActionByRes(id);
        sysResourcesMapper.deleteById(id);
        cacheService.deleteByPrefix("cw:menu:");
    }

    // ------------------------------------------------------------------ 公司

    @Override
    public List<OrgInfo> orgList() {
        return orgInfoMapper.selectAll();
    }

    @Override
    public void saveOrg(OrgInfo org) {
        if (org.getOrgName() == null || org.getOrgName().trim().isEmpty()) {
            throw new BizException("公司名称不能为空");
        }
        if (org.getParentId() == null) {
            org.setParentId(0L);
        }
        if (org.getId() == null) {
            org.setCreateTime(new Date());
            orgInfoMapper.insert(org);
        } else {
            orgInfoMapper.update(org);
        }
    }

    @Override
    public void deleteOrg(Long id) {
        orgInfoMapper.deleteById(id);
    }

    // ------------------------------------------------------------------ 字典

    @Override
    public List<SysDictionary> dictList() {
        return sysDictionaryMapper.selectDictAll();
    }

    @Override
    public void saveDict(SysDictionary dict) {
        if (dict.getDictCode() == null || dict.getDictCode().trim().isEmpty()) {
            throw new BizException("字典编码不能为空");
        }
        if (dict.getId() == null) {
            dict.setCreateTime(new Date());
            sysDictionaryMapper.insertDict(dict);
        } else {
            sysDictionaryMapper.updateDict(dict);
        }
    }

    @Override
    public void deleteDict(Long id) {
        sysDictionaryMapper.deleteDict(id);
    }

    @Override
    public List<SysDictionaryDetail> dictDetailList(String dictCode) {
        return sysDictionaryMapper.selectDetailByDictCode(dictCode);
    }

    @Override
    public void saveDictDetail(SysDictionaryDetail detail) {
        if (detail.getId() == null) {
            if (sysDictionaryMapper.selectDetail(detail.getDictCode(), detail.getItemKey()) != null) {
                throw new BizException("字典项已存在");
            }
            sysDictionaryMapper.insertDetail(detail);
        } else {
            sysDictionaryMapper.updateDetail(detail);
        }
    }

    @Override
    public void deleteDictDetail(Long id) {
        sysDictionaryMapper.deleteDetail(id);
    }
}
