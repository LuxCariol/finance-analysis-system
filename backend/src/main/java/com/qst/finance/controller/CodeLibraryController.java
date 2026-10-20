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
@RequestMapping("/codeLibr")
public class CodeLibraryController {
    private final JdbcTemplate jdbc;
    private final PageSupport pageSupport;
    private final MenuService menuService;

    public CodeLibraryController(JdbcTemplate jdbc, PageSupport pageSupport, MenuService menuService) {
        this.jdbc = jdbc;
        this.pageSupport = pageSupport;
        this.menuService = menuService;
    }

    @GetMapping("/codeLibrIndex")
    public String index(Model model) {
        menu(model, 310);
        return "admin/jsp/codeLibr/codeLibrIndex";
    }

    @GetMapping("/codeMapperIndex")
    public String mapperIndex(Model model) {
        menu(model, 311);
        return "admin/jsp/codeLibr/codeMapperIndex";
    }

    private void menu(Model model, int menuId) {
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", 300);
        model.addAttribute("menuId", menuId);
        model.addAttribute("buttonList", menuService.buttons(menuId));
    }

    @GetMapping("/codeLibrListAndButtonList")
    public String listAndButtons(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                                 @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                                 Model model) {
        menu(model, 310);
        addPage(model, pageNow, pageSize, null, null, null);
        return "admin/jsp/codeLibr/codeLibrListAndButtonList";
    }

    private void addPage(Model model, int pageNow, int pageSize, String name, String code, String reportType) {
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> args = new ArrayList<Object>();
        if (name != null && !name.trim().isEmpty()) {
            where.append(" AND CODE_NAME LIKE ?");
            args.add("%" + name.trim() + "%");
        }
        if (code != null && !code.trim().isEmpty()) {
            where.append(" AND CODE_NO LIKE ?");
            args.add("%" + code.trim() + "%");
        }
        if (reportType != null && !reportType.trim().isEmpty()) {
            where.append(" AND REPORT_TYPE = ?");
            args.add(reportType.trim());
        }
        PageData<Map<String, Object>> page = pageSupport.page(
                "SELECT * FROM t_code_libr" + where + " ORDER BY ID",
                "SELECT COUNT(*) FROM t_code_libr" + where, pageNow, pageSize, args.toArray());
        model.addAttribute("codeLibrList", page.getList());
        model.addAttribute("pageNow", page.getPageNow());
        model.addAttribute("pageSize", page.getPageSize());
        model.addAttribute("totalPage", page.getTotalPage());
        model.addAttribute("totalCount", (int) page.getTotal());
        model.addAttribute("curPage", page.getPageNow());
    }

    @GetMapping("/codeLibrList")
    public String list(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                       @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                       @RequestParam(value = "code_name", required = false) String name,
                       @RequestParam(value = "code_no", required = false) String code,
                       @RequestParam(value = "use_area", required = false) String reportType,
                       Model model) {
        addPage(model, pageNow, pageSize, name, code, reportType);
        return "admin/jsp/codeLibr/codeLibrList";
    }

    @GetMapping("/addCodeLibr")
    public String addPage(@RequestParam(value = "pages", required = false) String pages, Model model) {
        model.addAttribute("pages", pages);
        return "admin/jsp/codeLibr/codeLibrAddPage";
    }

    @PostMapping("/codeLibrSave")
    public String save(@RequestParam Map<String, String> params) {
        Long id = parseLong(params.get("id"));
        if (id == null) {
            id = jdbc.queryForObject("SELECT IFNULL(MAX(ID),10000)+1 FROM t_code_libr", Long.class);
        }
        jdbc.update("INSERT INTO t_code_libr(ID,CODE_NAME,CODE_NO,REPORT_TYPE,use_area,use_area_remark,data_type,"
                        + "data_type_desc,is_current,is_details,survey,warn,parent_id,clzz,BASI_FIELD,km1,km2,km3,remark) "
                        + "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                id, params.get("codeName"), params.get("codeNo"), params.get("reportType"),
                params.get("useArea"), params.get("useAreaRemark"), params.get("dataType"),
                params.get("dataTypeDesc"), params.get("isCurrent"), params.get("isDetails"), params.get("survey"),
                params.get("warn"), params.get("parentId"), params.get("clzz"), params.get("basiField"),
                params.get("km1"), params.get("km2"), params.get("km3"), params.get("remark"));
        return "redirect:/codeLibr/codeLibrIndex";
    }

    @GetMapping("/codeLibrEditPage")
    public String editPage(@RequestParam("codeLibrId") long codeLibrId,
                           @RequestParam(value = "pages", required = false) String pages, Model model) {
        model.addAttribute("codeLibr", DbUtils.queryOne(jdbc, "SELECT * FROM t_code_libr WHERE ID=?", codeLibrId));
        model.addAttribute("pages", pages);
        return "admin/jsp/codeLibr/codeLibrEditPage";
    }

    @PostMapping("/codeLibrUpdateSave")
    public String update(@RequestParam Map<String, String> params) {
        long id = Long.parseLong(params.get("id"));
        jdbc.update("UPDATE t_code_libr SET CODE_NAME=?,CODE_NO=?,REPORT_TYPE=?,use_area=?,use_area_remark=?,"
                        + "data_type=?,data_type_desc=?,is_current=?,is_details=?,survey=?,warn=?,parent_id=?,clzz=?,"
                        + "BASI_FIELD=?,km1=?,km2=?,km3=?,remark=? WHERE ID=?",
                params.get("codeName"), params.get("codeNo"), params.get("reportType"), params.get("useArea"),
                params.get("useAreaRemark"), params.get("dataType"), params.get("dataTypeDesc"), params.get("isCurrent"),
                params.get("isDetails"), params.get("survey"), params.get("warn"), params.get("parentId"),
                params.get("clzz"), params.get("basiField"), params.get("km1"), params.get("km2"), params.get("km3"),
                params.get("remark"), id);
        return "redirect:/codeLibr/codeLibrIndex";
    }

