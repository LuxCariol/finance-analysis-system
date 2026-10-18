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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/pc/systemDictionary")
public class DictionaryController {
    private final JdbcTemplate jdbc;
    private final PageSupport pageSupport;
    private final MenuService menuService;

    public DictionaryController(JdbcTemplate jdbc, PageSupport pageSupport, MenuService menuService) {
        this.jdbc = jdbc;
        this.pageSupport = pageSupport;
        this.menuService = menuService;
    }

    @GetMapping("/systemDictionaryIndex")
    public String index(Model model) {
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", 1);
        model.addAttribute("menuId", 119);
        return "admin/jsp/systemDictionary/systemDictionaryIndex";
    }

    @GetMapping("/systemDictionaryListAndButtonList")
    public String listAndButtons(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                                 @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                                 Model model) {
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", 1);
        model.addAttribute("menuId", 119);
        model.addAttribute("buttonList", menuService.buttons(119));
        addPage(model, pageNow, pageSize, null, null);
        return "admin/jsp/systemDictionary/systemDictionaryListAndButtonList";
    }

    private void addPage(Model model, int pageNow, int pageSize, String cnName, String enName) {
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> args = new ArrayList<Object>();
        if (cnName != null && !cnName.trim().isEmpty()) {
            where.append(" AND d.cn_name LIKE ?");
            args.add("%" + cnName.trim() + "%");
        }
        if (enName != null && !enName.trim().isEmpty()) {
            where.append(" AND d.en_name LIKE ?");
            args.add("%" + enName.trim() + "%");
        }
        String select = "SELECT d.*, cu.user_name AS create_user_name, uu.user_name AS update_user_name "
                + "FROM t_sys_dictionary d LEFT JOIN t_sys_user cu ON cu.id=d.create_user_id "
                + "LEFT JOIN t_sys_user uu ON uu.id=d.update_user_id" + where + " ORDER BY d.id DESC";
        String count = "SELECT COUNT(*) FROM t_sys_dictionary d" + where;
        PageData<Map<String, Object>> page = pageSupport.page(select, count, pageNow, pageSize, args.toArray());
        model.addAttribute("dictionaryList", page.getList());
        model.addAttribute("pageNow", page.getPageNow());
        model.addAttribute("pageSize", page.getPageSize());
        model.addAttribute("totalPage", page.getTotalPage());
        model.addAttribute("totalCount", (int) page.getTotal());
        model.addAttribute("curPage", page.getPageNow());
    }

    @PostMapping("/systemDictionaryList")
    public String list(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                       @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                       @RequestParam(value = "cnNameSearch", required = false) String cnName,
                       @RequestParam(value = "enNameSearch", required = false) String enName,
                       Model model) {
        addPage(model, pageNow, pageSize, cnName, enName);
        return "admin/jsp/systemDictionary/systemDictionaryList";
    }

    @GetMapping("/systemDictionaryAddPage")
    public String addPage() {
        return "admin/jsp/systemDictionary/systemDictionaryAddPage";
    }

