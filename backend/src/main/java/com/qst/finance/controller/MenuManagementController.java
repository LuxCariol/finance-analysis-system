package com.qst.finance.controller;

import com.qst.finance.common.ApiResult;
import com.qst.finance.common.DbUtils;
import com.qst.finance.service.MenuService;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/pc/resources")
public class MenuManagementController {
    private final MenuService menuService;
    private final JdbcTemplate jdbc;

    public MenuManagementController(MenuService menuService, JdbcTemplate jdbc) {
        this.menuService = menuService;
        this.jdbc = jdbc;
    }

    @GetMapping("/menuManageIndex")
    public String index(Model model) {
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", 1);
        model.addAttribute("menuId", 2);
        return "admin/jsp/menu/menuIndex";
    }

    @GetMapping("/menuList")
    public String list(Model model) {
        model.addAttribute("menuList", menuService.tree(false));
        model.addAttribute("buttonList", menuService.buttons(2));
        return "admin/jsp/menu/menuList";
    }

    @GetMapping("/menuRootList")
    public String rootList(Model model) {
        List<Map<String, Object>> roots = DbUtils.query(jdbc,
                "SELECT id, name FROM t_sys_resources WHERE parent_id = 0 AND type = '0' ORDER BY order_no, id");
        model.addAttribute("menuRootList", roots);
        return "admin/jsp/menu/menuRootList";
    }

    @GetMapping("/menuRootSonList")
    public String sonList(@RequestParam("rootMenuId") long rootMenuId, Model model) {
        model.addAttribute("sonMenuList", DbUtils.query(jdbc,
                "SELECT id, name FROM t_sys_resources WHERE parent_id = ? AND type = '1' ORDER BY order_no, id",
                rootMenuId));
        return "admin/jsp/menu/menuRootSonList";
    }

    @PostMapping("/menuRootSave")
    public String save(@RequestParam Map<String, String> params, HttpServletResponse response) throws IOException {
        String type = params.get("menuType");
        int parentId;
        if ("0".equals(type)) {
            parentId = 0;
        } else if ("2".equals(type)) {
            String sonId = params.get("sonId");
            parentId = sonId == null || sonId.isEmpty() ? Integer.parseInt(params.get("parentId")) : Integer.parseInt(sonId);
        } else {
            parentId = Integer.parseInt(params.getOrDefault("parentId", "0"));
        }
        int order = parseInt(params.get("level"), 999);
        jdbc.update("INSERT INTO t_sys_resources(name,parent_id,res_key,type,res_url,order_no,icon,btn,is_hide,description) "
                        + "VALUES(?,?,?,?,?,?,?,?,0,?)",
                params.get("name"), parentId, params.getOrDefault("resKey", "menu_" + System.currentTimeMillis()),
                type, params.getOrDefault("resUrl", "/"), order, blank(params.get("icon")),
                params.get("btn"), params.get("description"));
        response.sendRedirect("/admin/pc/resources/menuManageIndex");
        return null;
    }

    @PostMapping("/menuEdit")
    @ResponseBody
    public Map<String, Object> edit(@RequestParam("resourceId") long resourceId) {
        Map<String, Object> menu = DbUtils.queryOne(jdbc,
                "SELECT id, name, parent_id, res_key, type, res_url, order_no, icon, btn, description "
                        + "FROM t_sys_resources WHERE id = ?", resourceId);
        return menu == null ? new java.util.LinkedHashMap<String, Object>() : menu;
    }

    @PostMapping("/menuUpdate")
    public String update(@RequestParam Map<String, String> params, HttpServletResponse response) throws IOException {
        jdbc.update("UPDATE t_sys_resources SET name=?, res_key=?, res_url=?, order_no=?, icon=?, btn=?, description=? WHERE id=?",
                params.get("name"), params.get("resKey"), params.get("resUrl"),
                parseInt(params.get("level"), 999), blank(params.get("icon")), blank(params.get("btn")),
                params.get("description"), Long.parseLong(params.get("resourcesId")));
        response.sendRedirect("/admin/pc/resources/menuManageIndex");
        return null;
    }

    @PostMapping("/menuDelete")
    public String delete(@RequestParam(value = "ids", required = false) String ids,
                         HttpServletResponse response) throws IOException {
        if (ids != null) {
            for (String id : ids.split(",")) {
                if (id.trim().isEmpty()) {
                    continue;
                }
                long menuId = Long.parseLong(id.trim());
                jdbc.update("DELETE FROM t_sys_role_action WHERE res_id = ?", menuId);
                jdbc.update("DELETE FROM t_sys_user_action WHERE res_id = ?", menuId);
                jdbc.update("DELETE FROM t_sys_resources WHERE id = ?", menuId);
            }
        }
        response.sendRedirect("/admin/pc/resources/menuManageIndex");
        return null;
    }

    private int parseInt(String value, int defaultValue) {
        try {
            return value == null || value.trim().isEmpty() ? defaultValue : Integer.parseInt(value.trim());
        } catch (NumberFormatException ex) {
            return defaultValue;
        }
    }

    private String blank(String value) {
        return value == null || value.trim().isEmpty() ? null : value.trim();
    }
}
