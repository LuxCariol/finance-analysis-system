package com.qst.finance.controller;

import com.qst.finance.common.ApiResult;
import com.qst.finance.common.DbUtils;
import com.qst.finance.common.SecurityUtils;
import com.qst.finance.service.AnalyticsService;
import com.qst.finance.service.ApiSupport;
import com.qst.finance.service.ExcelImportService;
import com.qst.finance.service.LoginUser;
import com.qst.finance.service.ReportConversionService;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
public class WebAdminApiController {
    private final JdbcTemplate jdbc;
    private final ApiSupport apiSupport;
    private final AnalyticsService analytics;
    private final ExcelImportService importService;
    private final ReportConversionService conversionService;

    public WebAdminApiController(JdbcTemplate jdbc, ApiSupport apiSupport, AnalyticsService analytics,
                                 ExcelImportService importService, ReportConversionService conversionService) {
        this.jdbc = jdbc;
        this.apiSupport = apiSupport;
        this.analytics = analytics;
        this.importService = importService;
        this.conversionService = conversionService;
    }

    @GetMapping("/dashboard")
    public ApiResult dashboard(HttpServletRequest request,
                               @RequestParam(value = "orgId", required = false) String orgId) {
        LoginUser user = apiSupport.require(request);
        orgId = org(orgId, user);
        String period = analytics.latestPeriod(orgId);
        Map<String, Object> overview = analytics.overview(orgId, period);
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("overview", overview);
        data.put("period", period);
        data.put("profitChart", analytics.profitChart(orgId));
        data.put("cashChart", analytics.cashChart(orgId));
        data.put("counts", counts());
        data.put("companies", companyList(""));
        data.put("news", analytics.news(5));
        return ApiResult.ok(data);
    }

