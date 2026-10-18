package com.qst.finance.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.qst.finance.common.BizException;
import com.qst.finance.common.Constants;
import com.qst.finance.config.AppProperties;
import com.qst.finance.mapper.DynamicTableMapper;
import com.qst.finance.mapper.ImportLogMapper;
import com.qst.finance.mapper.OrgInfoMapper;
import com.qst.finance.mapper.ReportNameMapper;
import com.qst.finance.mapper.ReportPropertyMapper;
import com.qst.finance.model.ImportLog;
import com.qst.finance.model.ImportResult;
import com.qst.finance.model.OrgInfo;
import com.qst.finance.model.ReportName;
import com.qst.finance.model.ReportProperty;
import com.qst.finance.service.ImportService;
import com.qst.finance.service.support.ImportTemplateBuilder;
import com.qst.finance.service.support.TableColumnCache;
import com.qst.finance.util.DateUtil;
import com.qst.finance.util.ExcelUtil;

/**
 * 财务数据导入实现(对应《项目需求分析》2.3 后台管理-数据导入)
 *
 * 核心思路: 依据 t_report_property 中维护的"取值版/位置版"配置解析金蝶K8导出的
 * Excel，将一级、二级科目数据写入对应的基础表，导入过程支持覆盖/跳过与失败回滚。
 */
@Service
public class ImportServiceImpl implements ImportService {

    private static final Logger log = LoggerFactory.getLogger(ImportServiceImpl.class);

    private static final Pattern YEAR_PATTERN = Pattern.compile("(?:会计年度|会计年|年度)[:：]?\\s*(\\d{4})");
    private static final Pattern MONTH_PATTERN = Pattern.compile("(?:会计期间|会计月|期间|月份)[:：]?\\s*(\\d{1,2})");
    private static final Pattern YM_PATTERN = Pattern.compile("(\\d{4})[-/年](\\d{1,2})");
    private static final Pattern ORG_PATTERN = Pattern.compile("(?:公司名称|公司|单位名称|主体)[:：]\\s*([^\\s|]+)");

    private static final Set<String> TEXT_COLUMNS = new LinkedHashSet<String>(java.util.Arrays.asList(
            "ID", "BATCH_ID", "JEDW", "IMP_USER", "IS_SURE", "FORMAT_FLAG", "KJYEAR", "KJMOTH", "KJYEAR_MONTH",
            "SUBJECT_CODE", "SUBJECT_NAME", "PARENT_CODE", "DIRECTION", "CURRENCY",
            "PROJECT_CODE", "PROJECT_NAME", "AGING_TYPE"));

    @Autowired
    private ReportNameMapper reportNameMapper;

    @Autowired
    private ReportPropertyMapper reportPropertyMapper;

    @Autowired
    private DynamicTableMapper dynamicTableMapper;

    @Autowired
    private ImportLogMapper importLogMapper;

    @Autowired
    private OrgInfoMapper orgInfoMapper;

    @Autowired
    private TableColumnCache tableColumnCache;

    @Autowired
    private ImportTemplateBuilder templateBuilder;

    @Autowired
    private AppProperties appProperties;

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public List<ReportName> templates() {
        return reportNameMapper.selectAll();
    }

    @Override
    public List<ImportLog> logs() {
        return importLogMapper.selectAll();
    }

    @Override
    public byte[] buildTemplate(String reportType, boolean sample) {
        ReportName report = reportNameMapper.selectByReportType(reportType);
        if (report == null) {
            throw new BizException("报表模板不存在");
        }
        List<ReportProperty> properties = reportPropertyMapper.selectByReportType(reportType);
        if (properties.isEmpty()) {
            throw new BizException("请先在【报表与取值配置】中维护该报表的取值配置");
        }
        return templateBuilder.build(report, properties, sample);
    }

