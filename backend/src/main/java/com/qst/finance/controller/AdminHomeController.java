package com.qst.finance.controller;

import com.qst.finance.common.DbUtils;
import com.qst.finance.common.SecurityUtils;
import com.qst.finance.service.AuthService;
import com.qst.finance.service.LoginUser;
import com.qst.finance.service.MenuService;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/pc")
public class AdminHomeController {
    private final MenuService menuService;
    private final AuthService authService;
    private final JdbcTemplate jdbc;

    public AdminHomeController(MenuService menuService, AuthService authService, JdbcTemplate jdbc) {
        this.menuService = menuService;
        this.authService = authService;
        this.jdbc = jdbc;
    }

    @GetMapping("/index")
    public String index(Model model) {
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", 0);
        model.addAttribute("menuId", 0);
        model.addAttribute("stats", dashboardStats());
        return "admin/jsp/index";
    }

    private Map<String, Object> dashboardStats() {
        Map<String, Object> stats = new LinkedHashMap<String, Object>();
        stats.put("companies", DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_org_info"));
        stats.put("users", DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_sys_user"));
        stats.put("profit", DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_basi_profit"));
        stats.put("balance", DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_basi_assets_and_liabilities"));
        stats.put("cash", DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_basi_cash_flow"));
        stats.put("kmye", DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_kmye"));
        stats.put("age", DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_age_analysis"));
        return stats;
    }

    @GetMapping("/administratorManage/administratorInfoPage")
    public String profilePage(HttpServletRequest request, Model model) {
        LoginUser sessionUser = (LoginUser) request.getSession().getAttribute(SecurityUtils.SESSION_USER);
        model.addAttribute("administratorInfo", DbUtils.queryOne(jdbc,
                "SELECT id, user_name, account_name, description, org_id, locked FROM t_sys_user WHERE id = ?",
                sessionUser.getId()));
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", 0);
        model.addAttribute("menuId", 0);
        return "admin/jsp/administrator/administratorInfoPage";
    }

    @PostMapping("/administratorManage/administratorInfoUpdate")
    @ResponseBody
    public String updateProfile(@RequestParam Map<String, String> params, HttpServletRequest request) {
        LoginUser sessionUser = (LoginUser) request.getSession().getAttribute(SecurityUtils.SESSION_USER);
        Map<String, Object> current = DbUtils.queryOne(jdbc,
                "SELECT pwd FROM t_sys_user WHERE id = ?", sessionUser.getId());
        String pwd = params.get("pwd");
        String oldPwd = params.get("oldPwd");
        if (pwd != null && !pwd.isEmpty()) {
            String stored = DbUtils.str(current, "pwd", "");
            if (oldPwd == null || (!stored.equalsIgnoreCase(SecurityUtils.md5(oldPwd)) && !stored.equals(oldPwd))) {
                return "oldPwdIsErr";
            }
            if (!pwd.equals(params.get("password"))) {
                return "pwdIsErr";
            }
            jdbc.update("UPDATE t_sys_user SET user_name=?, pwd=?, description=? WHERE id=?",
                    params.get("userName"), SecurityUtils.md5(pwd), params.get("description"), sessionUser.getId());
        } else {
            jdbc.update("UPDATE t_sys_user SET user_name=?, description=? WHERE id=?",
                    params.get("userName"), params.get("description"), sessionUser.getId());
        }
        LoginUser refreshed = authService.findById(sessionUser.getId());
        request.getSession().setAttribute(SecurityUtils.SESSION_USER, refreshed);
        return "success";
    }
}
