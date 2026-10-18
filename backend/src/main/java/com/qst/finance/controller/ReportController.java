package com.qst.finance.controller;

import com.qst.finance.common.DbUtils;
import com.qst.finance.common.PageData;
import com.qst.finance.common.SecurityUtils;
import com.qst.finance.service.ExcelImportService;
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
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/report")
public class ReportController {
    private final JdbcTemplate jdbc;
    private final PageSupport pageSupport;
    private final MenuService menuService;
    private final ExcelImportService excelImportService;

    public ReportController(JdbcTemplate jdbc, PageSupport pageSupport, MenuService menuService,
                            ExcelImportService excelImportService) {
        this.jdbc = jdbc;
        this.pageSupport = pageSupport;
        this.menuService = menuService;
        this.excelImportService = excelImportService;
    }

    @GetMapping("/tBasiProfitIndex")
    public String profitIndex(Model model) {
        reportMenu(model, 220);
        breadcrumb(model, "财务数据管理", "利润表");
        return "admin/jsp/report/tBasiProfitIndex";
    }

    @GetMapping("/tBasiAssetsAndLiabilitiesIndex")
    public String assetsIndex(Model model) {
        reportMenu(model, 221);
        breadcrumb(model, "财务数据管理", "资产负债表");
        return "admin/jsp/report/tBasiAssetsAndLiabilitiesIndex";
    }

    @GetMapping("/tBasiCashFlowIndex")
    public String cashIndex(Model model) {
        reportMenu(model, 222);
        breadcrumb(model, "财务数据管理", "现金流量表");
        return "admin/jsp/report/tBasiCashFlowIndex";
    }

    @GetMapping("/tKmyeIndex")
    public String kmyeIndex(Model model) {
        reportMenu(model, 223);
        breadcrumb(model, "财务数据管理", "科目余额表");
        return "admin/jsp/report/tKmyeIndex";
    }

    @GetMapping("/tDetailIndex")
    public String detailIndex(Model model) {
        reportMenu(model, 223);
        breadcrumb(model, "财务数据管理", "科目明细");
        return "admin/jsp/report/tDetailIndex";
    }

    @GetMapping("/planTAgeAnalysisIndex")
    public String planAgeIndex(Model model) {
        reportMenu(model, 224);
        breadcrumb(model, "财务数据管理", "账龄分析");
        return "admin/jsp/report/planTAgeAnalysisIndex";
    }

    @GetMapping("/mustTAgeAnalysisIndex")
    public String mustAgeIndex(Model model) {
        reportMenu(model, 224);
        breadcrumb(model, "财务数据管理", "应付账款账龄分析");
        return "admin/jsp/report/mustTAgeAnalysisIndex";
    }

    @GetMapping("/otherTAgeAnalysisIndex")
    public String otherAgeIndex(Model model) {
        reportMenu(model, 224);
        breadcrumb(model, "财务数据管理", "其他应收应付账龄分析");
        return "admin/jsp/report/otherTAgeAnalysisIndex";
    }

    @GetMapping("/bulkImportIndex")
    public String bulkIndex(Model model) {
        reportMenu(model, 225);
        breadcrumb(model, "财务数据管理", "批量导入");
        return "admin/jsp/report/bulkImportIndex";
    }

    @GetMapping("/tReportResultIndex")
    public String resultIndex(Model model) {
        reportMenu(model, 312);
        breadcrumb(model, "编码与算法", "数据转换");
        return "admin/jsp/report/tReportResultIndex";
    }

    private void reportMenu(Model model, int menuId) {
        model.addAttribute("menuInitList", menuService.tree(true));
        model.addAttribute("fatherMenuId", menuId >= 300 ? 300 : 200);
        model.addAttribute("menuId", menuId);
        model.addAttribute("buttonList", menuService.buttons(menuId));
    }

    private void breadcrumb(Model model, String father, String parent) {
        Map<String, Object> map = new LinkedHashMap<String, Object>();
        map.put("fatherName", father);
        map.put("parentName", parent);
        model.addAttribute("map", map);
        model.addAttribute("parentId", 0);
    }

    @GetMapping("/tBasiProfitList")
    public String profitList(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                             @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                             @RequestParam(value = "orgId", required = false) String orgId,
                             @RequestParam(value = "kjyearMoth", required = false) String kjyearMoth,
                             Model model) {
        String where = periodWhere(orgId, kjyearMoth);
        List<Object> args = periodArgs(orgId, kjyearMoth);
        PageData<Map<String, Object>> page = pageSupport.page(
                "SELECT * FROM t_basi_profit" + where + " ORDER BY KJYEAR_MOTH DESC, IMP_TIME DESC",
                "SELECT COUNT(*) FROM t_basi_profit" + where, pageNow, pageSize, args.toArray());
        putPage(model, page);
        model.addAttribute("tBasiProfitList", page.getList());
        return "admin/jsp/report/tBasiProfitList";
    }