    @Override
    public ImportResult importExcel(String reportType, MultipartFile file, Long orgId, String kjyearMonth,
                                    boolean override, String agingType, String impUser) {
        if (file == null || file.isEmpty()) {
            throw new BizException("请选择需要导入的 Excel 文件");
        }
        ReportName report = reportNameMapper.selectByReportType(reportType);
        if (report == null) {
            throw new BizException("未配置该报表的导入模板");
        }
        List<ReportProperty> properties = reportPropertyMapper.selectByReportType(reportType);
        if (properties.isEmpty()) {
            throw new BizException("报表【" + report.getReportName() + "】尚未配置取值版");
        }
        String table = report.getTableName();
        Map<String, String> tableColumns = tableColumnCache.columns(table);

        ImportResult result = new ImportResult();
        result.setReportType(reportType);
        result.setReportName(report.getReportName());
        result.setFileName(file.getOriginalFilename());
        result.setBatchId("B" + UUID.randomUUID().toString().replace("-", "").substring(0, 15).toUpperCase());
        Date start = new Date();
        try {
            List<List<String>> grid = ExcelUtil.read(file.getInputStream(), appProperties.getExcelMaxRows());
            if (grid.isEmpty()) {
                throw new BizException("Excel 内容为空");
            }
            Map<String, String> meta = parseHeaderMeta(grid);
            String yearMonth = StringUtils.isNotBlank(kjyearMonth) ? kjyearMonth.trim() : meta.get("kjyearMonth");
            if (StringUtils.isBlank(yearMonth)) {
                throw new BizException("未能识别会计年月，请在页面选择会计年月后重新导入");
            }
            result.setKjyearMonth(yearMonth);
            Long companyId = orgId != null ? orgId : resolveOrgId(meta);

            boolean longMode = "LONG".equalsIgnoreCase(report.getMapMode());
            Set<String> mappedColumns = new LinkedHashSet<String>();
            for (ReportProperty property : properties) {
                mappedColumns.add(property.getColumnCode().toUpperCase());
            }
            for (String column : mappedColumns) {
                if (!tableColumns.containsKey(column)) {
                    throw new BizException("取值配置中的字段 " + column + " 在数据表 " + table + " 中不存在");
                }
            }
            List<String> columns = new ArrayList<String>();
            columns.addAll(commonColumns(tableColumns));
            columns.addAll(mappedColumns);
            if ("AGING".equalsIgnoreCase(reportType) && tableColumns.containsKey("AGING_TYPE")) {
                columns.add("AGING_TYPE");
            }

            int exists = dynamicTableMapper.countByMonth(table, companyId, yearMonth);
            if (exists > 0 && !override) {
                result.setSkipped(true);
                result.setMessage("该月份数据已经导入，本次按【跳过】处理");
                saveLog(result, impUser, start, "SKIPPED", result.getMessage());
                return result;
            }
            List<Map<String, Object>> rows = longMode
                    ? parseLongSheet(grid, properties, yearMonth, companyId, agingType)
                    : parseWideSheet(grid, properties, yearMonth, companyId);
            writeBatch(table, columns, rows, companyId, yearMonth, exists > 0 && override);
            result.setSuccessRows(rows.size());
            result.setTotalRows(rows.size() + result.getFailRows());
            result.setMessage("导入成功，共 " + rows.size() + " 条" + (exists > 0 ? "（已覆盖原数据）" : ""));
            saveLog(result, impUser, start, "SUCCESS", result.getMessage());
            log.info("数据导入完成 table={} month={} rows={}", table, yearMonth, rows.size());
            return result;
        } catch (BizException e) {
            result.setMessage(e.getMessage());
            saveLog(result, impUser, start, "FAIL", e.getMessage());
            throw e;
        } catch (Exception e) {
            result.setMessage("导入失败: " + e.getMessage());
            saveLog(result, impUser, start, "FAIL", e.getMessage());
            throw new BizException("导入失败: " + e.getMessage());
        }
    }

    private List<String> commonColumns(Map<String, String> tableColumns) {
        List<String> columns = new ArrayList<String>();
        String[] commons = new String[]{"ID", "BATCH_ID", "ORG_ID", "KJYEAR", "KJMOTH", "KJYEAR_MONTH",
                "IMP_USER", "IMP_TIME", "IS_SURE", "FORMAT_FLAG", "ACCOUNT_PORT_TYPE"};
        for (String column : commons) {
            if (tableColumns.containsKey(column)) {
                columns.add(column);
            }
        }
        return columns;
    }

    private Map<String, String> parseHeaderMeta(List<List<String>> grid) {
        Map<String, String> meta = new LinkedHashMap<String, String>();
        int limit = Math.min(grid.size(), 10);
        for (int i = 0; i < limit; i++) {
            for (String cell : grid.get(i)) {
                if (StringUtils.isBlank(cell)) {
                    continue;
                }
                Matcher year = YEAR_PATTERN.matcher(cell);
                if (year.find()) {
                    meta.put("kjyear", year.group(1));
                }
                Matcher month = MONTH_PATTERN.matcher(cell);
                if (month.find()) {
                    String m = month.group(1);
                    meta.put("kjmoth", m.length() == 1 ? "0" + m : m);
                }
                Matcher ym = YM_PATTERN.matcher(cell);
                if (ym.find()) {
                    String m = ym.group(2);
                    meta.put("kjyearMonth", ym.group(1) + "-" + (m.length() == 1 ? "0" + m : m));
                }
                Matcher org = ORG_PATTERN.matcher(cell);
                if (org.find()) {
                    meta.put("orgName", org.group(1));
                }
            }
        }
        if (!meta.containsKey("kjyearMonth") && meta.containsKey("kjyear") && meta.containsKey("kjmoth")) {
            meta.put("kjyearMonth", meta.get("kjyear") + "-" + meta.get("kjmoth"));
        }
        return meta;
    }