    private Map<String, Object> counts() {
        Map<String, Object> counts = new LinkedHashMap<String, Object>();
        counts.put("companies", DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_org_info"));
        counts.put("users", DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_sys_user"));
        counts.put("reports", DbUtils.count(jdbc,
                "SELECT (SELECT COUNT(*) FROM t_basi_profit)+(SELECT COUNT(*) FROM t_basi_assets_and_liabilities)"
                        + "+(SELECT COUNT(*) FROM t_basi_cash_flow)+(SELECT COUNT(*) FROM t_kmye)"));
        counts.put("results", DbUtils.count(jdbc, "SELECT COUNT(*) FROM t_report_result"));
        return counts;
    }

    @GetMapping("/companies")
    public ApiResult companies(@RequestParam(value = "keyword", defaultValue = "") String keyword,
                               HttpServletRequest request) {
        if (request != null) {
            apiSupport.require(request);
        }
        return ApiResult.ok(companyList(keyword));
    }

    private List<Map<String, Object>> companyList(String keyword) {
        String where = keyword == null || keyword.isEmpty() ? "" : " WHERE ORG_NAME LIKE ? OR SHORT_NAME LIKE ?";
        Object[] args = keyword == null || keyword.isEmpty() ? new Object[]{} : new Object[]{"%" + keyword + "%", "%" + keyword + "%"};
        return DbUtils.query(jdbc, "SELECT * FROM t_org_info" + where + " ORDER BY id", args);
    }

    @PostMapping("/companies")
    public ApiResult createCompany(@RequestBody Map<String, Object> body, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("INSERT INTO t_org_info(ORG_NAME,SHORT_NAME,ORG_REMARK,BUSINESS_NUM,LEGALER_NAME,PAID_CAPITAL,"
                        + "CONFUSING_CAPITAL,REGISTERED_ADDR,INDUSTRY,IS_LIST,ORG_PROPERTY,RES_PERSON_NAME,ORG_TOTAL_PER,"
                        + "RES_PERSON_TEL,ORG_ADDR,REPORT_LIMIT,parent_id) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                text(body, "orgName"), text(body, "shortName"), text(body, "orgRemark"), text(body, "businessNum"),
                text(body, "legalerName"), text(body, "paidCapital"), text(body, "confusingCapital"),
                text(body, "registeredAddr"), text(body, "industry"), text(body, "isList"), text(body, "orgProperty"),
                text(body, "resPersonName"), longValue(body, "orgTotalPer"), text(body, "resPersonTel"),
                text(body, "orgAddr"), text(body, "reportLimit"), longValue(body, "parentId"));
        return ApiResult.ok("公司创建成功", null);
    }

    @PutMapping("/companies/{id}")
    public ApiResult updateCompany(@PathVariable long id, @RequestBody Map<String, Object> body,
                                   HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("UPDATE t_org_info SET ORG_NAME=?,SHORT_NAME=?,ORG_REMARK=?,BUSINESS_NUM=?,LEGALER_NAME=?,"
                        + "PAID_CAPITAL=?,CONFUSING_CAPITAL=?,REGISTERED_ADDR=?,INDUSTRY=?,IS_LIST=?,ORG_PROPERTY=?,"
                        + "RES_PERSON_NAME=?,ORG_TOTAL_PER=?,RES_PERSON_TEL=?,ORG_ADDR=?,REPORT_LIMIT=?,parent_id=? WHERE id=?",
                text(body, "orgName"), text(body, "shortName"), text(body, "orgRemark"), text(body, "businessNum"),
                text(body, "legalerName"), text(body, "paidCapital"), text(body, "confusingCapital"),
                text(body, "registeredAddr"), text(body, "industry"), text(body, "isList"),
                text(body, "orgProperty"), text(body, "resPersonName"), longValue(body, "orgTotalPer"),
                text(body, "resPersonTel"), text(body, "orgAddr"), text(body, "reportLimit"),
                longValue(body, "parentId"), id);
        return ApiResult.ok("公司更新成功", null);
    }

    @DeleteMapping("/companies/{id}")
    public ApiResult deleteCompany(@PathVariable long id, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("DELETE FROM t_org_info WHERE id=?", id);
        return ApiResult.ok("公司已删除", null);
    }

    @GetMapping("/users")
    public ApiResult users(HttpServletRequest request) {
        apiSupport.require(request);
        return ApiResult.ok(DbUtils.query(jdbc,
                "SELECT u.id,u.user_name AS userName,u.account_name AS accountName,u.locked,u.description,"
                        + "u.org_id AS orgId,u.create_time AS createTime,GROUP_CONCAT(r.name) AS roleName "
                        + "FROM t_sys_user u LEFT JOIN t_sys_user_role ur ON ur.user_id=u.id "
                        + "LEFT JOIN t_sys_role r ON r.id=ur.role_id GROUP BY u.id ORDER BY u.id"));
    }

    @PostMapping("/users")
    public ApiResult createUser(@RequestBody Map<String, Object> body, HttpServletRequest request) {
        LoginUser current = apiSupport.require(request);
        Number id = jdbc.queryForObject("SELECT IFNULL(MAX(id),0)+1 FROM t_sys_user", Number.class);
        jdbc.update("INSERT INTO t_sys_user(user_name,account_name,pwd,locked,account_type,create_user_id,description,"
                        + "create_time,account_port_type,type,org_id) VALUES(?,?,?,?,1,?,?,NOW(),4,0,?)",
                text(body, "userName"), text(body, "accountName"), SecurityUtils.md5(text(body, "pwd")),
                intValue(body, "locked"), current.getId(), text(body, "description"), longValue(body, "orgId"));
        Long roleId = longValue(body, "roleId");
        if (roleId != null) {
            jdbc.update("INSERT INTO t_sys_user_role(user_id,role_id) VALUES(?,?)", id.longValue(), roleId);
        }
        return ApiResult.ok("用户创建成功", null);
    }

    @PutMapping("/users/{id}")
    public ApiResult updateUser(@PathVariable long id, @RequestBody Map<String, Object> body,
                                HttpServletRequest request) {
        apiSupport.require(request);
        String pwd = text(body, "pwd");
        if (pwd != null && !pwd.isEmpty()) {
            jdbc.update("UPDATE t_sys_user SET user_name=?,account_name=?,pwd=?,locked=?,description=?,org_id=? WHERE id=?",
                    text(body, "userName"), text(body, "accountName"), SecurityUtils.md5(pwd),
                    intValue(body, "locked"), text(body, "description"), longValue(body, "orgId"), id);
        } else {
            jdbc.update("UPDATE t_sys_user SET user_name=?,account_name=?,locked=?,description=?,org_id=? WHERE id=?",
                    text(body, "userName"), text(body, "accountName"), intValue(body, "locked"),
                    text(body, "description"), longValue(body, "orgId"), id);
        }
        Long roleId = longValue(body, "roleId");
        if (roleId != null) {
            jdbc.update("DELETE FROM t_sys_user_role WHERE user_id=?", id);
            jdbc.update("INSERT INTO t_sys_user_role(user_id,role_id) VALUES(?,?)", id, roleId);
        }
        return ApiResult.ok("用户更新成功", null);
    }

    @DeleteMapping("/users/{id}")
    public ApiResult deleteUser(@PathVariable long id, HttpServletRequest request) {
        LoginUser current = apiSupport.require(request);
        if (current.getId() == id) {
            return ApiResult.fail("不能删除当前登录用户");
        }
        jdbc.update("DELETE FROM t_sys_user_role WHERE user_id=?", id);
        jdbc.update("DELETE FROM t_sys_user_action WHERE user_id=?", id);
        jdbc.update("DELETE FROM t_sys_user WHERE id=?", id);
        return ApiResult.ok("用户已删除", null);
    }

    @PostMapping("/users/{id}/reset-password")
    public ApiResult resetPassword(@PathVariable long id, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("UPDATE t_sys_user SET pwd=? WHERE id=?", SecurityUtils.md5("123456"), id);
        return ApiResult.ok("密码已重置为 123456", null);
    }

    @GetMapping("/roles")
    public ApiResult roles(HttpServletRequest request) {
        apiSupport.require(request);
        return ApiResult.ok(DbUtils.query(jdbc,
                "SELECT r.id,r.name,r.description,r.create_time AS createTime,u.user_name AS userName "
                        + "FROM t_sys_role r LEFT JOIN t_sys_user u ON u.id=r.user_id ORDER BY r.id"));
    }

    @PostMapping("/roles")
    public ApiResult createRole(@RequestBody Map<String, Object> body, HttpServletRequest request) {
        LoginUser user = apiSupport.require(request);
        jdbc.update("INSERT INTO t_sys_role(name,user_id,description,create_time) VALUES(?,?,?,NOW())",
                text(body, "name"), user.getId(), text(body, "description"));
        return ApiResult.ok("角色创建成功", null);
    }

    @PutMapping("/roles/{id}")
    public ApiResult updateRole(@PathVariable long id, @RequestBody Map<String, Object> body,
                                HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("UPDATE t_sys_role SET name=?,description=? WHERE id=?",
                text(body, "name"), text(body, "description"), id);
        return ApiResult.ok("角色更新成功", null);
    }

    @DeleteMapping("/roles/{id}")
    public ApiResult deleteRole(@PathVariable long id, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("DELETE FROM t_sys_role_action WHERE role_id=?", id);
        jdbc.update("DELETE FROM t_sys_user_role WHERE role_id=?", id);
        jdbc.update("DELETE FROM t_sys_role WHERE id=?", id);
        return ApiResult.ok("角色已删除", null);
    }

    @GetMapping("/menus")
    public ApiResult menus(HttpServletRequest request) {
        apiSupport.require(request);
        return ApiResult.ok(DbUtils.query(jdbc,
                "SELECT id,name,parent_id AS parentId,res_key AS resKey,type,res_url AS resUrl,"
                        + "order_no AS orderNo,icon,btn,description FROM t_sys_resources ORDER BY order_no,id"));
    }

    @PostMapping("/menus")
    public ApiResult createMenu(@RequestBody Map<String, Object> body, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("INSERT INTO t_sys_resources(name,parent_id,res_key,type,res_url,order_no,icon,btn,is_hide,description) "
                        + "VALUES(?,?,?,?,?,?,?,?,0,?)",
                text(body, "name"), intValue(body, "parentId"), text(body, "resKey"), text(body, "type"),
                text(body, "resUrl"), intValue(body, "orderNo"), text(body, "icon"), text(body, "btn"),
                text(body, "description"));
        return ApiResult.ok("菜单创建成功", null);
    }

    @PutMapping("/menus/{id}")
    public ApiResult updateMenu(@PathVariable long id, @RequestBody Map<String, Object> body,
                                HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("UPDATE t_sys_resources SET name=?,parent_id=?,res_key=?,type=?,res_url=?,order_no=?,icon=?,btn=?,description=? WHERE id=?",
                text(body, "name"), intValue(body, "parentId"), text(body, "resKey"), text(body, "type"),
                text(body, "resUrl"), intValue(body, "orderNo"), text(body, "icon"), text(body, "btn"),
                text(body, "description"), id);
        return ApiResult.ok("菜单更新成功", null);
    }

    @DeleteMapping("/menus/{id}")
    public ApiResult deleteMenu(@PathVariable long id, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("DELETE FROM t_sys_role_action WHERE res_id=?", id);
        jdbc.update("DELETE FROM t_sys_user_action WHERE res_id=?", id);
        jdbc.update("DELETE FROM t_sys_resources WHERE id=?", id);
        return ApiResult.ok("菜单已删除", null);
    }

    @GetMapping("/dictionaries")
    public ApiResult dictionaries(@RequestParam(value = "keyword", defaultValue = "") String keyword,
                                  HttpServletRequest request) {
        apiSupport.require(request);
        String where = keyword == null || keyword.isEmpty() ? "" : " WHERE cn_name LIKE ? OR en_name LIKE ?";
        Object[] args = keyword == null || keyword.isEmpty() ? new Object[]{} : new Object[]{"%" + keyword + "%", "%" + keyword + "%"};
        return ApiResult.ok(DbUtils.query(jdbc,
                "SELECT id,cn_name AS cnName,en_name AS enName,flag,remark,create_time AS createTime,update_time AS updateTime "
                        + "FROM t_sys_dictionary" + where + " ORDER BY id DESC", args));
    }

    @PostMapping("/dictionaries")
    public ApiResult createDictionary(@RequestBody Map<String, Object> body, HttpServletRequest request) {
        LoginUser user = apiSupport.require(request);
        jdbc.update("INSERT INTO t_sys_dictionary(cn_name,en_name,flag,remark,create_time,create_user_id,update_time,update_user_id) "
                        + "VALUES(?,?,?,?,NOW(),?,NOW(),?)",
                text(body, "cnName"), text(body, "enName"), text(body, "flag"), text(body, "remark"),
                user.getId(), user.getId());
        return ApiResult.ok("字典创建成功", null);
    }

    @PutMapping("/dictionaries/{id}")
    public ApiResult updateDictionary(@PathVariable long id, @RequestBody Map<String, Object> body,
                                      HttpServletRequest request) {
        LoginUser user = apiSupport.require(request);
        jdbc.update("UPDATE t_sys_dictionary SET cn_name=?,en_name=?,flag=?,remark=?,update_time=NOW(),update_user_id=? WHERE id=?",
                text(body, "cnName"), text(body, "enName"), text(body, "flag"), text(body, "remark"), user.getId(), id);
        return ApiResult.ok("字典更新成功", null);
    }

    @DeleteMapping("/dictionaries/{id}")
    public ApiResult deleteDictionary(@PathVariable long id, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("DELETE FROM t_sys_dictionary_detail WHERE dictionary_id=?", String.valueOf(id));
        jdbc.update("DELETE FROM t_sys_dictionary WHERE id=?", id);
        return ApiResult.ok("字典已删除", null);
    }

    @GetMapping("/report-periods")
    public ApiResult periods(@RequestParam(value = "orgId", required = false) String orgId,
                             HttpServletRequest request) {
        apiSupport.require(request);
        String resolved = org(orgId, null);
        List<Map<String, Object>> rows = DbUtils.query(jdbc,
                "SELECT DISTINCT KJYEAR_MOTH AS period FROM t_basi_profit WHERE ORG_ID=? "
                        + "UNION SELECT DISTINCT KJYEAR_MOTH FROM t_basi_assets_and_liabilities WHERE ORG_ID=? "
                        + "UNION SELECT DISTINCT KJYEAR_MOTH FROM t_basi_cash_flow WHERE ORG_ID=? "
                        + "ORDER BY period DESC", resolved, resolved, resolved);
        return ApiResult.ok(rows);
    }

    @GetMapping("/reports")
    public ApiResult reports(@RequestParam(value = "type", defaultValue = "profit") String type,
                             @RequestParam(value = "orgId", required = false) String orgId,
                             @RequestParam(value = "period", defaultValue = "") String period,
                             @RequestParam(value = "keyword", defaultValue = "") String keyword,
                             @RequestParam(value = "page", defaultValue = "1") int page,
                             @RequestParam(value = "size", defaultValue = "10") int size,
                             HttpServletRequest request) {
        apiSupport.require(request);
        String table = reportTable(type);
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> args = new ArrayList<Object>();
        String resolvedOrg = org(orgId, null);
        where.append(" AND ORG_ID=?");
        args.add(resolvedOrg);
        if (period != null && !period.isEmpty()) {
            where.append(" AND KJYEAR_MOTH=?");
            args.add(period);
        }
        if ("kmye".equals(type) && keyword != null && !keyword.isEmpty()) {
            where.append(" AND (SUBJECT_CODE LIKE ? OR SUBJECT_NAME LIKE ?)");
            args.add("%" + keyword + "%");
            args.add("%" + keyword + "%");
        }
        int safeSize = Math.min(Math.max(size, 1), 100);
        int safePage = Math.max(page, 1);
        long total = DbUtils.count(jdbc, "SELECT COUNT(*) FROM " + table + where, args.toArray());
        List<Object> pageArgs = new ArrayList<Object>(args);
        pageArgs.add((safePage - 1) * safeSize);
        pageArgs.add(safeSize);
        List<Map<String, Object>> rows = DbUtils.query(jdbc,
                "SELECT * FROM " + table + where + " ORDER BY KJYEAR_MOTH DESC, IMP_TIME DESC LIMIT ?,?",
                pageArgs.toArray());
        return ApiResult.ok(ApiResult.map("rows", rows, "total", total, "page", safePage, "size", safeSize));
    }

    @PostMapping("/reports/import")
    public ApiResult importReport(@RequestParam("file") MultipartFile file,
                                  @RequestParam(value = "type", defaultValue = "profit") String type,
                                  @RequestParam(value = "orgId", required = false) String orgId,
                                  HttpServletRequest request) {
        LoginUser user = apiSupport.require(request);
        if (file == null || file.isEmpty()) {
            return ApiResult.fail("请选择 Excel 文件");
        }
        String subject = "profit".equals(type) ? "1" : "balance".equals(type) ? "2"
                : "cashflow".equals(type) ? "5" : "3";
        try (InputStream input = file.getInputStream()) {
            ExcelImportService.ImportResult result = importService.importExcel(input, file.getOriginalFilename(),
                    subject, null, org(orgId, user), user.getAccountName());
            return result.isSuccess() ? ApiResult.ok("导入成功，共读取 " + result.getCount() + " 项", result)
                    : ApiResult.fail(result.getMessage());
        } catch (Exception ex) {
            return ApiResult.fail("导入失败: " + ex.getMessage());
        }
    }

    @PostMapping("/reports/bulk-import")
    public ApiResult bulkImport(@RequestParam("files") MultipartFile[] files,
                                @RequestParam(value = "orgId", required = false) String orgId,
                                HttpServletRequest request) {
        LoginUser user = apiSupport.require(request);
        int success = 0;
        List<String> failed = new ArrayList<String>();
        for (MultipartFile file : files) {
            String name = file.getOriginalFilename();
            String subject;
            String type = null;
            if (name == null) continue;
            if (name.contains("损益表") || name.contains("利润表")) subject = "1";
            else if (name.contains("资产负债表")) subject = "2";
            else if (name.contains("现金流量表")) subject = "5";
            else if (name.contains("科目余额表")) subject = "3";
            else if (name.contains("账龄分析")) {
                subject = "22";
                type = name.contains("其他应收") ? "4" : name.contains("其他应付") ? "3"
                        : name.contains("应付账款") ? "5" : name.contains("应收账款") ? "6"
                        : name.contains("预付账款") ? "7" : name.contains("预收账款") ? "8" : "7";
            } else {
                failed.add(name + ": 无法识别类型");
                continue;
            }
            try (InputStream input = file.getInputStream()) {
                ExcelImportService.ImportResult result = importService.importExcel(input, name, subject, type,
                        org(orgId, user), user.getAccountName());
                if (result.isSuccess()) success++;
                else failed.add(name + ": " + result.getMessage());
            } catch (Exception ex) {
                failed.add(name + ": " + ex.getMessage());
            }
        }
        return ApiResult.ok("成功导入 " + success + " 个文件", ApiResult.map("success", success, "failed", failed));
    }

    @GetMapping("/aging")
    public ApiResult aging(@RequestParam(value = "type", defaultValue = "7") int type,
                           @RequestParam(value = "orgId", required = false) String orgId,
                           @RequestParam(value = "period", required = false) String period,
                           HttpServletRequest request) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.aging(org(orgId, user), type, period));
    }

