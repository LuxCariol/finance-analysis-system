package com.qst.finance.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.qst.finance.common.Result;
import com.qst.finance.model.ImportLog;
import com.qst.finance.model.ImportResult;
import com.qst.finance.model.ReportName;
import com.qst.finance.model.SysUser;
import com.qst.finance.service.ImportService;

/**
 * 数据导入接口(批量导入 / 三大报表 / 科目余额表 / 账龄分析)
 */
@RestController
@RequestMapping("/api/import")
public class ImportController extends BaseController {

    @Autowired
    private ImportService importService;

    @GetMapping("/templates")
    public Result<List<ReportName>> templates() {
        return Result.ok(importService.templates());
    }

    @PostMapping("/upload")
    public Result<ImportResult> upload(@RequestParam("file") MultipartFile file,
                                       @RequestParam String reportType,
                                       @RequestParam(required = false) Long orgId,
                                       @RequestParam(required = false) String kjyearMonth,
                                       @RequestParam(defaultValue = "false") boolean override,
                                       @RequestParam(required = false) String agingType,
                                       HttpSession session) {
        SysUser user = currentUser(session);
        ImportResult result = importService.importExcel(reportType, file, orgId, kjyearMonth,
                override, agingType, user.getAccountName());
        return Result.ok(result.getMessage(), result);
    }

    /** 下载导入模板(standard: 空模板 / sample: 带示例数据的模板) */
    @GetMapping("/template")
    public ResponseEntity<byte[]> template(@RequestParam String reportType,
                                           @RequestParam(defaultValue = "false") boolean sample) {
        byte[] bytes = importService.buildTemplate(reportType, sample);
        String fileName = reportType + (sample ? "_示例数据" : "_导入模板") + ".xlsx";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        try {
            headers.setContentDispositionFormData("attachment", URLEncoder.encode(fileName, "UTF-8"));
        } catch (UnsupportedEncodingException e) {
            headers.setContentDispositionFormData("attachment", fileName);
        }
        return new ResponseEntity<byte[]>(bytes, headers, org.springframework.http.HttpStatus.OK);
    }

    @GetMapping("/logs")
    public Result<List<ImportLog>> logs() {
        return Result.ok(importService.logs());
    }
}
