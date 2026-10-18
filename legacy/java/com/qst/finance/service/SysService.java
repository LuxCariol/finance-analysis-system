package com.qst.finance.service;

import java.util.List;

import com.qst.finance.model.OrgInfo;
import com.qst.finance.model.SysDictionary;
import com.qst.finance.model.SysDictionaryDetail;
import com.qst.finance.model.SysResources;
import com.qst.finance.model.SysRole;
import com.qst.finance.model.SysUser;

/**
 * 系统管理服务(用户/角色/菜单/公司/字典)
 */
public interface SysService {

    List<SysUser> userList(SysUser query);

    SysUser userDetail(Long id);

    void saveUser(SysUser user, List<Long> roleIds, boolean create);

    void deleteUser(Long id);

    void resetPassword(Long id, String password);

    void updateUserRoles(Long userId, List<Long> roleIds);

    List<SysRole> roleList();

    void saveRole(SysRole role, List<Long> resIds);

    void deleteRole(Long id);

    List<Long> roleResourceIds(Long roleId);

    List<SysResources> resourceList();

    List<SysResources> resourceTree();

    void saveResource(SysResources resources);

    void deleteResource(Long id);

    List<OrgInfo> orgList();

    void saveOrg(OrgInfo org);

    void deleteOrg(Long id);

    List<SysDictionary> dictList();

    void saveDict(SysDictionary dict);

    void deleteDict(Long id);

    List<SysDictionaryDetail> dictDetailList(String dictCode);

    void saveDictDetail(SysDictionaryDetail detail);

    void deleteDictDetail(Long id);
}