    @PostMapping("/systemDictionarySave")
    public String save(@RequestParam Map<String, String> params,
                       @RequestParam(value = "detailName", required = false) String[] detailNames,
                       @RequestParam(value = "detailValue", required = false) String[] detailValues,
                       @RequestParam(value = "detailRemark", required = false) String[] detailRemarks,
                       HttpServletRequest request) {
        LoginUser user = (LoginUser) request.getSession().getAttribute(SecurityUtils.SESSION_USER);
        String flag = params.get("flag") == null ? "0" : "1";
        jdbc.update("INSERT INTO t_sys_dictionary(cn_name,en_name,flag,remark,create_time,create_user_id,update_time,update_user_id) "
                        + "VALUES(?,?,?,?,NOW(),?,NOW(),?)",
                params.get("cnName"), params.get("enName"), flag, params.get("description"), user.getId(), user.getId());
        Long id = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Long.class);
        saveDetails(id, detailNames, detailValues, detailRemarks);
        return "redirect:/admin/pc/systemDictionary/systemDictionaryIndex";
    }

    private void saveDetails(Long dictionaryId, String[] names, String[] values, String[] remarks) {
        if (names == null) {
            return;
        }
        for (int i = 0; i < names.length; i++) {
            if (names[i] == null || names[i].trim().isEmpty()) {
                continue;
            }
            jdbc.update("INSERT INTO t_sys_dictionary_detail(name,value,remark,dictionary_id) VALUES(?,?,?,?)",
                    names[i].trim(), arrayValue(values, i), arrayValue(remarks, i), String.valueOf(dictionaryId));
        }
    }

    private String arrayValue(String[] values, int index) {
        return values == null || index >= values.length ? null : values[index];
    }

    @GetMapping("/systemDictionaryEditPage")
    public String editPage(@RequestParam("dictionaryId") long dictionaryId, Model model) {
        model.addAttribute("dictionaryModel", DbUtils.queryOne(jdbc,
                "SELECT id, cn_name, en_name, flag, remark FROM t_sys_dictionary WHERE id=?", dictionaryId));
        model.addAttribute("dictionaryDetaiList", DbUtils.query(jdbc,
                "SELECT id, name, value, remark FROM t_sys_dictionary_detail WHERE dictionary_id=? ORDER BY id",
                String.valueOf(dictionaryId)));
        return "admin/jsp/systemDictionary/systemDictionaryEditPage";
    }

    @GetMapping("/systemDictionaryWhetherCanEdit")
    @ResponseBody
    public boolean canEdit(@RequestParam("dictionaryId") long dictionaryId) {
        Map<String, Object> row = DbUtils.queryOne(jdbc,
                "SELECT flag FROM t_sys_dictionary WHERE id=?", dictionaryId);
        return row != null && "1".equals(DbUtils.str(row, "flag"));
    }

    @PostMapping("/systemDictionaryUpdateSave")
    public String update(@RequestParam Map<String, String> params,
                         @RequestParam(value = "detailName", required = false) String[] detailNames,
                         @RequestParam(value = "detailValue", required = false) String[] detailValues,
                         @RequestParam(value = "detailRemark", required = false) String[] detailRemarks,
                         HttpServletRequest request) {
        LoginUser user = (LoginUser) request.getSession().getAttribute(SecurityUtils.SESSION_USER);
        long id = Long.parseLong(params.get("dictionaryId"));
        String flag = params.get("flag") == null ? "0" : "1";
        jdbc.update("UPDATE t_sys_dictionary SET cn_name=?,en_name=?,flag=?,remark=?,update_time=NOW(),update_user_id=? WHERE id=?",
                params.get("cnName"), params.get("enName"), flag, params.get("description"), user.getId(), id);
        jdbc.update("DELETE FROM t_sys_dictionary_detail WHERE dictionary_id=?", String.valueOf(id));
        saveDetails(id, detailNames, detailValues, detailRemarks);
        return "redirect:/admin/pc/systemDictionary/systemDictionaryIndex";
    }

    @PostMapping("/systemDictionaryDelete")
    public String delete(@RequestParam(value = "dictionaryId", required = false) String ids,
                         @RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                         @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                         Model model) {
        if (ids != null) {
            for (String id : ids.split(",")) {
                String dictionaryId = id.trim();
                jdbc.update("DELETE FROM t_sys_dictionary_detail WHERE dictionary_id=?", dictionaryId);
                jdbc.update("DELETE FROM t_sys_dictionary WHERE id=?", dictionaryId);
            }
        }
        addPage(model, pageNow, pageSize, null, null);
        return "admin/jsp/systemDictionary/systemDictionaryList";
    }

    @GetMapping("/systemDictionaryAddCnNameAndEnNameValidate")
    @ResponseBody
    public boolean addValidate(@RequestParam("cnName") String cnName, @RequestParam("enName") String enName) {
        return DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_sys_dictionary WHERE cn_name=? OR en_name=?",
                cnName, enName) == 0;
    }

    @GetMapping("/systemDictionaryUpdateCnNameAndEnNameValidate")
    @ResponseBody
    public boolean updateValidate(@RequestParam("cnName") String cnName, @RequestParam("enName") String enName,
                                  @RequestParam("dictionaryId") long id) {
        return DbUtils.count(jdbc,
                "SELECT COUNT(*) FROM t_sys_dictionary WHERE (cn_name=? OR en_name=?) AND id<>?",
                cnName, enName, id) == 0;
    }
}
