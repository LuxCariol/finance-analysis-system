package com.qst.finance.controller;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.qst.finance.common.Result;
import com.qst.finance.model.CodeLibr;
import com.qst.finance.model.CodeMapper;
import com.qst.finance.model.MessageInfo;
import com.qst.finance.model.Mode;
import com.qst.finance.model.ReportName;
import com.qst.finance.model.ReportProperty;
import com.qst.finance.service.ModelService;

/**
 * 模型管理接口: 报表与取值配置 / 编码映射 / 编码字典 / 算法配置 / 资讯管理 / 数据转换
 */
@RestController
@RequestMapping("/api/model")
public class ModelController extends BaseController {

    @Autowired
    private ModelService modelService;

    // ---------------------------------------------------------------- 报表配置

    @GetMapping("/report/list")
    public Result<List<ReportName>> reportList() {
        return Result.ok(modelService.reportNames());
    }

    @PostMapping("/report/save")
    public Result<Void> saveReport(@RequestBody ReportName reportName) {
        modelService.saveReportName(reportName);
        return Result.ok();
    }

    @PostMapping("/report/delete")
    public Result<Void> deleteReport(@RequestParam Long id) {
        modelService.deleteReportName(id);
        return Result.ok();
    }

    // ---------------------------------------------------------------- 取值配置

    @GetMapping("/property/list")
    public Result<List<ReportProperty>> propertyList(@RequestParam(required = false) String reportType) {
        return Result.ok(modelService.properties(reportType));
    }

    @PostMapping("/property/save")
    public Result<Void> saveProperty(@RequestBody ReportProperty property) {
        modelService.saveProperty(property);
        return Result.ok();
    }

    @PostMapping("/property/delete")
    public Result<Void> deleteProperty(@RequestParam Long id) {
        modelService.deleteProperty(id);
        return Result.ok();
    }

    // ---------------------------------------------------------------- 编码字典

    @GetMapping("/libr/list")
    public Result<List<CodeLibr>> librList(@RequestParam(required = false) String reportType) {
        return Result.ok(modelService.codeLibres(reportType));
    }

    @PostMapping("/libr/save")
    public Result<Void> saveLibr(@RequestBody CodeLibr codeLibr) {
        modelService.saveCodeLibr(codeLibr);
        return Result.ok();
    }

    @PostMapping("/libr/delete")
    public Result<Void> deleteLibr(@RequestParam Long id) {
        modelService.deleteCodeLibr(id);
        return Result.ok();
    }

    // ---------------------------------------------------------------- 编码映射

    @GetMapping("/mapper/list")
    public Result<List<CodeMapper>> mapperList(@RequestParam(required = false) String reportType) {
        return Result.ok(modelService.codeMappers(reportType));
    }

    @PostMapping("/mapper/save")
    public Result<Void> saveMapper(@RequestBody CodeMapper codeMapper) {
        modelService.saveCodeMapper(codeMapper);
        return Result.ok();
    }

    @PostMapping("/mapper/delete")
    public Result<Void> deleteMapper(@RequestParam Long id) {
        modelService.deleteCodeMapper(id);
        return Result.ok();
    }

    // ---------------------------------------------------------------- 算法配置

    @GetMapping("/mode/list")
    public Result<List<Mode>> modeList(@RequestParam(required = false) String modeType) {
        return Result.ok(modelService.modes(modeType));
    }

    @PostMapping("/mode/save")
    public Result<Void> saveMode(@RequestBody Mode mode) {
        modelService.saveMode(mode);
        return Result.ok();
    }

    @PostMapping("/mode/delete")
    public Result<Void> deleteMode(@RequestParam Long id) {
        modelService.deleteMode(id);
        return Result.ok();
    }

    /** 算法表达式试算 */
    @GetMapping("/mode/test")
    public Result<BigDecimal> testMode(@RequestParam String expression,
                                       @RequestParam(defaultValue = "1") Long orgId,
                                       @RequestParam(required = false) String kjyearMonth) {
        return Result.ok(modelService.testExpression(expression, orgId, defaultMonth(kjyearMonth)));
    }

    // ---------------------------------------------------------------- 资讯

    @GetMapping("/news/list")
    public Result<List<MessageInfo>> newsList() {
        return Result.ok(modelService.news());
    }

    @PostMapping("/news/save")
    public Result<Void> saveNews(@RequestBody MessageInfo info) {
        modelService.saveNews(info);
        return Result.ok();
    }

    @PostMapping("/news/delete")
    public Result<Void> deleteNews(@RequestParam Long id) {
        modelService.deleteNews(id);
        return Result.ok();
    }
}