    private Long resolveOrgId(Map<String, String> meta) {
        List<OrgInfo> orgs = orgInfoMapper.selectAll();
        if (orgs.isEmpty()) {
            throw new BizException("系统尚未维护公司信息");
        }
        String orgName = meta.get("orgName");
        if (StringUtils.isNotBlank(orgName)) {
            for (OrgInfo org : orgs) {
                if (org.getOrgName() != null
                        && (org.getOrgName().contains(orgName) || orgName.contains(org.getOrgName()))) {
                    return org.getId();
                }
            }
        }
        return orgs.get(0).getId();
    }

    /**
     * 横向取值版(资产负债表/利润表/现金流量表): 一行一个科目，多列对应不同取数类型
     */
    private List<Map<String, Object>> parseWideSheet(List<List<String>> grid, List<ReportProperty> properties,
                                                     String yearMonth, Long orgId) {
        Set<String> sourceColumns = new LinkedHashSet<String>();
        Map<String, List<ReportProperty>> bySubject = new LinkedHashMap<String, List<ReportProperty>>();
        for (ReportProperty property : properties) {
            if (StringUtils.isNotBlank(property.getSourceColumn())) {
                sourceColumns.add(property.getSourceColumn().trim());
            }
            List<ReportProperty> list = bySubject.get(property.getSubjectName());
            if (list == null) {
                list = new ArrayList<ReportProperty>();
                bySubject.put(property.getSubjectName(), list);
            }
            list.add(property);
        }
        int headerIndex = findHeaderRow(grid, sourceColumns);
        if (headerIndex < 0) {
            throw new BizException("未找到表头行，表头需包含: " + String.join("、", sourceColumns));
        }
        Map<String, Integer> columnIndex = indexOfHeader(grid.get(headerIndex), sourceColumns);
        /*
         * 横向取值版(资产负债表/利润表/现金流量表)在基础表中为"宽表"结构:
         * 一个会计年月对应一条记录，每个科目占用独立字段，
         * 因此需要把 Excel 中多个科目行合并为同一条记录。
         */
        Map<String, Object> row = newRow(yearMonth, orgId);
        int matched = 0;
        for (int r = headerIndex + 1; r < grid.size(); r++) {
            List<String> line = grid.get(r);
            if (line.isEmpty()) {
                continue;
            }
            String subject = null;
            for (String cell : line) {
                String value = ExcelUtil.trim(cell);
                if (bySubject.containsKey(value)) {
                    subject = value;
                    break;
                }
            }
            if (subject == null) {
                continue;
            }
            matched++;
            for (ReportProperty property : bySubject.get(subject)) {
                Integer index = columnIndex.get(property.getSourceColumn());
                if (index == null) {
                    continue;
                }
                String cell = index < line.size() ? line.get(index) : "";
                putValue(row, property.getColumnCode(), cell, property.getDefaultValue());
            }
        }
        if (matched == 0) {
            throw new BizException("未解析到有效数据行，请检查科目名称是否与取值配置一致");
        }
        List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
        rows.add(row);
        return rows;
    }

    /**
     * 明细表(科目余额表/账龄分析): 一行一条记录，每列对应一个字段
     */
    private List<Map<String, Object>> parseLongSheet(List<List<String>> grid, List<ReportProperty> properties,
                                                     String yearMonth, Long orgId, String agingType) {
        Set<String> sourceColumns = new LinkedHashSet<String>();
        for (ReportProperty property : properties) {
            if (StringUtils.isNotBlank(property.getSourceColumn())) {
                sourceColumns.add(property.getSourceColumn().trim());
            }
        }
        int headerIndex = findHeaderRow(grid, sourceColumns);
        if (headerIndex < 0) {
            throw new BizException("未找到表头行，表头需包含: " + String.join("、", sourceColumns));
        }
        Map<String, Integer> columnIndex = indexOfHeader(grid.get(headerIndex), sourceColumns);
        List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();
        for (int r = headerIndex + 1; r < grid.size(); r++) {
            List<String> line = grid.get(r);
            if (line.isEmpty()) {
                continue;
            }
            Map<String, Object> row = newRow(yearMonth, orgId);
            boolean empty = true;
            for (ReportProperty property : properties) {
                Integer index = columnIndex.get(property.getSourceColumn());
                if (index == null) {
                    continue;
                }
                String cell = index < line.size() ? line.get(index) : "";
                if (StringUtils.isNotBlank(cell)) {
                    empty = false;
                }
                putValue(row, property.getColumnCode(), cell, property.getDefaultValue());
            }
            if (empty) {
                continue;
            }
            if (StringUtils.isNotBlank(agingType)) {
                row.put("AGING_TYPE", agingType);
            }
            rows.add(row);
        }
        if (rows.isEmpty()) {
            throw new BizException("未解析到有效数据行，请检查表头是否与取值配置一致");
        }
        return rows;
    }

