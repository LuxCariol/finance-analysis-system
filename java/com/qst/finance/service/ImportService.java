package com.qst.finance.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.qst.finance.model.ImportLog;
import com.qst.finance.model.ImportResult;
import com.qst.finance.model.ReportName;

/**
 * 财务数据导入服务(金蝶K8报表 Excel -> 系统基础表)
 */
public interface ImportService {

    List<ReportName> templates();

    ImportResult importExcel(String reportType, MultipartFile file, Long orgId, String kjyearMonth,
                             boolean override, String agingType, String impUser);

    byte[] buildTemplate(String reportType, boolean sample);

    List<ImportLog> logs();
}
