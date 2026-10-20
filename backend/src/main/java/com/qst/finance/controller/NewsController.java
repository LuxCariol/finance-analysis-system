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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/msg")
public class NewsController {
    private final JdbcTemplate jdbc;
    private final PageSupport pageSupport;
    private final MenuService menuService;

    public NewsController(JdbcTemplate jdbc, PageSupport pageSupport, MenuService menuService) {
        this.jdbc = jdbc;
        this.pageSupport = pageSupport;
        this.menuService = menuService;
    }

    @GetMapping("/msgIndex")
    public String index(Model model) {
        menu(model);
        return "admin/jsp/msg/msgIndex";
    }

    private void menu(Model model) {
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", 400);
        model.addAttribute("menuId", 410);
        model.addAttribute("buttonList", menuService.buttons(410));
    }

    @GetMapping("/msgListAndButtonList")
    public String listAndButtons(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                                 @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                                 Model model) {
        menu(model);
        addPage(model, pageNow, pageSize, null, null);
        return "admin/jsp/msg/msgListAndButtonList";
    }

    private void addPage(Model model, int pageNow, int pageSize, String title, String author) {
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> args = new ArrayList<Object>();
        if (title != null && !title.trim().isEmpty()) {
            where.append(" AND TITLE LIKE ?");
            args.add("%" + title.trim() + "%");
        }
        if (author != null && !author.trim().isEmpty()) {
            where.append(" AND AUTHOR LIKE ?");
            args.add("%" + author.trim() + "%");
        }
        PageData<Map<String, Object>> page = pageSupport.page(
                "SELECT * FROM t_message_info" + where + " ORDER BY CREATE_TIME DESC, ID DESC",
                "SELECT COUNT(*) FROM t_message_info" + where, pageNow, pageSize, args.toArray());
        model.addAttribute("msgList", page.getList());
        model.addAttribute("pageNow", page.getPageNow());
        model.addAttribute("pageSize", page.getPageSize());
        model.addAttribute("totalPage", page.getTotalPage());
        model.addAttribute("totalCount", (int) page.getTotal());
        model.addAttribute("curPage", page.getPageNow());
    }

    @GetMapping("/msgList")
    public String list(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                       @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                       @RequestParam(value = "title", required = false) String title,
                       @RequestParam(value = "author", required = false) String author,
                       Model model) {
        addPage(model, pageNow, pageSize, title, author);
        return "admin/jsp/msg/msgList";
    }

    @GetMapping("/addMsg")
    public String addPage() {
        return "admin/jsp/msg/msgAddPage";
    }

    @PostMapping("/msgSave")
    @ResponseBody
    public String save(@RequestBody Map<String, Object> body) {
        jdbc.update("INSERT INTO t_message_info(ARRY_QUE,TITLE,CONTENT,VIEW_NUM,AUTHOR,UP_DATE,UP_PERSON,"
                        + "UP_PERSON_TEL,CREATE_TIME,CREATE_USER,UPDATE_TIME,UPDATE_USER,CLZZ) "
                        + "VALUES(?,?,?,?,?,CURDATE(),?,?,NOW(),?,NOW(),?,?)",
                value(body, "arryQue"), value(body, "title"), value(body, "content"),
                parseInt(value(body, "viewNum"), 0), value(body, "author"), value(body, "upPerson"),
                value(body, "upPersonTel"), "admin", "admin", value(body, "clzz"));
        return "success";
    }

    @GetMapping("/msgEditPage")
    public String editPage(@RequestParam("msgId") long msgId, Model model) {
        model.addAttribute("msg", DbUtils.queryOne(jdbc, "SELECT * FROM t_message_info WHERE ID=?", msgId));
        return "admin/jsp/msg/msgEditPage";
    }

    @PostMapping("/msgUpdateSave")
    @ResponseBody
    public String update(@RequestBody Map<String, Object> body) {
        String idValue = value(body, "msgId");
        if (idValue == null || idValue.isEmpty()) {
            idValue = value(body, "id");
        }
        jdbc.update("UPDATE t_message_info SET ARRY_QUE=?,TITLE=?,CONTENT=?,VIEW_NUM=?,AUTHOR=?,UP_PERSON=?,"
                        + "UP_PERSON_TEL=?,UPDATE_TIME=NOW(),UPDATE_USER=?,CLZZ=? WHERE ID=?",
                value(body, "arryQue"), value(body, "title"), value(body, "content"),
                parseInt(value(body, "viewNum"), 0), value(body, "author"), value(body, "upPerson"),
                value(body, "upPersonTel"), "admin", value(body, "clzz"), Long.parseLong(idValue));
        return "success";
    }

    @PostMapping("/msgDelete")
    public String delete(@RequestParam(value = "msgId", required = false) String ids,
                         @RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                         @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                         Model model) {
        if (ids != null) {
            for (String id : ids.split(",")) {
                jdbc.update("DELETE FROM t_message_info WHERE ID=?", id.trim());
            }
        }
        addPage(model, pageNow, pageSize, null, null);
        return "admin/jsp/msg/msgList";
    }

    private String value(Map<String, Object> body, String key) {
        Object value = body.get(key);
        return value == null ? null : String.valueOf(value);
    }

    private int parseInt(String value, int defaultValue) {
        try {
            return value == null || value.trim().isEmpty() ? defaultValue : Integer.parseInt(value.trim());
        } catch (NumberFormatException ex) {
            return defaultValue;
        }
    }
}