    @PostMapping("/codeLibrDelete")
    public String delete(@RequestParam(value = "codeLibrId", required = false) String ids,
                         @RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                         @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                         Model model) {
        if (ids != null) {
            for (String id : ids.split(",")) {
                jdbc.update("DELETE FROM t_code_mapper WHERE CODE_NO=(SELECT CODE_NO FROM t_code_libr WHERE ID=?)",
                        id.trim());
                jdbc.update("DELETE FROM t_code_libr WHERE ID=?", id.trim());
            }
        }
        addPage(model, pageNow, pageSize, null, null, null);
        return "admin/jsp/codeLibr/codeLibrList";
    }

    @PostMapping("/updateCodeLibr")
    public String updateCodeLibr() {
        jdbc.update("UPDATE t_code_libr c JOIN t_code_mapper m ON c.CODE_NO=m.CODE_NO SET c.BASI_FIELD=m.BASI_FIELD");
        return "redirect:/codeLibr/codeLibrIndex";
    }

    @GetMapping("/codeMapperListAndButtonList")
    public String mapperListAndButtons(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                                       @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                                       Model model) {
        menu(model, 311);
        addMapperPage(model, pageNow, pageSize, null, null);
        return "admin/jsp/codeLibr/codeMapperListAndButtonList";
    }

    private void addMapperPage(Model model, int pageNow, int pageSize, String name, String code) {
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> args = new ArrayList<Object>();
        if (name != null && !name.trim().isEmpty()) {
            where.append(" AND c.CODE_NAME LIKE ?");
            args.add("%" + name.trim() + "%");
        }
        if (code != null && !code.trim().isEmpty()) {
            where.append(" AND m.CODE_NO LIKE ?");
            args.add("%" + code.trim() + "%");
        }
        PageData<Map<String, Object>> page = pageSupport.page(
                "SELECT m.BASI_FIELD,m.CODE_NO,c.CODE_NAME FROM t_code_mapper m "
                        + "LEFT JOIN t_code_libr c ON c.CODE_NO=m.CODE_NO" + where + " ORDER BY m.CODE_NO",
                "SELECT COUNT(*) FROM t_code_mapper m LEFT JOIN t_code_libr c ON c.CODE_NO=m.CODE_NO" + where,
                pageNow, pageSize, args.toArray());
        model.addAttribute("codeMapperList", page.getList());
        model.addAttribute("pageNow", page.getPageNow());
        model.addAttribute("pageSize", page.getPageSize());
        model.addAttribute("totalPage", page.getTotalPage());
        model.addAttribute("totalCount", (int) page.getTotal());
        model.addAttribute("curPage", page.getPageNow());
    }

    @GetMapping("/codeMapperList")
    public String mapperList(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                             @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                             @RequestParam(value = "codeName", required = false) String name,
                             @RequestParam(value = "codeNo", required = false) String code,
                             Model model) {
        addMapperPage(model, pageNow, pageSize, name, code);
        return "admin/jsp/codeLibr/codeMapperList";
    }

    @GetMapping("/addCodeMapper")
    public String addMapper(Model model) {
        model.addAttribute("codeNoList", DbUtils.query(jdbc, "SELECT CODE_NO FROM t_code_libr ORDER BY CODE_NO"));
        return "admin/jsp/codeLibr/codeMapperAddPage";
    }

    @PostMapping("/codeMapperSave")
    public String saveMapper(@RequestParam Map<String, String> params) {
        jdbc.update("INSERT INTO t_code_mapper(BASI_FIELD,CODE_NO,FBACK) VALUES(?,?,NULL)",
                params.get("basiField"), params.get("codeNo"));
        return "redirect:/codeLibr/codeMapperIndex";
    }

    @GetMapping("/codeMapperEditPage")
    public String editMapper(@RequestParam("codeNo") String codeNo, Model model) {
        model.addAttribute("tCodeMapperBean", DbUtils.queryOne(jdbc,
                "SELECT BASI_FIELD,CODE_NO FROM t_code_mapper WHERE CODE_NO=? LIMIT 1", codeNo));
        return "admin/jsp/codeLibr/codeMapperEditPage";
    }

    @PostMapping("/codeMapperUpdateSave")
    public String updateMapper(@RequestParam Map<String, String> params) {
        jdbc.update("UPDATE t_code_mapper SET BASI_FIELD=? WHERE CODE_NO=?",
                params.get("basiField"), params.get("codeNo"));
        return "redirect:/codeLibr/codeMapperIndex";
    }

    @PostMapping("/codeMapperDelete")
    public String deleteMapper(@RequestParam(value = "codeNo", required = false) String codes,
                               @RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                               @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                               Model model) {
        if (codes != null) {
            for (String code : codes.split(",")) {
                jdbc.update("DELETE FROM t_code_mapper WHERE CODE_NO=?", code.trim());
            }
        }
        addMapperPage(model, pageNow, pageSize, null, null);
        return "admin/jsp/codeLibr/codeMapperList";
    }

    private Long parseLong(String value) {
        try {
            return value == null || value.trim().isEmpty() ? null : Long.valueOf(value.trim());
        } catch (NumberFormatException ex) {
            return null;
        }
    }
}