    @GetMapping("/code-library")
    public ApiResult codeLibrary(@RequestParam(value = "keyword", defaultValue = "") String keyword,
                                 HttpServletRequest request) {
        apiSupport.require(request);
        String where = keyword == null || keyword.isEmpty() ? "" : " WHERE CODE_NAME LIKE ? OR CODE_NO LIKE ?";
        Object[] args = keyword == null || keyword.isEmpty() ? new Object[]{} : new Object[]{"%" + keyword + "%", "%" + keyword + "%"};
        return ApiResult.ok(DbUtils.query(jdbc,
                "SELECT ID AS id,CODE_NAME AS codeName,CODE_NO AS codeNo,REPORT_TYPE AS reportType,"
                        + "use_area AS useArea,use_area_remark AS useAreaRemark,data_type AS dataType,"
                        + "is_current AS isCurrent,is_details AS isDetails,survey,warn,clzz,remark "
                        + "FROM t_code_libr" + where + " ORDER BY ID LIMIT 500", args));
    }

    @PostMapping("/code-library")
    public ApiResult createCode(@RequestBody Map<String, Object> body, HttpServletRequest request) {
        apiSupport.require(request);
        Long id = longValue(body, "id");
        if (id == null) id = jdbc.queryForObject("SELECT IFNULL(MAX(ID),10000)+1 FROM t_code_libr", Long.class);
        jdbc.update("INSERT INTO t_code_libr(ID,CODE_NAME,CODE_NO,REPORT_TYPE,use_area,use_area_remark,data_type,"
                        + "data_type_desc,is_current,is_details,survey,warn,parent_id,clzz,BASI_FIELD,km1,km2,km3,remark) "
                        + "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                id, text(body, "codeName"), text(body, "codeNo"), text(body, "reportType"), text(body, "useArea"),
                text(body, "useAreaRemark"), text(body, "dataType"), text(body, "dataTypeDesc"),
                text(body, "isCurrent"), text(body, "isDetails"), text(body, "survey"), text(body, "warn"),
                text(body, "parentId"), text(body, "clzz"), text(body, "basiField"), text(body, "km1"),
                text(body, "km2"), text(body, "km3"), text(body, "remark"));
        return ApiResult.ok("编码创建成功", null);
    }

