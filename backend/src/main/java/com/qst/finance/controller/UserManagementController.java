package com.qst.finance.controller;

import com.qst.finance.common.DbUtils;
import com.qst.finance.common.PageData;
import com.qst.finance.common.SecurityUtils;
import com.qst.finance.service.LoginUser;
import com.qst.finance.service.MenuService;
import com.qst.finance.service.PageSupport;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
@RequestMapping("/admin/pc/administratorManage")
public class UserManagementController {
    private final JdbcTemplate jdbc;
    private final PageSupport pageSupport;
    private final MenuService menuService;

    public UserManagementController(JdbcTemplate jdbc, PageSupport pageSupport, MenuService menuService) {
        this.jdbc = jdbc;
        this.pageSupport = pageSupport;
        this.menuService = menuService;
    }

    @GetMapping("/administratorIndex")
    public String index(Model model) {
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", 1);
        model.addAttribute("menuId", 20);
        return "admin/jsp/administrator/administratorIndex";
    }

    @GetMapping("/administratorListAndButtonList")
    public String listAndButtons(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                                 @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                                 Model model) {
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", 1);
        model.addAttribute("menuId", 20);
        model.addAttribute("buttonList", menuService.buttons(20));
        addPage(model, pageNow, pageSize, null, null);
        return "admin/jsp/administrator/administratorListAndButtonList";
    }

    private void addPage(Model model, int pageNow, int pageSize, String userName, String accountName) {
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        java.util.List<Object> args = new java.util.ArrayList<Object>();
        if (userName != null && !userName.trim().isEmpty()) {
            where.append(" AND u.user_name LIKE ?");
            args.add("%" + userName.trim() + "%");
        }
        if (accountName != null && !accountName.trim().isEmpty()) {
            where.append(" AND u.account_name LIKE ?");
            args.add("%" + accountName.trim() + "%");
        }
        String select = "SELECT u.id, u.user_name, u.account_name, u.locked, u.description, u.create_time, "
                + "c.user_name AS create_name, GROUP_CONCAT(r.name) AS role_name "
                + "FROM t_sys_user u LEFT JOIN t_sys_user c ON c.id = u.create_user_id "
                + "LEFT JOIN t_sys_user_role ur ON ur.user_id = u.id LEFT JOIN t_sys_role r ON r.id = ur.role_id"
                + where + " GROUP BY u.id ORDER BY u.id";
        String count = "SELECT COUNT(*) FROM t_sys_user u" + where;
        PageData<Map<String, Object>> page = pageSupport.page(select, count, pageNow, pageSize, args.toArray());
        model.addAttribute("administratorList", page.getList());
        model.addAttribute("pageNow", page.getPageNow());
        model.addAttribute("pageSize", page.getPageSize());
        model.addAttribute("totalPage", page.getTotalPage());
        model.addAttribute("totalCount", (int) page.getTotal());
        model.addAttribute("curPage", page.getPageNow());
    }

    @PostMapping("/administratorList")
    public String list(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                       @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                       @RequestParam(value = "userName", required = false) String userName,
                       @RequestParam(value = "accountName", required = false) String accountName,
                       Model model) {
        addPage(model, pageNow, pageSize, userName, accountName);
        return "admin/jsp/administrator/administratorList";
    }

    @GetMapping("/administratorAddPage")
    public String addPage(Model model) {
        prepareForm(model);
        return "admin/jsp/administrator/administratorAddPage";
    }

    private void prepareForm(Model model) {
        model.addAttribute("roleList", DbUtils.query(jdbc, "SELECT id, name FROM t_sys_role ORDER BY id"));
        model.addAttribute("orgList", DbUtils.query(jdbc, "SELECT id, org_name FROM t_org_info ORDER BY id"));
    }

