package com.qst.finance.controller;

import com.qst.finance.common.DbUtils;
import com.qst.finance.common.PageData;
import com.qst.finance.service.MenuService;
import com.qst.finance.service.PageSupport;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/orgInfo")
public class CompanyController {
    private final JdbcTemplate jdbc;
    private final PageSupport pageSupport;
    private final MenuService menuService;

    public CompanyController(JdbcTemplate jdbc, PageSupport pageSupport, MenuService menuService) {
        this.jdbc = jdbc;
        this.pageSupport = pageSupport;
        this.menuService = menuService;
    }

    @GetMapping("/orgInfoIndex")
    public String index(Model model) {
        menu(model);
        return "admin/jsp/orgInfo/orgInfoIndex";
    }

    private void menu(Model model) {
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", 200);
        model.addAttribute("menuId", 210);
    }

    @GetMapping("/orgInfoList")
    public String list(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                       @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                       @RequestParam(value = "orgName", required = false) String orgName,
                       @RequestParam(value = "legalerName", required = false) String legalerName,
                       @RequestParam(value = "isList", required = false) String isList,
                       @RequestParam(value = "resPersonTel", required = false) String resPersonTel,
                       Model model) {
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> args = new ArrayList<Object>();
        if (orgName != null && !orgName.trim().isEmpty()) {
            where.append(" AND org_name LIKE ?");
            args.add("%" + orgName.trim() + "%");
        }
        if (legalerName != null && !legalerName.trim().isEmpty()) {
            where.append(" AND legaler_name LIKE ?");
            args.add("%" + legalerName.trim() + "%");
        }
        if (isList != null && !isList.trim().isEmpty()) {
            where.append(" AND is_list = ?");
            args.add(isList.trim());
        }
        if (resPersonTel != null && !resPersonTel.trim().isEmpty()) {
            where.append(" AND res_person_tel LIKE ?");
            args.add("%" + resPersonTel.trim() + "%");
        }
        PageData<Map<String, Object>> page = pageSupport.page(
                "SELECT * FROM t_org_info" + where + " ORDER BY id",
                "SELECT COUNT(*) FROM t_org_info" + where, pageNow, pageSize, args.toArray());
        model.addAttribute("orgInfoList", page.getList());
        model.addAttribute("pageNow", page.getPageNow());
        model.addAttribute("pageSize", page.getPageSize());
        model.addAttribute("totalPage", page.getTotalPage());
        model.addAttribute("totalCount", (int) page.getTotal());
        model.addAttribute("curPage", page.getPageNow());
        return "admin/jsp/orgInfo/orgInfoList";
    }

    @GetMapping("/orgAddPage")
    public String addPage(Model model) {
        prepareForm(model);
        return "admin/jsp/orgInfo/orgInfoAddPage";
    }

    private void prepareForm(Model model) {
        model.addAttribute("orgList", DbUtils.query(jdbc, "SELECT id, org_name FROM t_org_info ORDER BY id"));
        List<Map<String, Object>> limits = new ArrayList<Map<String, Object>>();
        limits.add(ApiMap.of("value", "1", "name", "企业会计准则"));
        limits.add(ApiMap.of("value", "2", "name", "小企业会计准则"));
        limits.add(ApiMap.of("value", "3", "name", "金蝶KIS格式"));
        model.addAttribute("disList", limits);
    }

    private static final class ApiMap {
        private static Map<String, Object> of(Object... values) {
            java.util.LinkedHashMap<String, Object> map = new java.util.LinkedHashMap<String, Object>();
            for (int i = 0; i + 1 < values.length; i += 2) {
                map.put(String.valueOf(values[i]), values[i + 1]);
            }
            return map;
        }
    }

    @PostMapping("/orgSave")
    public String save(@RequestParam Map<String, String> params) {
        jdbc.update("INSERT INTO t_org_info(ORG_NAME,SHORT_NAME,ORG_REMARK,BUSINESS_NUM,LEGALER_NAME,PAID_CAPITAL,"
                        + "CONFUSING_CAPITAL,REGISTERED_ADDR,INDUSTRY,IS_LIST,ORG_PROPERTY,RES_PERSON_NAME,ORG_TOTAL_PER,"
                        + "RES_PERSON_TEL,ORG_ADDR,REPORT_LIMIT,parent_id) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                params.get("orgName"), params.get("shortName"), params.get("orgRemark"), params.get("businessNum"),
                params.get("legalerName"), params.get("paidCapital"), params.get("confusingCapital"),
                params.get("registeredAddr"), params.get("industry"), params.get("isList"), params.get("orgProperty"),
                params.get("resPersonName"), parseLong(params.get("orgTotalPer")), params.get("resPersonTel"),
                params.get("orgAddr"), params.get("reportLimit"), parseLong(params.get("parentId")));
        return "redirect:/orgInfo/orgInfoIndex";
    }

    @GetMapping("/orgEditPage")
    public String editPage(@RequestParam("orgId") long orgId, Model model) {
        model.addAttribute("orgInfo", DbUtils.queryOne(jdbc, "SELECT * FROM t_org_info WHERE id=?", orgId));
        prepareForm(model);
        return "admin/jsp/orgInfo/orgInfoEditPage";
    }

    @PostMapping("/orgEdit")
    public String update(@RequestParam Map<String, String> params) {
        jdbc.update("UPDATE t_org_info SET ORG_NAME=?,SHORT_NAME=?,ORG_REMARK=?,BUSINESS_NUM=?,LEGALER_NAME=?,"
                        + "PAID_CAPITAL=?,CONFUSING_CAPITAL=?,REGISTERED_ADDR=?,INDUSTRY=?,IS_LIST=?,ORG_PROPERTY=?,"
                        + "RES_PERSON_NAME=?,RES_PERSON_TEL=?,ORG_ADDR=?,REPORT_LIMIT=?,parent_id=? WHERE id=?",
                params.get("orgName"), params.get("shortName"), params.get("orgRemark"), params.get("businessNum"),
                params.get("legalerName"), params.get("paidCapital"), params.get("confusingCapital"),
                params.get("registeredAddr"), params.get("industry"), params.get("isList"), params.get("orgProperty"),
                params.get("resPersonName"), params.get("resPersonTel"), params.get("orgAddr"),
                params.get("reportLimit"), parseLong(params.get("parentId")), Long.parseLong(params.get("id")));
        return "redirect:/orgInfo/orgInfoIndex";
    }

    private Long parseLong(String value) {
        try {
            return value == null || value.trim().isEmpty() ? null : Long.valueOf(value.trim());
        } catch (NumberFormatException ex) {
            return null;
        }
    }
}