    @PutMapping("/code-library/{id}")
    public ApiResult updateCode(@PathVariable long id, @RequestBody Map<String, Object> body,
                                HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("UPDATE t_code_libr SET CODE_NAME=?,CODE_NO=?,REPORT_TYPE=?,use_area=?,use_area_remark=?,"
                        + "data_type=?,is_current=?,is_details=?,survey=?,warn=?,clzz=?,remark=? WHERE ID=?",
                text(body, "codeName"), text(body, "codeNo"), text(body, "reportType"), text(body, "useArea"),
                text(body, "useAreaRemark"), text(body, "dataType"), text(body, "isCurrent"),
                text(body, "isDetails"), text(body, "survey"), text(body, "warn"), text(body, "clzz"),
                text(body, "remark"), id);
        return ApiResult.ok("编码更新成功", null);
    }

    @DeleteMapping("/code-library/{id}")
    public ApiResult deleteCode(@PathVariable long id, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("DELETE FROM t_code_mapper WHERE CODE_NO=(SELECT CODE_NO FROM t_code_libr WHERE ID=?)", id);
        jdbc.update("DELETE FROM t_code_libr WHERE ID=?", id);
        return ApiResult.ok("编码已删除", null);
    }

    @PostMapping("/code-library/sync")
    public ApiResult syncCodeLibrary(HttpServletRequest request) {
        apiSupport.require(request);
        int count = jdbc.update("UPDATE t_code_libr c JOIN t_code_mapper m ON c.CODE_NO=m.CODE_NO "
                + "SET c.BASI_FIELD=m.BASI_FIELD");
        return ApiResult.ok("编码字典同步完成", count);
    }