    @GetMapping("/tBasiAssetsAndLiabilitiesList")
    public String assetsList(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                             @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                             @RequestParam(value = "orgId", required = false) String orgId,
                             @RequestParam(value = "kjyearMoth", required = false) String kjyearMoth,
                             Model model) {
        String where = periodWhere(orgId, kjyearMoth);
        List<Object> args = periodArgs(orgId, kjyearMoth);
        PageData<Map<String, Object>> page = pageSupport.page(
                "SELECT * FROM t_basi_assets_and_liabilities" + where + " ORDER BY KJYEAR_MOTH DESC, IMP_TIME DESC",
                "SELECT COUNT(*) FROM t_basi_assets_and_liabilities" + where, pageNow, pageSize, args.toArray());
        putPage(model, page);
        model.addAttribute("tBasiAssetsAndLiabilitiesList", page.getList());
        return "admin/jsp/report/tBasiAssetsAndLiabilitiesList";
    }

    @GetMapping("/tBasiCashFlowList")
    public String cashList(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                           @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                           @RequestParam(value = "orgId", required = false) String orgId,
                           @RequestParam(value = "kjyearMoth", required = false) String kjyearMoth,
                           Model model) {
        String where = periodWhere(orgId, kjyearMoth);
        List<Object> args = periodArgs(orgId, kjyearMoth);
        PageData<Map<String, Object>> page = pageSupport.page(
                "SELECT * FROM t_basi_cash_flow" + where + " ORDER BY KJYEAR_MOTH DESC, IMP_TIME DESC",
                "SELECT COUNT(*) FROM t_basi_cash_flow" + where, pageNow, pageSize, args.toArray());
        putPage(model, page);
        model.addAttribute("tBasiCashFlowList", page.getList());
        return "admin/jsp/report/tBasiCashFlowList";
    }

    @GetMapping("/tKmyeList")
    public String kmyeList(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                           @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                           @RequestParam(value = "orgId", required = false) String orgId,
                           @RequestParam(value = "kjyearMoth", required = false) String kjyearMoth,
                           @RequestParam(value = "subjectCode", required = false) String subjectCode,
                           Model model) {
        StringBuilder where = new StringBuilder(periodWhere(orgId, kjyearMoth));
        List<Object> args = periodArgs(orgId, kjyearMoth);
        if (subjectCode != null && !subjectCode.trim().isEmpty()) {
            where.append(" AND SUBJECT_CODE LIKE ?");
            args.add("%" + subjectCode.trim() + "%");
        }
        PageData<Map<String, Object>> page = pageSupport.page(
                "SELECT * FROM t_kmye" + where + " ORDER BY KJYEAR_MOTH DESC, SUBJECT_CODE",
                "SELECT COUNT(*) FROM t_kmye" + where, pageNow, pageSize, args.toArray());
        putPage(model, page);
        model.addAttribute("tKmyeList", page.getList());
        return "admin/jsp/report/tKmyeList";
    }

    @GetMapping("/tDetailList")
    public String detailList(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                             @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                             @RequestParam(value = "orgId", required = false) String orgId,
                             @RequestParam(value = "kjyearMoth", required = false) String kjyearMoth,
                             Model model) {
        return kmyeList(pageNow, pageSize, orgId, kjyearMoth, null, model);
    }

    @GetMapping("/otherTAgeAnalysisList")
    public String ageList(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                          @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                          @RequestParam(value = "orgId", required = false) String orgId,
                          @RequestParam(value = "kjyearMoth", required = false) String kjyearMoth,
                          @RequestParam(value = "importType", required = false) String importType,
                          HttpServletRequest request,
                          Model model) {
        if (importType == null || importType.trim().isEmpty()) {
            importType = (String) request.getAttribute("importType");
        }
        StringBuilder where = new StringBuilder(periodWhere(orgId, kjyearMoth));
        List<Object> args = periodArgs(orgId, kjyearMoth);
        if (importType != null && !importType.trim().isEmpty()) {
            where.append(" AND `type` = ?");
            args.add(Integer.parseInt(importType));
        }
        PageData<Map<String, Object>> page = pageSupport.page(
                "SELECT * FROM t_age_analysis" + where + " ORDER BY KJYEAR_MOTH DESC, PROJECT_CODE",
                "SELECT COUNT(*) FROM t_age_analysis" + where, pageNow, pageSize, args.toArray());
        putPage(model, page);
        model.addAttribute("otherTAgeAnalysisList", page.getList());
        return "admin/jsp/report/otherTAgeAnalysisList";
    }

