package com.qst.finance.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.qst.finance.common.Result;
import com.qst.finance.model.CalcResult;
import com.qst.finance.model.AnalysisReport;
import com.qst.finance.model.SysUser;
import com.qst.finance.model.TrendSeries;
import com.qst.finance.service.AnalysisService;

/**
 * 财务分析接口: 比率分析 / 资金概要与预警 / 杜邦分析 / 投资计算 / 损益预测 / 首页概览
 */
@RestController
@RequestMapping("/api/analysis")
public class AnalysisController extends BaseController {

    @Autowired
    private AnalysisService analysisService;

    @GetMapping("/ratio")
    public Result<Map<String, Object>> ratio(@RequestParam(defaultValue = "1") Long orgId,
                                             @RequestParam(required = false) String kjyearMonth) {
        String month = defaultMonth(kjyearMonth);
        List<CalcResult> list = analysisService.ratioAnalysis(orgId, month);
        return Result.ok(wrap(orgId, month, list));
    }

    @GetMapping("/fund")
    public Result<Map<String, Object>> fund(@RequestParam(defaultValue = "1") Long orgId,
                                            @RequestParam(required = false) String kjyearMonth) {
        String month = defaultMonth(kjyearMonth);
        List<CalcResult> list = analysisService.fundAnalysis(orgId, month);
        Map<String, Object> data = wrap(orgId, month, list);
        Map<String, Object> values = new LinkedHashMap<String, Object>();
        data.put("cashDetail", values);
        return Result.ok(data);
    }

    @GetMapping("/dupont")
    public Result<Map<String, Object>> dupont(@RequestParam(defaultValue = "1") Long orgId,
                                              @RequestParam(required = false) String kjyearMonth) {
        String month = defaultMonth(kjyearMonth);
        List<CalcResult> list = analysisService.dupontAnalysis(orgId, month);
        return Result.ok(wrap(orgId, month, list));
    }

    @GetMapping("/enterprise")
    public Result<Map<String, Object>> enterprise(@RequestParam(defaultValue = "1") Long orgId,
                                                  @RequestParam(required = false) String kjyearMonth) {
        return Result.ok(analysisService.enterpriseReport(orgId, defaultMonth(kjyearMonth)));
    }

    /** 指定算法指标的近 N 个月趋势(按月重新计算表达式, 不依赖是否执行过数据转换) */
    @GetMapping("/trend")
    public Result<TrendSeries> trend(@RequestParam String modeCode,
                                     @RequestParam(defaultValue = "1") Long orgId,
                                     @RequestParam(required = false) String kjyearMonth,
                                     @RequestParam(defaultValue = "6") Integer months) {
        return Result.ok(analysisService.trendOfMode(orgId, modeCode, defaultMonth(kjyearMonth), months));
    }

    @GetMapping("/dashboard")
    public Result<Map<String, Object>> dashboard(@RequestParam(defaultValue = "1") Long orgId,
                                                 @RequestParam(required = false) String kjyearMonth) {
        return Result.ok(analysisService.dashboard(orgId, defaultMonth(kjyearMonth)));
    }

    @PostMapping("/investment")
    public Result<Map<String, Object>> investment(@RequestBody Map<String, Object> input) {
        return Result.ok(analysisService.investmentCalc(input));
    }

    /** 保存投资预测报告 */
    @PostMapping("/investment/report")
    public Result<AnalysisReport> saveInvestmentReport(@RequestBody Map<String, Object> input,
                                                       javax.servlet.http.HttpSession session) {
        SysUser user = currentUser(session);
        input.put("creator", user.getAccountName());
        return Result.ok("报告已保存", analysisService.saveInvestmentReport(input));
    }

    @GetMapping("/investment/reports")
    public Result<List<AnalysisReport>> investmentReports() {
        return Result.ok(analysisService.investmentReports());
    }

    @GetMapping("/forecast")
    public Result<Map<String, Object>> forecast(@RequestParam(defaultValue = "1") Long orgId,
                                                @RequestParam(required = false) String kjyearMonth,
                                                @RequestParam(defaultValue = "3") Integer periods) {
        return Result.ok(analysisService.profitForecast(orgId, defaultMonth(kjyearMonth), periods));
    }

    private Map<String, Object> wrap(Long orgId, String month, List<CalcResult> list) {
        int warnCount = 0;
        for (CalcResult result : list) {
            if (result.getWarnLevel() != null && result.getWarnLevel() > 0) {
                warnCount++;
            }
        }
        Map<String, Object> data = new LinkedHashMap<String, Object>();
        data.put("orgId", orgId);
        data.put("kjyearMonth", month);
        data.put("list", list);
        data.put("warnCount", warnCount);
        return data;
    }
}