    private int findHeaderRow(List<List<String>> grid, Set<String> sourceColumns) {
        int best = -1;
        int bestMatch = 0;
        int limit = Math.min(grid.size(), 20);
        for (int r = 0; r < limit; r++) {
            int match = 0;
            for (String cell : grid.get(r)) {
                if (sourceColumns.contains(ExcelUtil.trim(cell))) {
                    match++;
                }
            }
            if (match > bestMatch) {
                bestMatch = match;
                best = r;
            }
        }
        return bestMatch >= 1 ? best : -1;
    }

    private Map<String, Integer> indexOfHeader(List<String> header, Set<String> sourceColumns) {
        Map<String, Integer> columnIndex = new LinkedHashMap<String, Integer>();
        for (int c = 0; c < header.size(); c++) {
            String title = ExcelUtil.trim(header.get(c));
            if (sourceColumns.contains(title) && !columnIndex.containsKey(title)) {
                columnIndex.put(title, c);
            }
        }
        return columnIndex;
    }

    private Map<String, Object> newRow(String yearMonth, Long orgId) {
        Map<String, Object> row = new LinkedHashMap<String, Object>();
        row.put("ID", UUID.randomUUID().toString().replace("-", ""));
        row.put("ORG_ID", orgId);
        row.put("KJYEAR", DateUtil.yearOf(yearMonth));
        row.put("KJMOTH", DateUtil.monthOf(yearMonth));
        row.put("KJYEAR_MONTH", yearMonth);
        row.put("IS_SURE", Constants.FLAG_N);
        row.put("FORMAT_FLAG", Constants.FLAG_N);
        row.put("ACCOUNT_PORT_TYPE", 1L);
        row.put("IMP_TIME", new java.sql.Timestamp(System.currentTimeMillis()));
        return row;
    }

    private void putValue(Map<String, Object> row, String columnCode, String cell, String defaultValue) {
        String column = columnCode.toUpperCase();
        if (TEXT_COLUMNS.contains(column)) {
            row.put(column, StringUtils.isBlank(cell) ? defaultValue : ExcelUtil.trim(cell));
        } else {
            row.put(column, ExcelUtil.toDecimal(StringUtils.isBlank(cell) ? defaultValue : cell));
        }
    }

    private void writeBatch(String table, List<String> columns, List<Map<String, Object>> rows,
                            Long orgId, String yearMonth, boolean override) {
        SqlSession session = sqlSessionTemplate.getSqlSessionFactory().openSession(ExecutorType.BATCH, false);
        try {
            DynamicTableMapper mapper = session.getMapper(DynamicTableMapper.class);
            if (override) {
                mapper.deleteByMonth(table, orgId, yearMonth);
            }
            int i = 0;
            for (Map<String, Object> row : rows) {
                mapper.insertOne(table, columns, row);
                if (++i % appProperties.getImportBatchSize() == 0) {
                    session.flushStatements();
                }
            }
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw new BizException("数据入库失败(已回滚): " + e.getMessage());
        } finally {
            session.close();
        }
    }

    private void saveLog(ImportResult result, String impUser, Date start, String status, String message) {
        ImportLog importLog = new ImportLog();
        importLog.setBatchId(result.getBatchId());
        importLog.setReportType(result.getReportType());
        importLog.setReportName(result.getReportName());
        importLog.setFileName(result.getFileName() == null ? "-" : result.getFileName());
        importLog.setTotalRows(result.getTotalRows());
        importLog.setSuccessRows(result.getSuccessRows());
        importLog.setFailRows(result.getFailRows());
        importLog.setStatus(status);
        importLog.setMessage(message);
        importLog.setImpUser(impUser);
        importLog.setStartTime(start);
        importLog.setEndTime(new Date());
        importLogMapper.insert(importLog);
        result.setStatus(status);
    }
}