    private String periodWhere(String orgId, String yearMonth) {
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        if (orgId != null && !orgId.trim().isEmpty()) {
            where.append(" AND ORG_ID = ?");
        }
        if (yearMonth != null && !yearMonth.trim().isEmpty()) {
            where.append(" AND KJYEAR_MOTH LIKE ?");
        }
        return where.toString();
    }

    private List<Object> periodArgs(String orgId, String yearMonth) {
        List<Object> args = new ArrayList<Object>();
        if (orgId != null && !orgId.trim().isEmpty()) {
            args.add(orgId.trim());
        }
        if (yearMonth != null && !yearMonth.trim().isEmpty()) {
            args.add("%" + yearMonth.trim() + "%");
        }
        return args;
    }

    private void putPage(Model model, PageData<Map<String, Object>> page) {
        model.addAttribute("pageNow", page.getPageNow());
        model.addAttribute("pageSize", page.getPageSize());
        model.addAttribute("totalPage", page.getTotalPage());
        model.addAttribute("totalCount", (int) page.getTotal());
        model.addAttribute("curPage", page.getPageNow());
    }

    @PostMapping("/importTBasiProfit")
    @ResponseBody
    public int importProfit(@RequestParam("excelFile") MultipartFile file,
                            @RequestParam(value = "proSubject", defaultValue = "1") String subject,
                            HttpServletRequest request) {
        return importSingle(file, subject, null, request);
    }

    @PostMapping("/importTBasiAssetsAndLiabilities")
    @ResponseBody
    public int importAssets(@RequestParam("excelFile") MultipartFile file,
                            @RequestParam(value = "proSubject", defaultValue = "2") String subject,
                            HttpServletRequest request) {
        return importSingle(file, subject, null, request);
    }

    @PostMapping("/importTBasiCashFlow")
    @ResponseBody
    public int importCash(@RequestParam("excelFile") MultipartFile file,
                          @RequestParam(value = "proSubject", defaultValue = "5") String subject,
                          HttpServletRequest request) {
        return importSingle(file, subject, null, request);
    }

    @PostMapping("/importTKmye")
    @ResponseBody
    public int importKmye(@RequestParam("excelFile") MultipartFile file,
                          @RequestParam(value = "proSubject", defaultValue = "3") String subject,
                          HttpServletRequest request) {
        return importSingle(file, subject, null, request);
    }

    @PostMapping("/importTDetail")
    @ResponseBody
    public int importDetail(@RequestParam("excelFile") MultipartFile file,
                            @RequestParam(value = "proSubject", defaultValue = "3") String subject,
                            HttpServletRequest request) {
        return importSingle(file, subject, null, request);
    }

    private int importSingle(MultipartFile file, String subject, String type, HttpServletRequest request) {
        if (file == null || file.isEmpty()) {
            return 0;
        }
        String orgId = resolveOrgId(request);
        if (orgId == null) {
            return -1;
        }
        LoginUser user = (LoginUser) request.getSession().getAttribute(SecurityUtils.SESSION_USER);
        try (InputStream inputStream = file.getInputStream()) {
            ExcelImportService.ImportResult result = excelImportService.importExcel(inputStream,
                    file.getOriginalFilename(), subject, type, orgId, user == null ? "system" : user.getAccountName());
            return result.isSuccess() ? 1 : 0;
        } catch (Exception ex) {
            return 0;
        }
    }

    private String resolveOrgId(HttpServletRequest request) {
        LoginUser user = (LoginUser) request.getSession().getAttribute(SecurityUtils.SESSION_USER);
        if (user != null && user.getOrgId() != null) {
            return String.valueOf(user.getOrgId());
        }
        List<Map<String, Object>> orgs = jdbc.queryForList("SELECT id FROM t_org_info ORDER BY id LIMIT 1");
        return orgs.isEmpty() ? null : String.valueOf(orgs.get(0).get("id"));
    }

    @PostMapping("/importTBasiProfitBulk")
    @ResponseBody
    public Map<String, Object> importProfitBulk(@RequestParam("excelFile") MultipartFile file,
                                                @RequestParam(value = "proSubject", defaultValue = "1") String subject,
                                                HttpServletRequest request) {
        return importBulk(file, subject, null, request);
    }

    @PostMapping("/importTBasiAssetsAndLiabilitiesBulk")
    @ResponseBody
    public Map<String, Object> importAssetsBulk(@RequestParam("excelFile") MultipartFile file,
                                                @RequestParam(value = "proSubject", defaultValue = "2") String subject,
                                                HttpServletRequest request) {
        return importBulk(file, subject, null, request);
    }

    @PostMapping("/importTBasiCashFlowBulk")
    @ResponseBody
    public Map<String, Object> importCashBulk(@RequestParam("excelFile") MultipartFile file,
                                              @RequestParam(value = "proSubject", defaultValue = "5") String subject,
                                              HttpServletRequest request) {
        return importBulk(file, subject, null, request);
    }

