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
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/mode")
public class ModeController {
    private final JdbcTemplate jdbc;
    private final PageSupport pageSupport;
    private final MenuService menuService;

    public ModeController(JdbcTemplate jdbc, PageSupport pageSupport, MenuService menuService) {
        this.jdbc = jdbc;
        this.pageSupport = pageSupport;
        this.menuService = menuService;
    }

    @GetMapping("/tModeIndex")
    public String index(Model model) {
        menu(model);
        return "admin/jsp/mode/tModeIndex";
    }

    private void menu(Model model) {
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", 300);
        model.addAttribute("menuId", 313);
        model.addAttribute("buttonList", menuService.buttons(313));
    }

    @GetMapping("/tModeListAndButtonList")
    public String listAndButtons(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                                 @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                                 Model model) {
        menu(model);
        addPage(model, pageNow, pageSize, null);
        return "admin/jsp/mode/tModeListAndButtonList";
    }

    private void addPage(Model model, int pageNow, int pageSize, String reportType) {
        String where = reportType == null || reportType.trim().isEmpty() ? "" : " WHERE REPORT_TYPE=?";
        PageData<Map<String, Object>> page = reportType == null || reportType.trim().isEmpty()
                ? pageSupport.page("SELECT * FROM t_mode ORDER BY PX,ID", "SELECT COUNT(*) FROM t_mode", pageNow, pageSize)
                : pageSupport.page("SELECT * FROM t_mode" + where + " ORDER BY PX,ID",
                "SELECT COUNT(*) FROM t_mode" + where, pageNow, pageSize, reportType);
        model.addAttribute("tModeList", page.getList());
        model.addAttribute("pageNow", page.getPageNow());
        model.addAttribute("pageSize", page.getPageSize());
        model.addAttribute("totalPage", page.getTotalPage());
        model.addAttribute("totalCount", (int) page.getTotal());
        model.addAttribute("curPage", page.getPageNow());
    }

    @GetMapping("/tModeList")
    public String list(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                       @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                       @RequestParam(value = "reportType", required = false) String reportType,
                       Model model) {
        addPage(model, pageNow, pageSize, reportType);
        return "admin/jsp/mode/tModeList";
    }

    @GetMapping("/addTMode")
    public String addPage(@RequestParam(value = "pages", required = false) String pages, Model model) {
        model.addAttribute("pages", pages);
        return "admin/jsp/mode/tModeAddPage";
    }

    @PostMapping("/tModeSave")
    public String save(@RequestParam Map<String, String> params) {
        jdbc.update("INSERT INTO t_mode(REPORT_TYPE,REPORT_CONTEN,MODE_CONDITION,MODE_CONTENT,MODE_VALUES,REMARK,"
                        + "MODE_AREA,CONDITION_VALUES,PX) VALUES(?,?,?,?,?,?,?,?,?)",
                params.get("reportType"), params.get("reportConten"), params.get("modeCondition"),
                params.get("modeContent"), params.get("modeValues"), params.get("remark"), params.get("modeArea"),
                params.get("conditionValues"), parseInt(params.get("px"), 0));
        return "redirect:/mode/tModeIndex";
    }

    @GetMapping("/tModeEditPage")
    public String editPage(@RequestParam("tModeId") long tModeId,
                           @RequestParam(value = "pages", required = false) String pages, Model model) {
        model.addAttribute("tMode", DbUtils.queryOne(jdbc, "SELECT * FROM t_mode WHERE ID=?", tModeId));
        model.addAttribute("pages", pages);
        return "admin/jsp/mode/tModeEditPage";
    }

    @PostMapping("/tModeUpdateSave")
    public String update(@RequestParam Map<String, String> params) {
        jdbc.update("UPDATE t_mode SET REPORT_TYPE=?,REPORT_CONTEN=?,MODE_CONDITION=?,MODE_CONTENT=?,MODE_VALUES=?,"
                        + "REMARK=?,MODE_AREA=?,CONDITION_VALUES=?,PX=? WHERE ID=?",
                params.get("reportType"), params.get("reportConten"), params.get("modeCondition"),
                params.get("modeContent"), params.get("modeValues"), params.get("remark"), params.get("modeArea"),
                params.get("conditionValues"), parseInt(params.get("px"), 0), Long.parseLong(params.get("tModeId")));
        return "redirect:/mode/tModeIndex";
    }

    @PostMapping("/tModeDelete")
    public String delete(@RequestParam(value = "tModeId", required = false) String ids,
                         @RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                         @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                         Model model) {
        if (ids != null) {
            for (String id : ids.split(",")) {
                jdbc.update("DELETE FROM t_mode WHERE ID=?", id.trim());
            }
        }
        addPage(model, pageNow, pageSize, null);
        return "admin/jsp/mode/tModeList";
    }

    private int parseInt(String value, int defaultValue) {
        try {
            return value == null || value.trim().isEmpty() ? defaultValue : Integer.parseInt(value.trim());
        } catch (NumberFormatException ex) {
            return defaultValue;
        }
    }
}