    @GetMapping("/code-mappers")
    public ApiResult codeMappers(@RequestParam(value = "keyword", defaultValue = "") String keyword,
                                 HttpServletRequest request) {
        apiSupport.require(request);
        String where = keyword == null || keyword.isEmpty() ? "" : " WHERE m.CODE_NO LIKE ? OR c.CODE_NAME LIKE ?";
        Object[] args = keyword == null || keyword.isEmpty() ? new Object[]{}
                : new Object[]{"%" + keyword + "%", "%" + keyword + "%"};
        return ApiResult.ok(DbUtils.query(jdbc,
                "SELECT m.BASI_FIELD AS basiField,m.CODE_NO AS codeNo,c.CODE_NAME AS codeName "
                        + "FROM t_code_mapper m LEFT JOIN t_code_libr c ON c.CODE_NO=m.CODE_NO"
                        + where + " ORDER BY m.CODE_NO LIMIT 500", args));
    }

    @PostMapping("/code-mappers")
    public ApiResult createMapper(@RequestBody Map<String, Object> body, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("INSERT INTO t_code_mapper(BASI_FIELD,CODE_NO,FBACK) VALUES(?,?,NULL)",
                text(body, "basiField"), text(body, "codeNo"));
        return ApiResult.ok("编码映射创建成功", null);
    }