    @PostMapping("/importTKmyeBulk")
    @ResponseBody
    public Map<String, Object> importKmyeBulk(@RequestParam("excelFile") MultipartFile file,
                                              @RequestParam(value = "proSubject", defaultValue = "3") String subject,
                                              HttpServletRequest request) {
        return importBulk(file, subject, null, request);
    }

    @PostMapping("/importTAgeAnalysisBulk")
    @ResponseBody
    public Map<String, Object> importAgeBulk(@RequestParam("excelFile") MultipartFile file,
                                             @RequestParam(value = "proSubject", defaultValue = "22") String subject,
                                             @RequestParam(value = "type", required = false) String type,
                                             HttpServletRequest request) {
        return importBulk(file, subject, type, request);
    }

    private Map<String, Object> importBulk(MultipartFile file, String subject, String type,
                                           HttpServletRequest request) {
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        String orgId = resolveOrgId(request);
        if (orgId == null) {
            result.put("flag", "-1");
            return result;
        }
        LoginUser user = (LoginUser) request.getSession().getAttribute(SecurityUtils.SESSION_USER);
        try (InputStream inputStream = file.getInputStream()) {
            ExcelImportService.ImportResult importResult = excelImportService.importExcel(inputStream,
                    file.getOriginalFilename(), subject, type, orgId, user == null ? "system" : user.getAccountName());
            result.put("flag", importResult.isSuccess() ? file.getOriginalFilename() : importResult.getMessage());
            result.put("count", importResult.getCount());
        } catch (Exception ex) {
            result.put("flag", "数据不正确: " + ex.getMessage());
        }
        return result;
    }

    @GetMapping("/bulkList")
    public String bulkList(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                           @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                           @RequestParam(value = "name", required = false) String name,
                           Model model) {
        String[] tables = {"t_basi_profit", "t_basi_assets_and_liabilities", "t_basi_cash_flow", "t_kmye"};
        Map<String, Map<String, Object>> merged = new LinkedHashMap<String, Map<String, Object>>();
        for (String table : tables) {
            List<Map<String, Object>> rows = DbUtils.camelRows(jdbc.queryForList(
                    "SELECT BATCH_ID AS name, MAX(IMP_TIME) AS imp_time FROM " + table
                            + " WHERE BATCH_ID IS NOT NULL GROUP BY BATCH_ID"));
            for (Map<String, Object> row : rows) {
                String batch = DbUtils.str(row, "name");
                if (name != null && !name.trim().isEmpty()
                        && (batch == null || !batch.contains(name.trim()))) {
                    continue;
                }
                Map<String, Object> item = merged.get(batch);
                if (item == null) {
                    item = new LinkedHashMap<String, Object>();
                    item.put("id", batch);
                    item.put("name", batch);
                    item.put("impTime", row.get("impTime"));
                    merged.put(batch, item);
                }
            }
        }
        List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>(merged.values());
        rows.sort(new java.util.Comparator<Map<String, Object>>() {
            @Override
            public int compare(Map<String, Object> a, Map<String, Object> b) {
                return String.valueOf(b.get("impTime")).compareTo(String.valueOf(a.get("impTime")));
            }
        });
        int total = rows.size();
        int from = Math.min((Math.max(1, pageNow) - 1) * pageSize, total);
        int to = Math.min(from + pageSize, total);
        model.addAttribute("bulkList", rows.subList(from, to));
        model.addAttribute("pageNow", Math.max(1, pageNow));
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("totalPage", (int) Math.ceil((double) total / pageSize));
        model.addAttribute("totalCount", total);
        model.addAttribute("curPage", Math.max(1, pageNow));
        return "admin/jsp/report/bulkImportList";
    }

    @GetMapping("/result/list")
    public String resultList(@RequestParam(value = "pageNow", defaultValue = "1") int pageNow,
                             @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
                             Model model) {
        PageData<Map<String, Object>> page = pageSupport.page(
                "SELECT r.*, c.CODE_NAME FROM t_report_result r LEFT JOIN t_code_libr c ON c.CODE_NO=r.CODE_NO "
                        + "ORDER BY r.RYEAR_AND_MONTH DESC, r.CODE_NO",
                "SELECT COUNT(*) FROM t_report_result", pageNow, pageSize);
        putPage(model, page);
        model.addAttribute("tReportResultList", page.getList());
        return "admin/jsp/report/tReportResultList";
    }

    @GetMapping("/result/buttonList")
    public String resultButtons(Model model) {
        model.addAttribute("buttonList", menuService.buttons(312));
        return "admin/jsp/report/tReportResultListAndButtonList";
    }
}