    @PostMapping("/administratorSave")
    public String save(@RequestParam Map<String, String> params, HttpServletRequest request) {
        LoginUser login = (LoginUser) request.getSession().getAttribute(SecurityUtils.SESSION_USER);
        Number id = jdbc.queryForObject("SELECT IFNULL(MAX(id),0)+1 FROM t_sys_user", Number.class);
        String orgId = params.get("orgId");
        jdbc.update("INSERT INTO t_sys_user(user_name,account_name,pwd,locked,account_type,create_user_id,description,"
                        + "create_time,account_port_type,type,org_id) VALUES(?,?,?,0,1,?,?,NOW(),4,0,?)",
                params.get("userName"), params.get("accountName"), SecurityUtils.md5(params.get("pwd")),
                login.getId(), params.get("description"), orgId == null || orgId.isEmpty() ? null : Long.valueOf(orgId));
        String roleId = params.get("roleId");
        if (roleId != null && !roleId.isEmpty()) {
            jdbc.update("INSERT INTO t_sys_user_role(user_id, role_id) VALUES(?,?)", id.longValue(), Long.valueOf(roleId));
        }
        return "redirect:/admin/pc/administratorManage/administratorIndex";
    }

    @GetMapping("/administratorEditPage")
    public String editPage(@RequestParam("systemUserId") long systemUserId, Model model) {
        model.addAttribute("administratorInfo", DbUtils.queryOne(jdbc,
                "SELECT id, user_name, account_name, locked, description, org_id FROM t_sys_user WHERE id=?", systemUserId));
        model.addAttribute("currentRole", DbUtils.queryOne(jdbc,
                "SELECT role_id FROM t_sys_user_role WHERE user_id=? LIMIT 1", systemUserId));
        prepareForm(model);
        return "admin/jsp/administrator/administratorEditPage";
    }

    @PostMapping("/administratorUpdateSave")
    public String update(@RequestParam Map<String, String> params) {
        long userId = Long.parseLong(params.get("systemUserId"));
        String pwd = params.get("pwd");
        Object[] values;
        String sql;
        if (pwd != null && !pwd.trim().isEmpty()) {
            sql = "UPDATE t_sys_user SET user_name=?,account_name=?,pwd=?,locked=?,description=?,org_id=? WHERE id=?";
            String org = params.get("orgId");
            values = new Object[]{params.get("userName"), params.get("accountName"), SecurityUtils.md5(pwd),
                    parseLocked(params.get("locked")), params.get("description"),
                    org == null || org.isEmpty() ? null : Long.valueOf(org), userId};
        } else {
            sql = "UPDATE t_sys_user SET user_name=?,account_name=?,locked=?,description=?,org_id=? WHERE id=?";
            String org = params.get("orgId");
            values = new Object[]{params.get("userName"), params.get("accountName"), parseLocked(params.get("locked")),
                    params.get("description"), org == null || org.isEmpty() ? null : Long.valueOf(org), userId};
        }
        jdbc.update(sql, values);
        String roleId = params.get("roleId");
        if (roleId != null && !roleId.isEmpty()) {
            jdbc.update("DELETE FROM t_sys_user_role WHERE user_id=?", userId);
            jdbc.update("INSERT INTO t_sys_user_role(user_id, role_id) VALUES(?,?)", userId, Long.valueOf(roleId));
        }
        return "redirect:/admin/pc/administratorManage/administratorIndex";
    }

    private int parseLocked(String value) {
        return "1".equals(value) || "true".equalsIgnoreCase(value) ? 1 : 0;
    }

    @PostMapping("/administratorDelete")
    public String delete(@RequestParam(value = "systemUserIds", required = false) String ids,
                         @RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                         @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                         Model model, HttpServletRequest request) {
        LoginUser login = (LoginUser) request.getSession().getAttribute(SecurityUtils.SESSION_USER);
        if (ids != null) {
            for (String id : ids.split(",")) {
                long userId = Long.parseLong(id.trim());
                if (userId == login.getId()) {
                    continue;
                }
                jdbc.update("DELETE FROM t_sys_user_role WHERE user_id=?", userId);
                jdbc.update("DELETE FROM t_sys_user_action WHERE user_id=?", userId);
                jdbc.update("DELETE FROM t_sys_user WHERE id=?", userId);
            }
        }
        addPage(model, pageNow, pageSize, null, null);
        return "admin/jsp/administrator/administratorList";
    }