    @PutMapping("/code-mappers/{codeNo}")
    public ApiResult updateMapper(@PathVariable String codeNo, @RequestBody Map<String, Object> body,
                                  HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("UPDATE t_code_mapper SET BASI_FIELD=? WHERE CODE_NO=?",
                text(body, "basiField"), codeNo);
        return ApiResult.ok("编码映射更新成功", null);
    }

    @DeleteMapping("/code-mappers/{codeNo}")
    public ApiResult deleteMapper(@PathVariable String codeNo, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("DELETE FROM t_code_mapper WHERE CODE_NO=?", codeNo);
        return ApiResult.ok("编码映射已删除", null);
    }

    @GetMapping("/modes")
    public ApiResult modes(@RequestParam(value = "keyword", defaultValue = "") String keyword,
                           HttpServletRequest request) {
        apiSupport.require(request);
        String where = keyword == null || keyword.isEmpty() ? "" : " WHERE REPORT_CONTEN LIKE ? OR MODE_AREA LIKE ?";
        Object[] args = keyword == null || keyword.isEmpty() ? new Object[]{} : new Object[]{"%" + keyword + "%", "%" + keyword + "%"};
        return ApiResult.ok(DbUtils.query(jdbc,
                "SELECT ID AS id,REPORT_TYPE AS reportType,REPORT_CONTEN AS reportConten,MODE_CONDITION AS modeCondition,"
                        + "MODE_CONTENT AS modeContent,MODE_VALUES AS modeValues,REMARK AS remark,MODE_AREA AS modeArea,"
                        + "CONDITION_VALUES AS conditionValues,PX AS px FROM t_mode" + where + " ORDER BY PX,ID LIMIT 500", args));
    }

