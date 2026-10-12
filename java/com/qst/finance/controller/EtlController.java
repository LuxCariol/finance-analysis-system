package com.qst.finance.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.qst.finance.common.Result;
import com.qst.finance.model.SysUser;
import com.qst.finance.model.TransformResult;
import com.qst.finance.model.WarnRecord;
import com.qst.finance.service.EtlService;

/**
 * 数据转换(ETL)接口
 */
@RestController
@RequestMapping("/api/etl")
public class EtlController extends BaseController {

    @Autowired
    private EtlService etlService;

    @PostMapping("/transform")
    public Result<TransformResult> transform(@RequestBody Map<String, Object> body, HttpSession session) {
        SysUser user = currentUser(session);
        Long orgId = defaultOrgId(body.get("orgId") == null ? null : Long.valueOf(String.valueOf(body.get("orgId"))));
        String kjyearMonth = defaultMonth(body.get("kjyearMonth") == null ? null : String.valueOf(body.get("kjyearMonth")));
        TransformResult result = etlService.transform(orgId, kjyearMonth, user.getAccountName());
        return Result.ok("数据转换完成", result);
    }

    @GetMapping("/status")
    public Result<Map<String, Object>> status(@RequestParam(defaultValue = "1") Long orgId,
                                              @RequestParam(required = false) String kjyearMonth) {
        return Result.ok(etlService.transformStatus(orgId, defaultMonth(kjyearMonth)));
    }

    @GetMapping("/warn")
    public Result<List<WarnRecord>> warn(@RequestParam(defaultValue = "1") Long orgId,
                                        @RequestParam(required = false) String kjyearMonth) {
        return Result.ok(etlService.warnRecords(orgId, defaultMonth(kjyearMonth)));
    }
}
