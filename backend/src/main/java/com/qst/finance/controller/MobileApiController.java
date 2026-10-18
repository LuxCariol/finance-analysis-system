package com.qst.finance.controller;

import com.qst.finance.common.ApiResult;
import com.qst.finance.common.DbUtils;
import com.qst.finance.common.SecurityUtils;
import com.qst.finance.service.AnalyticsService;
import com.qst.finance.service.ApiSupport;
import com.qst.finance.service.AuthService;
import com.qst.finance.service.ForecastService;
import com.qst.finance.service.InvestmentService;
import com.qst.finance.service.LoginUser;
import com.qst.finance.service.TokenStore;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class MobileApiController {
    private final AuthService authService;
    private final ApiSupport apiSupport;
    private final AnalyticsService analytics;
    private final ForecastService forecastService;
    private final InvestmentService investmentService;
    private final TokenStore tokenStore;
    private final JdbcTemplate jdbc;

    public MobileApiController(AuthService authService, ApiSupport apiSupport, AnalyticsService analytics,
                               ForecastService forecastService, InvestmentService investmentService,
                               TokenStore tokenStore, JdbcTemplate jdbc) {
        this.authService = authService;
        this.apiSupport = apiSupport;
        this.analytics = analytics;
        this.forecastService = forecastService;
        this.investmentService = investmentService;
        this.tokenStore = tokenStore;
        this.jdbc = jdbc;
    }

    @GetMapping("/health")
    public ApiResult health() {
        return ApiResult.ok(ApiResult.map("status", "UP", "database", "financial_analysis"));
    }

    @PostMapping("/auth/login")
    public ApiResult login(@RequestBody Map<String, String> body) {
        LoginUser user = authService.login(body.get("account"), body.get("password"));
        if (user == null) {
            return ApiResult.fail(401, "账号或密码错误");
        }
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("token", user.getToken());
        data.put("user", user);
        return ApiResult.ok("登录成功", data);
    }

    @PostMapping("/auth/logout")
    public ApiResult logout(HttpServletRequest request) {
        tokenStore.remove(SecurityUtils.token(request));
        return ApiResult.ok("已退出登录", null);
    }

    @GetMapping("/auth/profile")
    public ApiResult profile(HttpServletRequest request) {
        LoginUser user = apiSupport.require(request);
        Map<String, Object> row = DbUtils.queryOne(jdbc,
                "SELECT id, user_name, account_name, description, org_id FROM t_sys_user WHERE id=?", user.getId());
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("user", row);
        data.put("org", org(user, null));
        return ApiResult.ok(data);
    }

    @PutMapping("/auth/profile")
    public ApiResult updateProfile(HttpServletRequest request, @RequestBody Map<String, String> body) {
        LoginUser user = apiSupport.require(request);
        if (body.get("pwd") != null && !body.get("pwd").isEmpty()) {
            Map<String, Object> current = DbUtils.queryOne(jdbc, "SELECT pwd FROM t_sys_user WHERE id=?", user.getId());
            String stored = DbUtils.str(current, "pwd", "");
            if (body.get("oldPwd") == null || (!stored.equalsIgnoreCase(SecurityUtils.md5(body.get("oldPwd")))
                    && !stored.equals(body.get("oldPwd")))) {
                return ApiResult.fail("原密码不正确");
            }
            jdbc.update("UPDATE t_sys_user SET user_name=?,pwd=?,description=? WHERE id=?",
                    body.get("userName"), SecurityUtils.md5(body.get("pwd")), body.get("description"), user.getId());
        } else {
            jdbc.update("UPDATE t_sys_user SET user_name=?,description=? WHERE id=?",
                    body.get("userName"), body.get("description"), user.getId());
        }
        return ApiResult.ok("保存成功", authService.findById(user.getId()));
    }

    @GetMapping({"/home/report", "/report/template"})
    public ApiResult homeReport(HttpServletRequest request,
                                @RequestParam(value = "orgId", required = false) String orgId,
                                @RequestParam(value = "period", required = false) String period) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.homeReport(resolveOrg(user, orgId), period));
    }

    @GetMapping("/finance/overview")
    public ApiResult overview(HttpServletRequest request,
                              @RequestParam(value = "orgId", required = false) String orgId,
                              @RequestParam(value = "period", required = false) String period) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.overview(resolveOrg(user, orgId), period));
    }

    @GetMapping({"/report/profit", "/report/profit-detail"})
    public ApiResult profit(HttpServletRequest request,
                            @RequestParam(value = "orgId", required = false) String orgId,
                            @RequestParam(value = "period", required = false) String period) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.reportDetail(resolveOrg(user, orgId), period, "profit"));
    }

    @GetMapping({"/report/balance", "/report/balance-detail"})
    public ApiResult balance(HttpServletRequest request,
                             @RequestParam(value = "orgId", required = false) String orgId,
                             @RequestParam(value = "period", required = false) String period) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.reportDetail(resolveOrg(user, orgId), period, "balance"));
    }

    @GetMapping({"/report/cashflow", "/report/cashflow-detail"})
    public ApiResult cashflow(HttpServletRequest request,
                              @RequestParam(value = "orgId", required = false) String orgId,
                              @RequestParam(value = "period", required = false) String period) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.reportDetail(resolveOrg(user, orgId), period, "cashflow"));
    }

    @GetMapping("/report/account-balance")
    public ApiResult accountBalance(HttpServletRequest request,
                                    @RequestParam(value = "orgId", required = false) String orgId,
                                    @RequestParam(value = "period", required = false) String period,
                                    @RequestParam(value = "keyword", required = false) String keyword) {
        LoginUser user = apiSupport.require(request);
        String resolvedOrg = resolveOrg(user, orgId);
        if (period == null || period.isEmpty()) {
            period = analytics.latestPeriod(resolvedOrg);
        }
        String sql = "SELECT SUBJECT_CODE, SUBJECT_NAME, QCJFYE, QCDFYE, BQJFFSE, BQDFFSE, QMJFYE, QMDFYE "
                + "FROM t_kmye WHERE ORG_ID=? AND KJYEAR_MOTH=? "
                + (keyword == null || keyword.isEmpty() ? "" : "AND (SUBJECT_CODE LIKE ? OR SUBJECT_NAME LIKE ?) ")
                + "ORDER BY SUBJECT_CODE LIMIT 500";
        Object[] args = keyword == null || keyword.isEmpty() ? new Object[]{resolvedOrg, period}
                : new Object[]{resolvedOrg, period, "%" + keyword + "%", "%" + keyword + "%"};
        return ApiResult.ok(ApiResult.map("period", period, "items", DbUtils.query(jdbc, sql, args)));
    }

    @GetMapping("/analysis/home")
    public ApiResult analysisHome(HttpServletRequest request,
                                  @RequestParam(value = "orgId", required = false) String orgId,
                                  @RequestParam(value = "period", required = false) String period) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.analysisHome(resolveOrg(user, orgId), period));
    }

    @GetMapping("/analysis/balance")
    public ApiResult analysisBalance(HttpServletRequest request,
                                     @RequestParam(value = "orgId", required = false) String orgId,
                                     @RequestParam(value = "period", required = false) String period) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.analysis(resolveOrg(user, orgId), period, "balance"));
    }

    @GetMapping("/analysis/profit")
    public ApiResult analysisProfit(HttpServletRequest request,
                                    @RequestParam(value = "orgId", required = false) String orgId,
                                    @RequestParam(value = "period", required = false) String period) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.analysis(resolveOrg(user, orgId), period, "profit"));
    }

    @GetMapping("/analysis/cashflow")
    public ApiResult analysisCashflow(HttpServletRequest request,
                                      @RequestParam(value = "orgId", required = false) String orgId,
                                      @RequestParam(value = "period", required = false) String period) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.analysis(resolveOrg(user, orgId), period, "cashflow"));
    }

    @GetMapping("/analysis/profit/chart")
    public ApiResult profitChart(HttpServletRequest request,
                                 @RequestParam(value = "orgId", required = false) String orgId) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.profitChart(resolveOrg(user, orgId)));
    }

    @GetMapping("/analysis/cashflow/chart")
    public ApiResult cashChart(HttpServletRequest request,
                               @RequestParam(value = "orgId", required = false) String orgId) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.cashChart(resolveOrg(user, orgId)));
    }

    @GetMapping("/analysis/ratio")
    public ApiResult ratio(HttpServletRequest request,
                           @RequestParam(value = "orgId", required = false) String orgId,
                           @RequestParam(value = "period", required = false) String period) {
        LoginUser user = apiSupport.require(request);
        String resolvedOrg = resolveOrg(user, orgId);
        if (period == null || period.isEmpty()) {
            period = analytics.latestPeriod(resolvedOrg);
        }
        Map<String, Object> assets = analytics.raw("t_basi_assets_and_liabilities", resolvedOrg, period);
        Map<String, Object> profit = analytics.raw("t_basi_profit", resolvedOrg, period);
        Map<String, Object> cash = analytics.raw("t_basi_cash_flow", resolvedOrg, period);
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("period", period);
        data.put("categories", analytics.ratios(assets, profit, cash));
        data.put("healthScore", analytics.healthScore(analytics.ratios(assets, profit, cash)));
        return ApiResult.ok(data);
    }

    @PostMapping("/forecast/profit")
    public ApiResult forecastProfit(HttpServletRequest request, @RequestBody(required = false) Map<String, Object> body) {
        LoginUser user = apiSupport.require(request);
        Map<String, Object> input = body == null ? new LinkedHashMap<String, Object>() : body;
        int months = (int) number(input, "months", 6);
        double adjustment = number(input, "growthAdjustment", 0) / 100D;
        return ApiResult.ok(forecastService.profitForecast(resolveOrg(user, value(input, "orgId")), months, adjustment));
    }

    @GetMapping("/forecast/profit")
    public ApiResult forecastProfitGet(HttpServletRequest request,
                                       @RequestParam(value = "orgId", required = false) String orgId,
                                       @RequestParam(value = "months", defaultValue = "6") int months) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(forecastService.profitForecast(resolveOrg(user, orgId), months, 0D));
    }

    @GetMapping({"/finance/detail", "/finance/data-detail"})
    public ApiResult financeDetail(HttpServletRequest request,
                                   @RequestParam(value = "code", defaultValue = "ZCFZ-G") String code,
                                   @RequestParam(value = "orgId", required = false) String orgId) {
        LoginUser user = apiSupport.require(request);
        String resolvedOrg = resolveOrg(user, orgId);
        Map<String, Object> data = analytics.trend(resolvedOrg, code);
        data.put("detail", analytics.reportDetail(resolvedOrg, null,
                code.startsWith("ZCFZ") ? "balance" : code.startsWith("LR") ? "profit" : "cashflow"));
        return ApiResult.ok(data);
    }

    @GetMapping("/finance/detail/chart")
    public ApiResult financeChart(HttpServletRequest request,
                                  @RequestParam(value = "code", defaultValue = "ZCFZ-G") String code,
                                  @RequestParam(value = "orgId", required = false) String orgId) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.trend(resolveOrg(user, orgId), code));
    }

    @GetMapping({"/finance/aging", "/finance/aging-chart"})
    public ApiResult aging(HttpServletRequest request,
                           @RequestParam(value = "type", defaultValue = "7") int type,
                           @RequestParam(value = "orgId", required = false) String orgId,
                           @RequestParam(value = "period", required = false) String period) {
        LoginUser user = apiSupport.require(request);
        return ApiResult.ok(analytics.aging(resolveOrg(user, orgId), type, period));
    }

    @GetMapping("/finance/summary-warning")
    public ApiResult summaryWarning(HttpServletRequest request,
                                    @RequestParam(value = "orgId", required = false) String orgId,
                                    @RequestParam(value = "period", required = false) String period) {
        LoginUser user = apiSupport.require(request);
        Map<String, Object> overview = analytics.overview(resolveOrg(user, orgId), period);
        return ApiResult.ok(ApiResult.map("overview", overview, "alerts", overview.get("alerts"),
                "suggestions", overview.get("ratios")));
    }

    @PostMapping({"/investment/preview", "/investment/pre-submit"})
    public ApiResult investmentPreview(HttpServletRequest request, @RequestBody(required = false) Map<String, Object> body) {
        apiSupport.require(request);
        return ApiResult.ok(investmentService.calculate(body, true));
    }

    @PostMapping("/investment/forecast")
    public ApiResult investmentForecast(HttpServletRequest request, @RequestBody(required = false) Map<String, Object> body) {
        apiSupport.require(request);
        return ApiResult.ok(investmentService.calculate(body, false));
    }

    @GetMapping("/news")
    public ApiResult news(@RequestParam(value = "limit", defaultValue = "10") int limit) {
        return ApiResult.ok(analytics.news(limit));
    }

    private String resolveOrg(LoginUser user, String orgId) {
        if (orgId != null && !orgId.trim().isEmpty()) {
            return orgId.trim();
        }
        if (user.getOrgId() != null) {
            return String.valueOf(user.getOrgId());
        }
        List<Map<String, Object>> rows = jdbc.queryForList("SELECT id FROM t_org_info ORDER BY id LIMIT 1");
        return rows.isEmpty() ? "1" : String.valueOf(rows.get(0).get("id"));
    }

    private Map<String, Object> org(LoginUser user, String orgId) {
        Map<String, Object> row = DbUtils.queryOne(jdbc, "SELECT * FROM t_org_info WHERE id=?",
                resolveOrg(user, orgId));
        return row == null ? new LinkedHashMap<String, Object>() : row;
    }

    private String value(Map<String, Object> body, String key) {
        Object value = body == null ? null : body.get(key);
        return value == null ? null : String.valueOf(value);
    }

    private double number(Map<String, Object> body, String key, double defaultValue) {
        String value = value(body, key);
        if (value == null) {
            return defaultValue;
        }
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException ex) {
            return defaultValue;
        }
    }
}