    @PostMapping("/modes")
    public ApiResult createMode(@RequestBody Map<String, Object> body, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("INSERT INTO t_mode(REPORT_TYPE,REPORT_CONTEN,MODE_CONDITION,MODE_CONTENT,MODE_VALUES,REMARK,"
                        + "MODE_AREA,CONDITION_VALUES,PX) VALUES(?,?,?,?,?,?,?,?,?)",
                text(body, "reportType"), text(body, "reportConten"), text(body, "modeCondition"),
                text(body, "modeContent"), text(body, "modeValues"), text(body, "remark"), text(body, "modeArea"),
                text(body, "conditionValues"), intValue(body, "px"));
        return ApiResult.ok("算法配置创建成功", null);
    }

    @PutMapping("/modes/{id}")
    public ApiResult updateMode(@PathVariable long id, @RequestBody Map<String, Object> body,
                                HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("UPDATE t_mode SET REPORT_TYPE=?,REPORT_CONTEN=?,MODE_CONDITION=?,MODE_CONTENT=?,MODE_VALUES=?,"
                        + "REMARK=?,MODE_AREA=?,CONDITION_VALUES=?,PX=? WHERE ID=?",
                text(body, "reportType"), text(body, "reportConten"), text(body, "modeCondition"),
                text(body, "modeContent"), text(body, "modeValues"), text(body, "remark"), text(body, "modeArea"),
                text(body, "conditionValues"), intValue(body, "px"), id);
        return ApiResult.ok("算法配置更新成功", null);
    }

