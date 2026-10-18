package com.qst.finance.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@Component
public class DemoDataInitializer implements ApplicationRunner {
    private static final Logger log = LoggerFactory.getLogger(DemoDataInitializer.class);

    private final JdbcTemplate jdbc;
    private final ExcelImportService importService;
    private final ReportConversionService conversionService;

    public DemoDataInitializer(JdbcTemplate jdbc, ExcelImportService importService,
                               ReportConversionService conversionService) {
        this.jdbc = jdbc;
        this.importService = importService;
        this.conversionService = conversionService;
    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        Long orgCount = jdbc.queryForObject("SELECT COUNT(*) FROM t_org_info", Long.class);
        if (orgCount == null || orgCount == 0) {
            log.warn("未找到演示公司，跳过样例报表导入");
            return;
        }
        boolean needProfit = empty("t_basi_profit");
        boolean needAssets = empty("t_basi_assets_and_liabilities");
        boolean needCash = empty("t_basi_cash_flow");
        boolean needKmye = empty("t_kmye");
        boolean needAge = empty("t_age_analysis");
        List<String> names = new ArrayList<String>();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(
                new ClassPathResource("demo-data/index.txt").getInputStream(), StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    names.add(line.trim());
                }
            }
        }
        log.info("演示文件清单数量: {}", names.size());
        int imported = 0;
        for (String name : names) {
            String subject;
            String type = null;
            if (name.contains("损益表") || name.contains("利润表")) {
                if (!needProfit) continue;
                subject = "1";
            } else if (name.contains("资产负债表")) {
                if (!needAssets) continue;
                subject = "2";
            } else if (name.contains("现金流量表")) {
                if (!needCash) continue;
                subject = "5";
            } else if (name.contains("科目余额表")) {
                if (!needKmye) continue;
                subject = "3";
            } else if (name.contains("账龄分析")) {
                if (!needAge) continue;
                subject = "22";
                if (name.contains("其他应收")) type = "4";
                else if (name.contains("其他应付")) type = "3";
                else if (name.contains("应付账款")) type = "5";
                else if (name.contains("应收账款")) type = "6";
                else if (name.contains("预付账款")) type = "7";
                else if (name.contains("预收账款")) type = "8";
                else if (name.contains("产成品")) type = "9";
                else if (name.contains("原材料")) type = "10";
            } else {
                continue;
            }
            if (name.contains("账龄分析")) {
                log.info("准备导入账龄文件: {} subject={} type={}", name, subject, type);
            }
            try (InputStream inputStream = new ClassPathResource("demo-data/2021/" + name).getInputStream()) {
                ExcelImportService.ImportResult result = importService.importExcel(inputStream, name, subject, type,
                        "1", "demo");
                if (result.isSuccess()) {
                    imported++;
                } else {
                    log.warn("演示文件未导入 {}: {}", name, result.getMessage());
                }
            } catch (Exception ex) {
                log.warn("演示数据导入失败 " + name, ex);
            }
        }
        try {
            conversionService.convert("1");
        } catch (Exception ex) {
            log.warn("演示数据转换失败: {}", ex.getMessage());
        }
        log.info("演示数据初始化完成，成功导入 {} 个报表文件", imported);
    }

    private boolean empty(String table) {
        Long count = jdbc.queryForObject("SELECT COUNT(*) FROM " + table, Long.class);
        return count == null || count == 0;
    }
}
