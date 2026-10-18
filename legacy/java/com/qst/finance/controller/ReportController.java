package com.qst.finance.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.qst.finance.common.Result;
import com.qst.finance.service.ReportService;

/**
 * 财务报表接口: 资产负债表 / 利润表 / 现金流量表 / 科目余额表 / 账龄分析
 */
@RestController
@RequestMapping("/api/report")
public class ReportController extends BaseController {

    @Autowired
    private ReportService reportService;

    @GetMapping("/balance")
    public Result<Map<String, Object>> balance(@RequestParam(defaultValue = "1") Long orgId,
                                               @RequestParam(required = false) String kjyearMonth) {
        return Result.ok(reportService.balanceSheet(orgId, defaultMonth(kjyearMonth)));
    }

    @GetMapping("/profit")
    public Result<Map<String, Object>> profit(@RequestParam(defaultValue = "1") Long orgId,
                                              @RequestParam(required = false) String kjyearMonth) {
        return Result.ok(reportService.profitReport(orgId, defaultMonth(kjyearMonth)));
    }

    @GetMapping("/cashflow")
    public Result<Map<String, Object>> cashflow(@RequestParam(defaultValue = "1") Long orgId,
                                                @RequestParam(required = false) String kjyearMonth) {
        return Result.ok(reportService.cashFlowReport(orgId, defaultMonth(kjyearMonth)));
    }

    @GetMapping("/codes")
    public Result<List<Map<String, Object>>> codes(@RequestParam(defaultValue = "1") Long orgId,
                                                   @RequestParam(required = false) String kjyearMonth,
                                                   @RequestParam(required = false) String reportType,
                                                   @RequestParam(required = false) String keyword) {
        return Result.ok(reportService.codeDetail(orgId, defaultMonth(kjyearMonth), reportType, keyword));
    }

    @GetMapping("/kmye")
    public Result<List<Map<String, Object>>> kmye(@RequestParam(defaultValue = "1") Long orgId,
                                                  @RequestParam(required = false) String kjyearMonth,
                                                  @RequestParam(required = false) String keyword) {
        return Result.ok(reportService.kmyeList(orgId, defaultMonth(kjyearMonth), keyword));
    }

    @GetMapping("/aging")
    public Result<Map<String, Object>> aging(@RequestParam(defaultValue = "1") Long orgId,
                                             @RequestParam(required = false) String kjyearMonth,
                                             @RequestParam(required = false) String agingType) {
        return Result.ok(reportService.agingAnalysis(orgId, defaultMonth(kjyearMonth), agingType));
    }
}