    @DeleteMapping("/modes/{id}")
    public ApiResult deleteMode(@PathVariable long id, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("DELETE FROM t_mode WHERE ID=?", id);
        return ApiResult.ok("算法配置已删除", null);
    }

    @GetMapping("/news")
    public ApiResult news(HttpServletRequest request) {
        apiSupport.require(request);
        return ApiResult.ok(DbUtils.query(jdbc,
                "SELECT ID AS id,TITLE AS title,CONTENT AS content,AUTHOR AS author,VIEW_NUM AS viewNum,"
                        + "UP_DATE AS up_date,UP_PERSON AS upPerson,UP_PERSON_TEL AS upPersonTel,CLZZ AS clzz "
                        + "FROM t_message_info ORDER BY CREATE_TIME DESC"));
    }

    @PostMapping("/news")
    public ApiResult createNews(@RequestBody Map<String, Object> body, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("INSERT INTO t_message_info(ARRY_QUE,TITLE,CONTENT,VIEW_NUM,AUTHOR,UP_DATE,UP_PERSON,"
                        + "UP_PERSON_TEL,CREATE_TIME,CREATE_USER,UPDATE_TIME,UPDATE_USER,CLZZ) "
                        + "VALUES(?,?,?,?,?,CURDATE(),?,?,NOW(),?,NOW(),?,?)",
                text(body, "arryQue"), text(body, "title"), text(body, "content"), intValue(body, "viewNum"),
                text(body, "author"), text(body, "upPerson"), text(body, "upPersonTel"), "admin", "admin",
                text(body, "clzz"));
        return ApiResult.ok("资讯创建成功", null);
    }

    @PutMapping("/news/{id}")
    public ApiResult updateNews(@PathVariable long id, @RequestBody Map<String, Object> body,
                                HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("UPDATE t_message_info SET TITLE=?,CONTENT=?,VIEW_NUM=?,AUTHOR=?,UP_PERSON=?,UP_PERSON_TEL=?,"
                        + "CLZZ=?,UPDATE_TIME=NOW(),UPDATE_USER=? WHERE ID=?",
                text(body, "title"), text(body, "content"), intValue(body, "viewNum"), text(body, "author"),
                text(body, "upPerson"), text(body, "upPersonTel"), text(body, "clzz"), "admin", id);
        return ApiResult.ok("资讯更新成功", null);
    }

    @DeleteMapping("/news/{id}")
    public ApiResult deleteNews(@PathVariable long id, HttpServletRequest request) {
        apiSupport.require(request);
        jdbc.update("DELETE FROM t_message_info WHERE ID=?", id);
        return ApiResult.ok("资讯已删除", null);
    }

    @PostMapping("/convert")
    public ApiResult convert(@RequestBody(required = false) Map<String, Object> body, HttpServletRequest request) {
        LoginUser user = apiSupport.require(request);
        String orgId = org(text(body, "orgId"), user);
        int count = conversionService.convert(orgId);
        return ApiResult.ok("数据转换成功，共生成 " + count + " 条标准结果", count);
    }

    private String reportTable(String type) {
        if ("balance".equals(type)) return "t_basi_assets_and_liabilities";
        if ("cashflow".equals(type)) return "t_basi_cash_flow";
        if ("kmye".equals(type)) return "t_kmye";
        return "t_basi_profit";
    }

    private String org(String orgId, LoginUser user) {
        if (orgId != null && !orgId.trim().isEmpty()) return orgId.trim();
        if (user != null && user.getOrgId() != null) return String.valueOf(user.getOrgId());
        List<Map<String, Object>> rows = jdbc.queryForList("SELECT id FROM t_org_info ORDER BY id LIMIT 1");
        return rows.isEmpty() ? "1" : String.valueOf(rows.get(0).get("id"));
    }

    private String text(Map<String, Object> body, String key) {
        Object value = body == null ? null : body.get(key);
        return value == null ? null : String.valueOf(value);
    }

    private Long longValue(Map<String, Object> body, String key) {
        String value = text(body, key);
        if (value == null || value.isEmpty()) return null;
        try {
            return Long.valueOf(value);
        } catch (NumberFormatException ex) {
            return null;
        }
    }

    private int intValue(Map<String, Object> body, String key) {
        Long value = longValue(body, key);
        return value == null ? 0 : value.intValue();
    }
}
