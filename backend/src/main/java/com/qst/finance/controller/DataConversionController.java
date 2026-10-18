package com.qst.finance.controller;

import com.qst.finance.service.ReportConversionService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.LinkedHashMap;
import java.util.Map;

@Controller
@RequestMapping("/dataFormat")
public class DataConversionController {
    private final ReportConversionService conversionService;

    public DataConversionController(ReportConversionService conversionService) {
        this.conversionService = conversionService;
    }

    @PostMapping("/dataFormatAll")
    @ResponseBody
    public Map<String, Object> dataFormatAll(
            @RequestParam(value = "table_name", required = false) String tableName,
            @RequestParam(value = "imp_user", required = false) String impUser,
            @RequestParam(value = "org_id", required = false) String orgId) {
        int count = conversionService.convert(orgId);
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        result.put("success", true);
        result.put("count", count);
        result.put("msg", count > 0 ? "转换成功" : "暂无可转换的报表数据");
        return result;
    }
}
