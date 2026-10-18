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
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/pc/roleManage")
public class RoleController {
    private final JdbcTemplate jdbc;
    private final PageSupport pageSupport;
    private final MenuService menuService;

    public RoleController(JdbcTemplate jdbc, PageSupport pageSupport, MenuService menuService) {
        this.jdbc = jdbc;
        this.pageSupport = pageSupport;
        this.menuService = menuService;
    }

    @GetMapping("/roleManageIndex")
    public String index(Model model) {
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", 1);
        model.addAttribute("menuId", 99);
        return "admin/jsp/role/roleManageIndex";
    }

    @GetMapping("/roleListAndButtonList")
    public String listAndButtons(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                                 @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                                 Model model) {
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", 1);
        model.addAttribute("menuId", 99);
        model.addAttribute("buttonList", menuService.buttons(99));
        addPage(model, pageNow, pageSize, null);
        return "admin/jsp/role/roleListAndButtonList";
    }

    private void addPage(Model model, int pageNow, int pageSize, String userName) {
        String filter = userName == null || userName.trim().isEmpty() ? "" : " WHERE r.name LIKE ?";
        String select = "SELECT r.id, r.name, r.description, r.create_time, u.user_name "
                + "FROM t_sys_role r LEFT JOIN t_sys_user u ON u.id = r.user_id" + filter
                + " ORDER BY r.id DESC";
        String count = "SELECT COUNT(*) FROM t_sys_role r" + filter;
        PageData<Map<String, Object>> page = userName == null || userName.trim().isEmpty()
                ? pageSupport.page(select, count, pageNow, pageSize)
                : pageSupport.page(select, count, pageNow, pageSize, "%" + userName.trim() + "%");
        model.addAttribute("roleList", page.getList());
        model.addAttribute("pageNow", page.getPageNow());
        model.addAttribute("pageSize", page.getPageSize());
        model.addAttribute("totalPage", page.getTotalPage());
        model.addAttribute("totalCount", (int) page.getTotal());
        model.addAttribute("curPage", page.getPageNow());
    }

    @GetMapping("/roleList")
    public String list(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                       @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                       @RequestParam(value = "userName", required = false) String userName,
                       Model model) {
        addPage(model, pageNow, pageSize, userName);
        return "admin/jsp/role/roleList";
    }

    @GetMapping("/roleAddPage")
    public String addPage(Model model) {
        model.addAttribute("message", "");
        return "admin/jsp/role/roleAddPage";
    }

    @PostMapping("/roleSave")
    public String save(@RequestParam Map<String, String> params, HttpServletRequest request) {
        LoginUser user = (LoginUser) request.getSession().getAttribute(SecurityUtils.SESSION_USER);
        jdbc.update("INSERT INTO t_sys_role(name,user_id,description,create_time) VALUES(?,?,?,NOW())",
                params.get("name"), user.getId(), params.get("description"));
        return "redirect:/admin/pc/roleManage/roleManageIndex";
    }

    @GetMapping("/roleEditPage")
    public String editPage(@RequestParam("roleId") long roleId, Model model) {
        model.addAttribute("role", DbUtils.queryOne(jdbc,
                "SELECT id, name, description, create_time FROM t_sys_role WHERE id = ?", roleId));
        return "admin/jsp/role/roleEditPage";
    }

    @PostMapping("/roleUpdateSave")
    public String update(@RequestParam Map<String, String> params) {
        jdbc.update("UPDATE t_sys_role SET name=?, description=? WHERE id=?",
                params.get("name"), params.get("description"), Long.parseLong(params.get("roleId")));
        return "redirect:/admin/pc/roleManage/roleManageIndex";
    }

    @PostMapping("/roleDelete")
    public String delete(@RequestParam(value = "roleId", required = false) String roleId,
                         @RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                         @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                         Model model) {
        if (roleId != null) {
            for (String id : roleId.split(",")) {
                long role = Long.parseLong(id.trim());
                jdbc.update("DELETE FROM t_sys_role_action WHERE role_id=?", role);
                jdbc.update("DELETE FROM t_sys_user_role WHERE role_id=?", role);
                jdbc.update("DELETE FROM t_sys_role WHERE id=?", role);
            }
        }
        addPage(model, pageNow, pageSize, null);
        return "admin/jsp/role/roleList";
    }

    @GetMapping("/roleAddNameValidate")
    @ResponseBody
    public boolean addNameValidate(@RequestParam("name") String name) {
        return DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_sys_role WHERE name=?", name) == 0;
    }

    @GetMapping("/roleUpdateNameValidate")
    @ResponseBody
    public boolean updateNameValidate(@RequestParam("name") String name, @RequestParam("roleId") long roleId) {
        return DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_sys_role WHERE name=? AND id<>?", name, roleId) == 0;
    }
}