    @PostMapping("/chushihua")
    public String resetPassword(@RequestParam(value = "systemUserIds", required = false) String ids,
                                @RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                                @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                                Model model) {
        if (ids != null) {
            for (String id : ids.split(",")) {
                jdbc.update("UPDATE t_sys_user SET pwd=? WHERE id=?", SecurityUtils.md5("123456"),
                        Long.parseLong(id.trim()));
            }
        }
        addPage(model, pageNow, pageSize, null, null);
        return "admin/jsp/administrator/administratorList";
    }

    @GetMapping("/administratorAddAccountNameValidate")
    @ResponseBody
    public boolean addAccountNameValidate(@RequestParam("accountName") String accountName) {
        return DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_sys_user WHERE account_name=?", accountName) == 0;
    }

    @GetMapping("/administratorUpdateAccountNameValidate")
    @ResponseBody
    public boolean updateAccountNameValidate(@RequestParam("accountName") String accountName,
                                             @RequestParam(value = "systemUserId", defaultValue = "0") long id) {
        return DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_sys_user WHERE account_name=? AND id<>?",
                accountName, id) == 0;
    }

    @PostMapping("/administratorPermissionsPage")
    public String permissionsPage(@RequestParam("systemUserId") long systemUserId, Model model) {
        Map<String, Object> user = DbUtils.queryOne(jdbc,
                "SELECT id, user_name, account_name, description FROM t_sys_user WHERE id=?", systemUserId);
        Map<String, Object> roleUser = DbUtils.queryOne(jdbc,
                "SELECT r.id, r.name, r.description FROM t_sys_user_role ur JOIN t_sys_role r ON r.id=ur.role_id "
                        + "WHERE ur.user_id=? LIMIT 1", systemUserId);
        model.addAttribute("userModel", user);
        model.addAttribute("roleModel", roleUser);
        Set<Long> roleResources = new HashSet<Long>();
        if (roleUser != null) {
            List<Map<String, Object>> list = DbUtils.query(jdbc,
                    "SELECT res_id FROM t_sys_role_action WHERE role_id=?", roleUser.get("id"));
            for (Map<String, Object> item : list) {
                roleResources.add(((Number) item.get("resId")).longValue());
            }
        }
        Set<Long> userResources = new HashSet<Long>();
        for (Map<String, Object> item : DbUtils.query(jdbc,
                "SELECT res_id FROM t_sys_user_action WHERE user_id=?", systemUserId)) {
            userResources.add(((Number) item.get("resId")).longValue());
        }
        List<Map<String, Object>> tree = menuService.tree(false);
        markPermissions(tree, roleResources, userResources);
        model.addAttribute("menuList", tree);
        return "admin/jsp/administrator/administratorPermissionsPage";
    }

    @SuppressWarnings("unchecked")
    private void markPermissions(List<Map<String, Object>> nodes, Set<Long> roleResources, Set<Long> userResources) {
        for (Map<String, Object> node : nodes) {
            long id = ((Number) node.get("id")).longValue();
            node.put("permissionsStatus", roleResources.contains(id) ? 0 : 1);
            node.put("permissionsStatus2", roleResources.contains(id) || !userResources.contains(id) ? 0 : 1);
            Object children = node.get("children");
            if (children instanceof List) {
                markPermissions((List<Map<String, Object>>) children, roleResources, userResources);
            }
        }
    }

    @PostMapping("/administratorPermissionsSave")
    public String permissionsSave(@RequestParam Map<String, String> params,
                                  @RequestParam(value = "resourcesId", required = false) List<Long> resources,
                                  HttpServletRequest request) {
        if (params.get("systemUserId") == null) {
            return "redirect:/admin/pc/administratorManage/administratorIndex";
        }
        long userId = Long.parseLong(params.get("systemUserId"));
        jdbc.update("DELETE FROM t_sys_user_action WHERE user_id=?", userId);
        if (resources != null) {
            for (Long resourceId : resources) {
                if (resourceId != null && resourceId > 0) {
                    jdbc.update("INSERT INTO t_sys_user_action(res_id,user_id) VALUES(?,?)", resourceId, userId);
                }
            }
        }
        return "redirect:/admin/pc/administratorManage/administratorIndex";
    }
}
